package mizdooni.config.error;

import org.springframework.boot.web.servlet.error.ErrorAttributes;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
class CustomErrorAttributesConfig {
    @Bean
    public ErrorAttributes errorAttributes() {
        return new CustomErrorAttributes();
    }
}
