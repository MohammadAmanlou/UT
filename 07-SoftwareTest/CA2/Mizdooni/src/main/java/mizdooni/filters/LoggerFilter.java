package mizdooni.filters;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;

import java.io.IOException;

public class LoggerFilter implements Filter {
    private Logger logger = LoggerFactory.getLogger(LoggerFilter.class);

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String reqPath = req.getMethod() + " " + req.getRequestURI();
        if (req.getQueryString() != null) {
            reqPath += "?" + req.getQueryString();
        }

        logger.info("Request: " + reqPath);
        chain.doFilter(request, response);
        logger.info("Response: " + HttpStatus.valueOf(res.getStatus()));
    }
}
