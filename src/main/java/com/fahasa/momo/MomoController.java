package com.fahasa.momo;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fahasa.model.MomoResult;
import com.fahasa.model.Order;
import com.fahasa.service.OrderService;
import com.fasterxml.jackson.core.JsonProcessingException;
@CrossOrigin("*")
@RestController
@RequestMapping("/orders")
public class MomoController {

	@Autowired
	private MomoService momoService;

	@Autowired
	OrderService service;

	@GetMapping("/momo-pay/{id}")
	@ResponseBody
	public String momoPay(@PathVariable("id") Integer id)
			throws NoSuchAlgorithmException, InvalidKeyException, JsonProcessingException {
		Order sessionOrder = service.findById(id);

		MomoResponse response = momoService.createMomoPayment(sessionOrder);

		return response.getPayUrl();
	}

	@GetMapping("momo-result")
	@ResponseBody
	public MomoResult result(@RequestParam("partnerCode") String partnerCode, @RequestParam("orderId") String orderId,
			@RequestParam("requestId") String requestId, @RequestParam("amount") String amount,
			@RequestParam("orderInfo") String orderInfo, @RequestParam("orderType") String orderType,
			@RequestParam("transId") String transId, @RequestParam("resultCode") int resultCode,
			@RequestParam("message") String message, @RequestParam("payType") String payType,
			@RequestParam("responseTime") String responseTime, @RequestParam("extraData") String extraData,
			@RequestParam("signature") String signature) {

		MomoResult result = new MomoResult();
		result.setPartnerCode(partnerCode);
		result.setOrderId(orderId);
		result.setRequestId(requestId);
		result.setAmount(amount);
		result.setOrderInfo(orderInfo);
		result.setOrderType(orderType);
		result.setTransId(transId);
		result.setResultCode(resultCode);
		result.setMessage(message);
		result.setPayType(payType);
		result.setResponseTime(responseTime);
		result.setExtraData(extraData);
		result.setSignature(signature);
		
		System.out.println(result.getResultCode());

//        Order order = orderService.getSessionOrder(session);
//        if (order != null) {
//            order.setPaymentMethod(PaymentMethod.Momo);
//            if (result.getResultCode() == 0)
//            {
//                order.setStatus(OrderStatus.Completed);
//                order.setPaymentStatus(PaymentStatus.Paid);
//            }
//            else {
//                order.setStatus(OrderStatus.Failed);
//                order.setPaymentStatus(PaymentStatus.Unpaid);
//            }
//            orderService.save(order);
//        }
//
//        cartService.removeCart(session);
//        orderService.removeSessionOrder(session);

		System.out.println("thanh toán thành công");
		return result;
	}
}
