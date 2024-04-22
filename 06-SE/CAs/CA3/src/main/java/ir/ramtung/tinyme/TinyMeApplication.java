package ir.ramtung.tinyme;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.jms.annotation.EnableJms;

@SpringBootApplication
@EnableJms
public class TinyMeApplication {

	public static void main(String[] args) {
		SpringApplication.run(TinyMeApplication.class, args);
	}
}
