package edu.sm.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.security.web.csrf.CsrfTokenRepository;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;

public class SameSiteCookieCsrfTokenRepository implements CsrfTokenRepository {

    private final CookieCsrfTokenRepository delegate = CookieCsrfTokenRepository.withHttpOnlyFalse();

    @Override
    public CsrfToken generateToken(HttpServletRequest request) {
        return delegate.generateToken(request);
    }

    @Override
    public void saveToken(CsrfToken token, HttpServletRequest request, HttpServletResponse response) {
        delegate.saveToken(token, request, response);
        String header = "Set-Cookie";
        String original = response.getHeader(header);
        if (original != null && original.contains("XSRF-TOKEN")) {
            // 기존에 SameSite만 추가했을 경우 → 여기서 명시적으로 HttpOnly도 추가
            if (!original.toLowerCase().contains("httponly")) {
                response.setHeader(header, original + "; HttpOnly; SameSite=Strict");
            }
        }
    }


    @Override
    public CsrfToken loadToken(HttpServletRequest request) {
        return delegate.loadToken(request);
    }
}
