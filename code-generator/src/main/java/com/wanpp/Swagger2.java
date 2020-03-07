package com.wanpp;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Component
@EnableSwagger2
public class Swagger2 {
    @Value("${swagger.ui.title:Swagger Apis}")
    private String title;
    @Value("${swagger.ui.description:Swagger Apis Description}")
    private String description;
    // 服务条款
    @Value("${swagger.ui.termsOfServiceUrl:Swagger Apis TermsOfServiceUrl}")
    private String termsOfServiceUrl;
    @Value("${swagger.ui.contact.name:Swagger Apis Contact Name}")
    private String contactName;
    @Value("${swagger.ui.contact.url:Swagger Apis Contact Url}")
    private String contactUrl;
    @Value("${swagger.ui.contact.email:Swagger Apis Contact Email}")
    private String contactEmail;
    @Value("${swagger.ui.version:Swagger Apis Version}")
    private String version;

    @Bean
    public Docket createRestApi() {
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .select()
                .apis(RequestHandlerSelectors.basePackage("com.wanpp.user.controller"))
                .paths(PathSelectors.any())
                .build();
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder().title(title)
                .description(description)
                .termsOfServiceUrl(termsOfServiceUrl)
                .contact(new Contact(contactName,contactUrl,contactEmail))
                .version(version)
                .build();
    }
}
