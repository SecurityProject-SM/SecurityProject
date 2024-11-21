package edu.sm.controller;


import edu.sm.app.dto.RepairsDto;
import edu.sm.app.service.RepairsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/repairs")
public class ReapairsRestController {
    private final RepairsService repairsService;

    @RequestMapping("/getrepairs")
    public Object getRepairs() throws Exception {
        List<RepairsDto> repairs=repairsService.get();
        JSONArray array = new JSONArray();

        for(RepairsDto repair :repairs){
            JSONObject obj = new JSONObject();
            obj.put("repairId",repair.getRepairId());
            obj.put("buildingId",repair.getBuildingId());
            obj.put("iotId",repair.getIotId());
            obj.put("repairStat",repair.getRepairStat());
            obj.put("repairStart",repair.getRepairStart());
            obj.put("repairLoc",repair.getRepairLoc());
            array.add(obj);
        }
        JSONObject rsult = new JSONObject();
        rsult.put("repairsData",array);
        return rsult;
    }

}
