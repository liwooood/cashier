<%
/*
 * @(#)MerchantPaymentIE.jsp	V1.0	2009/06/29
 *
 * Project: BJP03004
 *
 * Description:
 *    �̻�֧������������
 *
 * Modify Information:
 *    Author        Date        Description
 *    ============  ==========  =======================================
 *    ABC       	2009/06/29  V1.0 Release
 *
 * Copyright Notice:
 *   Copyright (c) 2001-2004 Beijing HiTRUST Technology Co., Ltd.
 *   1808 Room, Science & Technology Building, No. 9 South Street,
 *   Zhong Guan Cun, Haidian District, Beijing ,100081, China
 *   All rights reserved.
 *
 *   This software is the confidential and proprietary information of
 *   HiTRUST.COM, Inc. ("Confidential Information"). You shall not
 *   disclose such Confidential Information and shall use it only in
 *   accordance with the terms of the license agreement you entered
 *   into with HiTRUST.
 */
%>
<%@ page pageEncoding="gb2312" %>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "com.hitrust.trustpay.client.b2c.*" %>
<%@ page import = "com.hitrust.trustpay.client.*" %>
<% response.setHeader("Cache-Control", "no-cache"); %>
<% request.setCharacterEncoding("gb2312"); %>
<%
//1��ȡ��֧����������Ҫ����Ϣ
String tOrderNo         = request.getParameter("OrderNo"        );
String tExpiredDate     = request.getParameter("ExpiredDate"        );
String tOrderDesc       = request.getParameter("OrderDesc"      );
String tOrderDate       = request.getParameter("OrderDate"      );
String tOrderTime       = request.getParameter("OrderTime"      );
String tOrderAmountStr  = request.getParameter("OrderAmount"    );
String tOrderURL        = request.getParameter("OrderURL"       );
String tProductType     = request.getParameter("ProductType"    );
String tPaymentType     = request.getParameter("PaymentType"    );
String tNotifyType      = request.getParameter("NotifyType"     );
String tResultNotifyURL = request.getParameter("ResultNotifyURL");
String tMerchantRemarks = request.getParameter("MerchantRemarks");
double  tOrderAmount    = Double.parseDouble(tOrderAmountStr);
String tPaymentLinkType = request.getParameter("PaymentLinkType");
String tBuyIP = request.getParameter("BuyIP");
String tSignature="";
//2�����ɶ�������
Order tOrder = new Order();
tOrder.setOrderNo    (tOrderNo    ); //�趨������� ����Ҫ��Ϣ��
tOrder.setExpiredDate (new Integer(tExpiredDate).intValue()); //�趨������Ч�� ����Ҫ��Ϣ��
tOrder.setOrderDesc  (tOrderDesc  ); //�趨����˵��
tOrder.setOrderDate  (tOrderDate  ); //�趨�������� ����Ҫ��Ϣ - YYYY/MM/DD��
tOrder.setOrderTime  (tOrderTime  ); //�趨����ʱ�� ����Ҫ��Ϣ - HH:MM:SS��
tOrder.setOrderAmount(tOrderAmount); //�趨������� ����Ҫ��Ϣ��
tOrder.setOrderURL   (tOrderURL   ); //�趨������ַ
tOrder.setBuyIP   (tBuyIP   );       //�趨����IP
//3�����ɶ����������󣬲���������ϸ���붨���У���ѡ��Ϣ��
tOrder.addOrderItem(new OrderItem("IP000001", "�й��ƶ�IP��", 100.00f, 1));
tOrder.addOrderItem(new OrderItem("IP000002", "��ͨIP��"    ,  90.00f, 2));

MerchantConfig tMerchantConfig=MerchantConfig.getUniqueInstance();;
String sTrustPayIETrxURL=tMerchantConfig.getTrustPayIETrxURL();
String sErrorUrl=tMerchantConfig.getMerchantErrorURL();

//4������֧���������
PaymentRequest tPaymentRequest = new PaymentRequest();
tPaymentRequest.setOrder      (tOrder      ); //�趨֧������Ķ��� ����Ҫ��Ϣ��
tPaymentRequest.setProductType(tProductType); //�趨��Ʒ���� ����Ҫ��Ϣ��
                                              //PaymentRequest.PRD_TYPE_ONE����ʵ����Ʒ�������IP��������MP3��...
                                              //PaymentRequest.PRD_TYPE_TWO��ʵ����Ʒ
tPaymentRequest.setPaymentType(tPaymentType); //�趨֧������
                                              //PaymentRequest.PAY_TYPE_ABC��ũ�п�֧��
                                              //PaymentRequest.PAY_TYPE_INT�����ʿ�֧��
tPaymentRequest.setNotifyType(tNotifyType);   //�趨�̻�֪ͨ��ʽ
                                              //0��URLҳ��֪ͨ
                                              //1��������֪ͨ
tPaymentRequest.setResultNotifyURL(tResultNotifyURL); //�趨֧������ش���ַ ����Ҫ��Ϣ��
tPaymentRequest.setMerchantRemarks(tMerchantRemarks); //�趨�̻���ע��Ϣ
tPaymentRequest.setPaymentLinkType(tPaymentLinkType);//�趨֧�����뷽ʽ
try{
 tSignature = tPaymentRequest.genSignature(1);
}catch (TrxException e){    
       request.setAttribute("tReturnCode", e.getCode());
       request.setAttribute("tErrorMsg", e.getMessage());
       request.getRequestDispatcher("/ErrorPageInternal.jsp").forward(request, response);
       return; 
} 
%>
<HTML>
<HEAD><TITLE>ũ������֧��ƽ̨-�̻��ӿڷ���-֧������</TITLE></HEAD>
<BODY BGCOLOR='#FFFFFF' TEXT='#000000' LINK='#0000FF' VLINK='#0000FF' ALINK='#FF0000'>
<CENTER>֧������<br>
<form name="form1" method="post" action="<%=sTrustPayIETrxURL%>">
<input type="hidden" name="Signature" value="<%=tSignature%>">
<input type="hidden" name="errorPage" value="<%=sErrorUrl%>">
<TR><TD colspan=2><INPUT type=submit value="�ύ">
</form>
</BODY></HTML>

