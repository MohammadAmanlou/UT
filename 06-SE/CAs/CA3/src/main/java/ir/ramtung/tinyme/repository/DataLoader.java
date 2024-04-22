package ir.ramtung.tinyme.repository;

import com.opencsv.CSVReader;
import com.opencsv.CSVReaderBuilder;
import ir.ramtung.tinyme.domain.entity.*;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;

import java.io.FileReader;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.io.Reader;
import java.time.LocalDateTime;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.StringJoiner;
import java.util.logging.Logger;

@Component
@Profile("!test")
public class DataLoader {
    private final Logger log = Logger.getLogger(this.getClass().getName());
    private final BrokerRepository brokerRepository;
    private final ShareholderRepository shareholderRepository;
    private final SecurityRepository securityRepository;

    public DataLoader(BrokerRepository brokerRepository, ShareholderRepository shareholderRepository, SecurityRepository securityRepository) {
        this.brokerRepository = brokerRepository;
        this.shareholderRepository = shareholderRepository;
        this.securityRepository = securityRepository;
    }

    @Value("classpath:persistence/broker.csv")
    private Resource brokerCsvResource;
    @Value("classpath:persistence/shareholder.csv")
    private Resource shareholderCsvResource;
    @Value("classpath:persistence/security.csv")
    private Resource securityCsvResource;
    @Value("classpath:persistence/position.csv")
    private Resource positionCsvResource;
    @Value("classpath:persistence/orderbook.csv")
    private Resource orderBookCsvResource;

    @PostConstruct
    public void loadAll() throws Exception {
        loadBrokers();
        loadShareholders();
        loadSecurities();
        loadPositions();
        loadOrderBook();
    }

    @PreDestroy
    public void saveAll() throws Exception {
        System.out.print("Saving persistent data ...");
        saveBrokers();
        saveShareholdersAndPositions();
        saveSecuritiesAndOrderBooks();
        System.out.println(", done!");
    }

    private void loadBrokers() throws Exception {
        brokerRepository.clear();
      try (Reader reader = new FileReader(brokerCsvResource.getFile())) {
            try (CSVReader csvReader = new CSVReaderBuilder(reader).withSkipLines(1).build()) {
                String[] line;
                while ((line = csvReader.readNext()) != null) {
                    brokerRepository.addBroker(Broker.builder()
                            .brokerId(Long.parseLong(line[0]))
                            .name(line[1])
                            .credit(Long.parseLong(line[0]))
                            .build());
                }
            }
        }
        log.info("Brokers loaded");
    }

    private void loadShareholders() throws Exception {
        shareholderRepository.clear();
        try (Reader reader = new FileReader(shareholderCsvResource.getFile())) {
            try (CSVReader csvReader = new CSVReaderBuilder(reader).withSkipLines(1).build()) {
                String[] line;
                while ((line = csvReader.readNext()) != null) {
                    shareholderRepository.addShareholder(Shareholder.builder()
                            .shareholderId(Long.parseLong(line[0]))
                            .name(line[1])
                            .build());
                }
            }
        }
        log.info("Shareholders loaded");
    }

    private void loadSecurities() throws Exception {
        securityRepository.clear();
        try (Reader reader = new FileReader(securityCsvResource.getFile())) {
            try (CSVReader csvReader = new CSVReaderBuilder(reader).withSkipLines(1).build()) {
                String[] line;
                while ((line = csvReader.readNext()) != null) {
                    securityRepository.addSecurity(Security.builder()
                            .isin(line[0])
                            .tickSize(Integer.parseInt(line[1]))
                            .lotSize(Integer.parseInt(line[2]))
                            .build());
                }
            }
        }
        log.info("Securities loaded");
    }

    private void loadPositions() throws Exception {
        try (Reader reader = new FileReader(positionCsvResource.getFile())) {
            try (CSVReader csvReader = new CSVReaderBuilder(reader).withSkipLines(1).build()) {
                String[] line;
                while ((line = csvReader.readNext()) != null) {
                    Shareholder shareholder = shareholderRepository.findShareholderById(Long.parseLong(line[0]));
                    Security security = securityRepository.findSecurityByIsin(line[1]);
                    shareholder.incPosition(security, Integer.parseInt(line[2]));
                }
            }
        }
        log.info("Positions loaded");
    }

