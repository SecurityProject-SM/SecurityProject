package edu.sm.app.frame;

import edu.sm.app.dto.ParkDto;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface SBService<K,V>{
    @Transactional
    void add(V v) throws Exception;
    @Transactional
    void modify(V v) throws Exception;
    @Transactional
    void del(K k) throws Exception;
    V get(K k) throws Exception;
    List<V> get() throws Exception;

    List<ParkDto> findByCarNumber() throws Exception;
}
