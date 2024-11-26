package edu.sm.controller;

import edu.sm.app.dto.OcrDto;
import edu.sm.util.FileUploadUtil;
import edu.sm.util.OCRUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
public class OcrController {

    @Value("${app.dir.uploadimgdir}")

    @RequestMapping("/ocrimpl")
    public String ocrimpl(Model model, OcrDto ocrDto) throws IOException {
        String imgname = ocrDto.getImage().getOriginalFilename();

        FileUploadUtil.saveFile(ocrDto.getImage(), uploadImgDir);
        JSONObject jsonObject = OCRUtil.getResult(uploadImgDir, imgname);
        Map<String, String> map = OCRUtil.getData(jsonObject);

        model.addAttribute("result",map);
        model.addAttribute("imgname",imgname);
        model.addAttribute("center","ocr");
        return "index";
    }
}
