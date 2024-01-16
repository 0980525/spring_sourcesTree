package com.myWeb.www.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@MapperScan(basePackages = {"com.myWeb.www.repository"})
@ComponentScan(basePackages = {"com.myWeb.www.service"})
@EnableTransactionManagement
@EnableScheduling
@Configuration
public class RootConfig {
	// DB 설정 부분
	// hikariCP 사용 	/ log4jdbc-log4j2 사용
	// log4jdbc 안쓸거면 Driver는 기존대로 작성하면 된다.
	
	@Autowired
	ApplicationContext applicationContext;
	
	@Bean
	public DataSource dataSource() {
		HikariConfig hikariConfig = new HikariConfig();
		// log4jdbc-log4j2
		hikariConfig.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
		hikariConfig.setJdbcUrl("jdbc:log4jdbc:mysql://localhost:3306/mywebdb");
		hikariConfig.setUsername("mywebUser");
		hikariConfig.setPassword("mysql");
		
		hikariConfig.setMaximumPoolSize(5);	// 최대 커넥션 개수
		hikariConfig.setMinimumIdle(5);	// 최소 유휴 커넥션 개수 (위의 값과 같은 값으로 설정)
		
		hikariConfig.setConnectionTestQuery("SELECT now()");	// test 쿼리문
		hikariConfig.setPoolName("springHikariCP");	// 그냥 이름 설정이므로 본인이 원하는 대로 작성 가능
		
		// 추가 설정
		// cachePrepStmts : cache 사용 여부 설정
		hikariConfig.addDataSourceProperty("dataSource.cachePrepStmts", "true");
		// mysql Driver가 연결당 cache statement의 수에 관한 설정 : 250 ~ 500 사이 권장
		hikariConfig.addDataSourceProperty("dataSource.prepStmtCacheSize", "250");
		// connection 당 캐싱할 preperedStatement의 개수 지정 옵션 : default 256
		hikariConfig.addDataSourceProperty("dataSource.prepStmtCacheSqlLimit", "true");	// 기본값으로 설정
		// mysql 서버에서 최신 이슈가 있을 경우 지원받는 설정
		hikariConfig.addDataSourceProperty("dataSource.useServerPrepStmts", "true");
		
		HikariDataSource hikariDataSource = new HikariDataSource(hikariConfig);
		
		return hikariDataSource;
	}
	
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sqlFactoryBean = new SqlSessionFactoryBean();
		// 위에 있는 dataSource() method 사용
		sqlFactoryBean.setDataSource(dataSource());
		sqlFactoryBean.setMapperLocations(
				applicationContext.getResources("classpath:/mappers/*.xml"));
		// Alilas 설정하려고
		sqlFactoryBean.setConfigLocation(
				applicationContext.getResource("classpath:/MybatisConfig.xml"));
		return sqlFactoryBean.getObject();
	}
	
	// Transaction Manager Bean 설정
	@Bean
	public DataSourceTransactionManager transactionManager() {
		return new DataSourceTransactionManager(dataSource());
	}
	
	
	
	
	
	
	
	
}
