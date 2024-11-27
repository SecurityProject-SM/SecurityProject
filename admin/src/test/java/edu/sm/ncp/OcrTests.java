package edu.sm.ncp;

import edu.sm.util.OCRUtil;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class OcrTests {

    //  yml의 경로 확인
    @Value("${app.dir.uploadimgdir}")
    String dir;

    @Value("${app.url.ocr-url}")
    String url;

    @Value("${app.key.ocr-key}")
    String key;

    @Test
    void contextLoads() {
        String imgname = "realcar.jpg";
        JSONObject jsonObject = OCRUtil.getResult(url, key, dir,imgname);
        log.info(jsonObject.toJSONString());

        String carNumber = OCRUtil.getCarNumber(jsonObject);
        log.info(carNumber);

    }

}
