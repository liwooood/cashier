package com.cssweb.payment.cashier.web;



import com.cssweb.payment.common.BasicResponse;
import com.cssweb.payment.common.ServiceConfig;
import com.cssweb.payment.topup.sei.TopupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
public class HelloController {
    @Autowired
    private TopupService topupService;

    @RequestMapping(value="/hello.do")
	public String printWelcome(ModelMap model) {
		model.addAttribute("message", "Hello world demo!");



       // ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(new String[] {"TopupService-bak.xml"});
        //TopupService topupService = (TopupService)context.getBean("topupService"); // 获取远程服务代理

       // ServiceConfig serviceConfig = new ServiceConfig();
        //TopupService topupService = serviceConfig.getTopupService();

        BasicResponse res = topupService.topup();
        System.out.println("res = " + res.getRetMsg());
/*
        Date now = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String orderTime = sdf.format(now);

        BigDecimal orderAmount = new BigDecimal("100.1");
        String merchantNo = "6124";
        String curCode = "001";
        String orderNo = "000002";
        String orderDesc = "test;";

        String signData = bankService.payment(merchantNo, orderNo, curCode, orderAmount, orderTime, orderDesc);
System.out.println("signData=" + signData);
*/
        return "hello";
	}
}