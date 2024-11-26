package edu.sm.controller;

import edu.sm.app.dto.RepairsDto;
import edu.sm.app.service.RepairsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
public class RepairsRestController {
    private final RepairsService repairsService;

    //DB값 불러오기
    @GetMapping("/getrepairs")
    public Object getRepairs() throws Exception {
        List<RepairsDto> repairs = repairsService.get();
        JSONArray array = new JSONArray();

        for(RepairsDto repair : repairs) {
            JSONObject obj = new JSONObject();
            obj.put("repairId", repair.getRepairId());
            obj.put("buildingId", repair.getBuildingId());
            obj.put("iotId", repair.getIotId());
            obj.put("repairStat", repair.getRepairStat());
            obj.put("repairStart", repair.getRepairStart());
            obj.put("repairLoc", repair.getRepairLoc());
            array.add(obj);
        }
        log.info(array.toString());
        JSONObject result = new JSONObject();
        result.put("repairsData", array);
        return result;
    }
    // DB상태 업데이트 A or B
    @PostMapping("/updateRepairStatus")
    public Object updateRepairStatus(RepairsDto repairsDto) throws Exception {
        repairsService.modify(repairsDto);

        return repairsDto;
    }
}























