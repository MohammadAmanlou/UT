package ir.ramtung.tinyme.config;

import ir.ramtung.tinyme.messaging.EventPublisher;
import ir.ramtung.tinyme.messaging.RequestDispatcher;
import ir.ramtung.tinyme.repository.DataLoader;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.boot.test.mock.mockito.MockBean;

@TestConfiguration
public class MockedJMSTestConfig {
    @MockBean
    EventPublisher eventPublisher;
    @MockBean
    RequestDispatcher requestDispatcher;
}
