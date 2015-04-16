package com.scheduler.app.initialize;

import java.util.Locale;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.validation.Validator;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
@EnableWebMvc
@ComponentScan("com.scheduler.app")
@Import({ DBConfig.class })
public class WebAppConfig extends WebMvcConfigurerAdapter {

	private static final Integer RESOURCE_CACHE_PERIOD_SECONDS = new Integer(10);

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter
	 * #addResourceHandlers(org.springframework.web.servlet.config.annotation.
	 * ResourceHandlerRegistry)
	 */
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/").setCachePeriod(RESOURCE_CACHE_PERIOD_SECONDS);
	}

	/**
	 * @return LocaleChangeInterceptor Object
	 */
	@Bean
	public LocaleChangeInterceptor localeChangeInterceptor() {
		LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
		localeChangeInterceptor.setParamName("locale");
		return localeChangeInterceptor;
	}

	/**
	 * @return SessionLocaleResolver Object
	 */
	@Bean
	public SessionLocaleResolver sessionLocaleResolver() {
		SessionLocaleResolver localeResolver = new SessionLocaleResolver();
		localeResolver.setDefaultLocale(new Locale("en", "EN"));
		return localeResolver;
	}

	/**
	 * @return localValidatorFactoryBean Object
	 */
	@Bean(name = "validator")
	public LocalValidatorFactoryBean validator() {
		LocalValidatorFactoryBean localValidatorFactoryBean = new LocalValidatorFactoryBean();
		localValidatorFactoryBean.setValidationMessageSource(getMessageSource());
		return localValidatorFactoryBean;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter
	 * #getValidator()
	 */
	@Override
	public Validator getValidator() {
		return validator();
	}

	/**
	 * @return messageSource Object
	 */
	@Bean(name = "messageSource")
	public MessageSource getMessageSource() {
		ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
		messageSource.setBasename("messages");
		return messageSource;
	}

	/**
	 * @return internalResourceViewResolver Object
	 */
	@Bean
	public ViewResolver getViewResolver() {
		InternalResourceViewResolver internalResourceViewResolver = new InternalResourceViewResolver();
		internalResourceViewResolver.setViewClass(JstlView.class);
		internalResourceViewResolver.setPrefix("/WEB-INF/jsp/");
		internalResourceViewResolver.setSuffix(".jsp");
		return internalResourceViewResolver;
	}

	/**
	 * @return commonsMultipartResolver Object
	 */
	@Bean
	public MultipartResolver multipartResolver() {
		CommonsMultipartResolver commonsMultipartResolver = new CommonsMultipartResolver();
		commonsMultipartResolver.setMaxUploadSize(5000000);
		return commonsMultipartResolver;
	}

	@Bean
	public DialogueRequestFilter getDialogueRequestFilter() {
		return new DialogueRequestFilter();
	}
}