    private void loadOrderBook() throws Exception {
        LinkedList<Order> orders = new LinkedList<>();
        try (Reader reader = new FileReader(orderBookCsvResource.getFile())) {
            try (CSVReader csvReader = new CSVReaderBuilder(reader).withSkipLines(1).build()) {
                String[] line;
                while ((line = csvReader.readNext()) != null) {
                    Security security = securityRepository.findSecurityByIsin(line[1]);
                    Broker broker = brokerRepository.findBrokerById(Long.parseLong(line[5]));
                    Shareholder shareholder = shareholderRepository.findShareholderById(Long.parseLong(line[6]));
//orderId,isin,side,quantity,price,brokerId,shareholderId,entryTime,peakSize,displayedQuantity
//0       1    2    3        4     5        6             7         8        9
                    int peakSize = Integer.parseInt(line[8]);
                    Order order;
                    if (peakSize == 0) {
                        order = new Order(
                                Long.parseLong(line[0]),
                                security,
                                Side.parse(line[2]),
                                Integer.parseInt(line[3]),
                                Integer.parseInt(line[4]),
                                broker,
                                shareholder,
                                LocalDateTime.parse(line[7]),
                                OrderStatus.QUEUED);
                    } else {
                        order = new IcebergOrder(
                                Long.parseLong(line[0]),
                                security,
                                Side.parse(line[2]),
                                Integer.parseInt(line[3]),
                                Integer.parseInt(line[4]),
                                broker,
                                shareholder,
                                LocalDateTime.parse(line[7]),
                                Integer.parseInt(line[8]),
                                Integer.parseInt(line[9]),
                                OrderStatus.QUEUED);
                    }
                    orders.addFirst(order);
                }
            }
        }
        Iterator<Order> it = orders.descendingIterator();
        while (it.hasNext()) {
            Order order = it.next();
            order.getSecurity().getOrderBook().enqueue(order);
        }
        log.info("Order Book loaded");
    }

    private void saveBrokers() throws Exception {
        try (PrintWriter writer = new PrintWriter(new FileWriter(brokerCsvResource.getFile()))) {
            writer.println("brokerId,name,credit");
            for (Broker broker : brokerRepository.allBrokers()) {
                StringJoiner joiner = new StringJoiner(",");
                joiner.add(String.valueOf(broker.getBrokerId()))
                        .add(broker.getName())
                        .add(String.valueOf(broker.getCredit()));
                writer.println(joiner);
            }
        }
        log.info("Brokers saved");
    }

    private void saveShareholdersAndPositions() throws Exception {
        try (PrintWriter shareholderWriter = new PrintWriter(new FileWriter(shareholderCsvResource.getFile()))) {
            shareholderWriter.println("shareholderId,name");
            try (PrintWriter positionWriter = new PrintWriter(new FileWriter(positionCsvResource.getFile()))) {
                positionWriter.println("shareholderId,isin,positions");
                for (Shareholder shareholder : shareholderRepository.allShareholders()) {
                    StringJoiner joiner = new StringJoiner(",");
                    joiner.add(String.valueOf(shareholder.getShareholderId()))
                            .add(shareholder.getName());
                    shareholderWriter.println(joiner);
                    for (var entry : shareholder.getPositions().entrySet()) {
                        StringJoiner posJoiner = new StringJoiner(",");
                        posJoiner.add(String.valueOf(shareholder.getShareholderId()))
                                .add(entry.getKey().getIsin())
                                .add(String.valueOf(entry.getValue()));
                        positionWriter.println(posJoiner);
                    }
                }
            }
        }
        log.info("Shareholders and Positions saved");
    }

    private void saveSecuritiesAndOrderBooks() throws Exception {
        try (PrintWriter securityWriter = new PrintWriter(new FileWriter(securityCsvResource.getFile()))) {
            securityWriter.println("isin,tickSize,lotSize");
            try (PrintWriter orderBookWriter = new PrintWriter(new FileWriter(orderBookCsvResource.getFile()))) {
                orderBookWriter.println("orderId,isin,side,quantity,price,brokerId,shareholderId,entryTime,status,peakSize,displayedQuantity");
                for (Security security : securityRepository.allSecurities()) {
                    StringJoiner joiner = new StringJoiner(",");
                    joiner.add(security.getIsin())
                            .add(String.valueOf(security.getTickSize()))
                            .add(String.valueOf(security.getLotSize()));
                    securityWriter.println(joiner);
                    for (Order order : security.getOrderBook().getBuyQueue())
                        orderBookWriter.println(getCSVString(order));
                    for (Order order : security.getOrderBook().getSellQueue())
                        orderBookWriter.println(getCSVString(order));
                }
            }
        }
        log.info("Securities and OrderBook saved");
    }

    private static String getCSVString(Order order) {
        StringJoiner orderJoiner = new StringJoiner(",");
        orderJoiner.add(String.valueOf(order.getOrderId()))
                .add(order.getSecurity().getIsin())
                .add(order.getSide().toString())
                .add(String.valueOf(order.getQuantity()))
                .add(String.valueOf(order.getPrice()))
                .add(String.valueOf(order.getBroker().getBrokerId()))
                .add(String.valueOf(order.getShareholder().getShareholderId()))
                .add(order.getEntryTime().toString());
        if (order instanceof IcebergOrder icebergOrder) {
            orderJoiner.add(String.valueOf(icebergOrder.getPeakSize()))
                    .add(String.valueOf(icebergOrder.getDisplayedQuantity()));
        } else {
            orderJoiner.add("0").add("0");
        }
        return orderJoiner.toString();
    }

}
