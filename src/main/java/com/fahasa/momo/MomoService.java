package com.fahasa.momo;

import java.math.BigDecimal;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fahasa.model.Order;
import com.fahasa.service.OrderService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class MomoService {
	@Autowired
    private Environment env;
	
	@Autowired
	OrderService service;
	
	@Autowired
    private RestTemplate restTemplate;
	
	public MomoResponse createMomoPayment(Order order) 
			throws NoSuchAlgorithmException, InvalidKeyException, JsonProcessingException {
        
		String endPoint = env.getProperty("payment.momo.endpoint");
        String ipnUrl = env.getProperty("payment.momo.ipnUrl");
        
        
        String partnerCode = env.getProperty("payment.momo.partner-code");
        String accessKey = env.getProperty("payment.momo.access-key");
        String secretKey = env.getProperty("payment.momo.secret-key");
        
        String requestType = "captureWallet";
        
        String redirectUrl = "http://localhost:3000/success/" + order.getId();
//        
        String orderInfo = "Khách hàng: " + service.findById(order.getId()).getReceiver();
        System.out.println(new BigDecimal(order.getTotalamount()).toPlainString());
        String amount = new BigDecimal(order.getTotalamount()).toPlainString(); // Xóa dấu phẩy
        String orderId = order.getId().toString() + order.getOrderdate().getTime();
        String requestId = java.util.UUID.randomUUID().toString();
        String extraData = "";
        
        List<MomoItem> items = 
        		order.getOrderdetails().stream()
        		.map(
        				x -> {
        					if(x.getBook() != null) {
        						return new MomoItem(x.getBook().getId().toString(), x.getBook().getTitle());
        					}else {
        						return new MomoItem(x.getSchooltool().getId().toString(), x.getSchooltool().getTitle());
        					}
        				}
        		)
        		.toList();
//
        String rawHash = "accessKey=" + accessKey +
                "&amount=" + amount +
                "&extraData=" + extraData +
                "&ipnUrl=" + ipnUrl +
                "&orderId=" + orderId +
                "&orderInfo=" + orderInfo +
                "&partnerCode=" + partnerCode +
                "&redirectUrl=" + redirectUrl +
                "&requestId=" + requestId +
                "&requestType=" + requestType;
//
        MomoSecurity crypto = new MomoSecurity();
        // Sign signature SHA256
        String signature = crypto.signSHA256(rawHash, secretKey);
//
        MomoRequest momoMessage = new MomoRequest();
        momoMessage.setPartnerCode(partnerCode);
        momoMessage.setPartnerName("MinieShop");
        momoMessage.setStoreId("MinieShop");
        momoMessage.setRequestId(requestId);
        momoMessage.setAmount(amount);
        momoMessage.setOrderId(orderId);
        momoMessage.setOrderInfo(orderInfo);
        momoMessage.setRedirectUrl(redirectUrl);
        momoMessage.setIpnUrl(ipnUrl);
        momoMessage.setLang("vi");
        momoMessage.setExtraData(extraData);
        momoMessage.setRequestType(requestType);
        momoMessage.setItems(items);
        momoMessage.setSignature(signature);
//
        String result = restTemplate.postForObject(endPoint, 
        		momoMessage, String.class);

        ObjectMapper objectMapper = new ObjectMapper();
        System.out.println(result);

        return objectMapper.readValue(result, MomoResponse.class);
    }
}
