package edu.sm.exception;


import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;

@ControllerAdvice
@Slf4j
public class ExceptionHandler {
    @org.springframework.web.bind.annotation.ExceptionHandler(DuplicateKeyException.class)
    public String ex2(Model model , DuplicateKeyException e) {
        model.addAttribute("msg", "ID중복 에러");
        model.addAttribute("center", "error");
        return "index";
    }

    @org.springframework.web.bind.annotation.ExceptionHandler(Exception.class)
    public String ex1(Model model , Exception e) {
        model.addAttribute("msg", e.getMessage());
        model.addAttribute("center", "error");
        return "index";
    }
}
