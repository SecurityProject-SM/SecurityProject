package edu.sm.controller;

import edu.sm.app.dto.OcrDto;
import edu.sm.app.dto.ParkLogDto;
import edu.sm.app.service.ParkLogService;
import edu.sm.util.FileUploadUtil;
import edu.sm.util.OCRUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Slf4j
@RestController
@RequiredArgsConstructor
public class OcrController {

    @Value("${app.dir.uploadimgdir}")
    String uploadImgDir;

    @Value("${app.url.ocr-url}")
    String ocrUrl;

    @Value("${app.key.ocr-key}")
    String ocrKey;

    final private ParkLogService parkLogService;
//    @RequestMapping("/ocrimpl")
//    public String ocrimpl(Model model, OcrDto ocrDto) throws IOException {
//        String imgname = ocrDto.getImage().getOriginalFilename();
//
//        FileUploadUtil.saveFile(ocrDto.getImage(), uploadImgDir);
//        JSONObject jsonObject = OCRUtil.getResult(uploadImgDir, imgname);
//        Map<String, String> map = OCRUtil.getCarNumber(jsonObject);
//
//        model.addAttribute("result",map);
//        model.addAttribute("imgname",imgname);
//        model.addAttribute("center","ocr");
//        return "index";
//    }
    @RequestMapping("/saveimg")
    @ResponseBody
    public String saveimg(@RequestParam("file") MultipartFile file) throws IOException {
        String imgname = file.getOriginalFilename();
        FileUploadUtil.saveFile(file, uploadImgDir);
        return imgname;
    }

    @PostMapping("/ocr/check-car-number")
    public ResponseEntity<?> checkCarNumber(@RequestParam("file") MultipartFile file) {
        try {
            // 1. 이미지 저장
            String fileName = UUID.randomUUID().toString() + ".jpg";
            File savedFile = new File(uploadImgDir, fileName);
            file.transferTo(savedFile);

            // 2. OCR로 차량 번호 추출
            JSONObject ocrResponse = OCRUtil.getResult(ocrUrl, ocrKey, uploadImgDir, fileName);
            String carNumber = OCRUtil.getCarNumber(ocrResponse);


            if (carNumber == null) {
                // 차량 번호 인식 실패
                Map<String, Object> response = new HashMap<>();
                response.put("message", "차량 번호를 인식하지 못했습니다.");
                response.put("carNumber", null);
                response.put("entryTime", null);
                response.put("exitTime", null);
                return ResponseEntity.ok(response);
            }

            // 3. DB에서 차량 번호로 입차 시간 조회
            ParkLogDto parkLog = parkLogService.findByCarNumber(carNumber);
            if (parkLog != null) {
                Map<String, Object> response = new HashMap<>();
                response.put("message", "차량 번호가 확인되었습니다.");
                response.put("carNumber", carNumber);
                response.put("entryTime", parkLog.getCarIn());
                response.put("exitTime", parkLog.getCarOut());
                return ResponseEntity.ok(response);
            } else {
                Map<String, Object> response = new HashMap<>();
                response.put("message", "차량 번호가 일치하지 않습니다.");
                response.put("carNumber", carNumber);
                response.put("entryTime", null);
                response.put("exitTime", null);
                return ResponseEntity.ok(response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> response = new HashMap<>();
            response.put("message", "서버 오류가 발생했습니다.");
            response.put("carNumber", null);
            response.put("entryTime", null);
            response.put("exitTime", null);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}
