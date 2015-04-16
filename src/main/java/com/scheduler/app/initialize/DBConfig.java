package com.scheduler.app.initialize;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate4.HibernateTransactionManager;
import org.springframework.orm.hibernate4.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.annotation.Resource;
import javax.sql.DataSource;
import java.util.Properties;



@Configuration
@EnableTransactionManagement
@PropertySource("classpath:application.properties")
public class DBConfig {

	private static final String PROPERTY_NAME_DATABASE_DRIVER = "db.driver";

	private static final String PROPERTY_NAME_DATABASE_PASSWORD = "db.password";

	private static final String PROPERTY_NAME_DATABASE_URL = "db.url";

	private static final String PROPERTY_NAME_DATABASE_USERNAME = "db.username";

	private static final String PROPERTY_NAME_ENTITYMANAGER_PACKAGES_TO_SCAN = "entitymanager.packages.to.scan";

	// connection pooling
	private static final String PROPERTY_NAME_HIBERNATE_DIALECT = "hibernate.dialect";
	private static final String PROPERTY_NAME_HIBERNATE_SHOW_SQL = "hibernate.show_sql";
	private static final String PROPERTY_NAME_HIBERNATE_TIMEOUT = "hibernate.c3p0.timeout";
	private static final String CONNECTION_PROVIDER_CLASS = "connection.provider.class";
	private static final String HIBERNATE_C3P0_ACQUIRE_INCREMENT = "hibernate.c3p0.acquire_increment";
	private static final String HIBERNATE_C3P0_TESTCONNECTIONONCHECKOUT = "hibernate.c3p0.testConnectionOnCheckout";
	private static final String PROPERTY_NAME_HIBERNATE_IDEAL_TIMEOUT = "hibernate.c3p0.idle_test_period";
	private static final String HIBERNATE_C3P0_MIN_SIZE = "hibernate.c3p0.min_size";
	private static final String HIBERNATE_C3P0_MAX_SIZE = "hibernate.c3p0.max_size";
  private static final String HIBERNATE_C3P0_MAX_STATEMENTS = "hibernate.c3p0.max_statements";
	private static final String HIBERNATE_CONNECTION_CHARACTERENCODING = "hibernate.connection.characterEncoding";
	private static final String HIBERNATE_CONNECTION_USEUNICODE = "hibernate.connection.useUnicode";
	private static final String HIBERNATE_CONNECTION_CHARSET = "hibernate.connection.charSet";
	
	


	@Resource
	private Environment env;

	/**
	 * @return dataSource Object
	 */
	@Bean
	public DataSource dataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName(env.getRequiredProperty(PROPERTY_NAME_DATABASE_DRIVER));
		dataSource.setUrl(env.getRequiredProperty(PROPERTY_NAME_DATABASE_URL));
		dataSource.setUsername(env.getRequiredProperty(PROPERTY_NAME_DATABASE_USERNAME));
		dataSource.setPassword(env.getRequiredProperty(PROPERTY_NAME_DATABASE_PASSWORD));
		return dataSource;
	}

	/**
	 * @return properties object
	 */
	private Properties hibProperties() {
		Properties properties = new Properties();
		properties.put(PROPERTY_NAME_HIBERNATE_DIALECT, env.getRequiredProperty(PROPERTY_NAME_HIBERNATE_DIALECT));
		properties.put(PROPERTY_NAME_HIBERNATE_SHOW_SQL, env.getRequiredProperty(PROPERTY_NAME_HIBERNATE_SHOW_SQL));
		properties.put(PROPERTY_NAME_HIBERNATE_TIMEOUT, env.getRequiredProperty(PROPERTY_NAME_HIBERNATE_TIMEOUT));
		properties.put(PROPERTY_NAME_HIBERNATE_IDEAL_TIMEOUT,
				env.getRequiredProperty(PROPERTY_NAME_HIBERNATE_IDEAL_TIMEOUT));
		properties.put(CONNECTION_PROVIDER_CLASS, env.getRequiredProperty(CONNECTION_PROVIDER_CLASS));
		properties.put(HIBERNATE_C3P0_ACQUIRE_INCREMENT, env.getRequiredProperty(HIBERNATE_C3P0_ACQUIRE_INCREMENT));
		properties.put(HIBERNATE_C3P0_TESTCONNECTIONONCHECKOUT,
				env.getRequiredProperty(HIBERNATE_C3P0_TESTCONNECTIONONCHECKOUT));
		properties.put(HIBERNATE_C3P0_MAX_STATEMENTS, env.getRequiredProperty(HIBERNATE_C3P0_MAX_STATEMENTS));
		properties.put(HIBERNATE_C3P0_MIN_SIZE, env.getRequiredProperty(HIBERNATE_C3P0_MIN_SIZE));
		properties.put(HIBERNATE_C3P0_MAX_SIZE, env.getRequiredProperty(HIBERNATE_C3P0_MAX_SIZE));
    properties.put(HIBERNATE_CONNECTION_CHARACTERENCODING, env.getRequiredProperty(HIBERNATE_CONNECTION_CHARACTERENCODING));
    properties.put(HIBERNATE_CONNECTION_USEUNICODE, env.getRequiredProperty(HIBERNATE_CONNECTION_USEUNICODE));
    properties.put(HIBERNATE_CONNECTION_CHARSET, env.getRequiredProperty(HIBERNATE_CONNECTION_CHARSET));
    
		return properties;
	}

	/**
	 * @return hibernatetransactionManager object
	 */
	@Bean
	public HibernateTransactionManager transactionManager() {
		HibernateTransactionManager transactionManager = new HibernateTransactionManager();
		transactionManager.setSessionFactory(sessionFactory().getObject());
		return transactionManager;
	}

	/**
	 * @return LocalSessionFactoryBean Object
	 */
	@Bean
	public LocalSessionFactoryBean sessionFactory() {
		LocalSessionFactoryBean sessionFactoryBean = new LocalSessionFactoryBean();
		sessionFactoryBean.setDataSource(dataSource());
		sessionFactoryBean.setPackagesToScan(env.getRequiredProperty(PROPERTY_NAME_ENTITYMANAGER_PACKAGES_TO_SCAN));
		sessionFactoryBean.setHibernateProperties(hibProperties());
		return sessionFactoryBean;
	}

}
