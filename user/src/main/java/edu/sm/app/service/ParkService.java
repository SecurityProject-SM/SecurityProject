package edu.sm.app.service;

import edu.sm.app.dto.ParkDto;
import edu.sm.app.frame.SBService;
import edu.sm.app.repository.ParkRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ParkService implements SBService<Integer, ParkDto> {

    final ParkRepository parkRepository;

    @Override
    public void add(ParkDto parkDto) throws Exception {
        parkRepository.insert(parkDto);
    }

    @Override
    public void modify(ParkDto parkDto) throws Exception {
        parkRepository.update(parkDto);
    }

    @Override
    public void del(Integer integer) throws Exception {
        parkRepository.delete(integer);
    }

    @Override
    public ParkDto get(Integer integer) throws Exception {
        return parkRepository.selectOne(integer);
    }

    @Override
    public List<ParkDto> get() throws Exception {
        return parkRepository.select();
    }


//    // 차량 번호를 통해 차량 정보를 조회하는 메서드
//    public ParkDto findByCarNumber(String carNumber) {
//        return parkRepository.findByCarNumber(carNumber);
//    }
//
//    public JSONObject parksetsum(String carNumber) {
//        JSONObject feeResult = new JSONObject();
//        ParkDto park = findByCarNumber(carNumber);
//        if (park == null) {
//            feeResult.put("error", "해당 차량 번호를 찾을 수 없습니다.");
//            log.info("해당 차량 번호를 찾을 수 없습니다: {}", carNumber);
//            return feeResult;
//        }
//
//        LocalDateTime carIn = park.getCarIn();
//        LocalDateTime carOut = park.getCarOut();
//        if (carOut == null) {
//            carOut = LocalDateTime.now();
//        }
//
//        log.info("Received carIn: {}", carIn);
//        log.info("Received carOut: {}", carOut);
//
//        int initialFee = 3000;
//        int additionalFee = 5000;
//        int maxDailyFee = 60000;
//
//        Duration duration = Duration.between(carIn, carOut);
//        long totalMinutes = duration.toMinutes();
//        long totalDays = totalMinutes / (24 * 60); // 총 일 수 계산
//        long remainingMinutes = totalMinutes % (24 * 60); // 남은 분 계산
//        long remainingHours = remainingMinutes / 60; // 남은 시간을 시간 단위로 계산
//        long remainingMinutesOnly = remainingMinutes % 60; // 남은 분 계산
//
//        // 남은 시간에 대한 요금 계산
//        int remainingFee = (remainingMinutes <= 30) ? initialFee
//                : initialFee + (int) Math.ceil((remainingMinutes - 30) / 30.0) * additionalFee;
//
//        // 남은 시간 요금이 일일 최대 요금을 초과하지 않도록 제한
//        if (remainingFee > maxDailyFee) {
//            remainingFee = maxDailyFee;
//        }
//
//        // 총 요금 = (총 일수 * 일일 최대 요금) + 남은 시간 요금
//        int totalFee = (int) (totalDays * maxDailyFee + remainingFee);
//
//        log.info("Total days: {}", totalDays);
//        log.info("Total hours: {}", remainingHours);
//        log.info("Total minutes only: {}", remainingMinutesOnly);
//        log.info("Total minutes parked: {}", totalMinutes);
//        log.info("Calculated total fee: {}원", totalFee);
//
//        // 총 주차 시간을 일, 시간, 분 단위로 표시
//        String totalTimeFormatted = totalDays + "일 " + remainingHours + "시간 " + remainingMinutesOnly + "분";
//
//        feeResult.put("totalTime", totalTimeFormatted);
//        feeResult.put("totalFee", totalFee);
//        return feeResult;
//    }

}
