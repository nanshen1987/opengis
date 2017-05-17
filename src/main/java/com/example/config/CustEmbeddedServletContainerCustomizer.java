package com.example.config;

import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;
import org.springframework.stereotype.Component;

/**
 * Created by shennan on 2017/3/29.
 */
@Component
public class CustEmbeddedServletContainerCustomizer implements EmbeddedServletContainerCustomizer {
    @Override public void customize(ConfigurableEmbeddedServletContainer container) {
        container.setPort(9000);
    }
}
