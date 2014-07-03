package com.cssweb.payment.common;

import com.alibaba.dubbo.config.ApplicationConfig;
import com.alibaba.dubbo.config.ReferenceConfig;
import com.alibaba.dubbo.config.RegistryConfig;
import com.cssweb.payment.topup.sei.TopupService;

/**
 * Created by chenhf on 2014/6/30.
 */
public class ServiceConfig {

    public TopupService getTopupService()
    {
        ApplicationConfig application = new ApplicationConfig();
        application.setName("TopupClient");

        RegistryConfig registry = new RegistryConfig();
        registry.setProtocol("zookeeper");
        registry.setAddress("127.0.0.1:2181");
        registry.setClient("curator");

        ReferenceConfig<TopupService> reference = new ReferenceConfig<TopupService>(); // 此实例很重，封装了与注册中心的连接以及与提供者的连接，请自行缓存，否则可能造成内存和连接泄漏
        reference.setApplication(application);
        reference.setRegistry(registry); // 多个注册中心可以用setRegistries()
        reference.setInterface(TopupService.class);

        return reference.get();
    }
}
