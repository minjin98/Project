package config.db;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import config.db.OracleInfo;
import spring.auth.AuthService;
import spring.dao.MainDao;
import spring.dao.L_InvenDao;
import spring.dao.L_IssueDao;
import spring.dao.L_NamesDao;
import spring.dao.L_PRDao;
import spring.dao.P_InvenDao;
import spring.dao.P_IssueDao;
import spring.dao.P_NamesDao;
import spring.dao.P_PRDao;
import spring.dao.PlanDao;
import spring.dao.ProcessDao;
import spring.dao.UserRegisterService;
import spring.inventory.InventoryService;
import spring.manage.ManageService;
import spring.statistics.StatisticsService;

@Configuration
@EnableTransactionManagement
public class OracleDbConfig{

	@Bean(destroyMethod = "close")
	public DataSource dataSource() {
		DataSource ds = new DataSource();
		ds.setDriverClassName(OracleInfo._driver);
		ds.setUrl(OracleInfo._url);
		ds.setUsername(OracleInfo._user);
		ds.setPassword(OracleInfo._password);
		ds.setInitialSize(2);
		ds.setMaxActive(10);
		ds.setMaxIdle(10);
		ds.setTestWhileIdle(true);
		ds.setMinEvictableIdleTimeMillis(60000 * 3);
		ds.setTimeBetweenEvictionRunsMillis(10 * 1000);
		return ds;
	}

	@Bean
	public PlatformTransactionManager transactionManager() {
		DataSourceTransactionManager tm = new DataSourceTransactionManager();
		tm.setDataSource(dataSource());
		return tm;
	}

	@Bean
	public MainDao mainDao() {
		return new MainDao(dataSource());
	}
	

	@Bean
	public ProcessDao processDao() {
		return new ProcessDao(dataSource());
	}
	
	@Bean
	public UserRegisterService memberRegSvc() {
		return new UserRegisterService(mainDao());
	}
	
	@Bean
	public AuthService authService() {
		AuthService authService = new AuthService();
		authService.setmainDao(mainDao());
		return authService;
	}
	
	@Bean
	public ManageService manageService() {
		ManageService manageService = new ManageService();
		manageService.setmainDao(mainDao());
		return manageService;
	}
	
	@Bean
	public InventoryService inventoryService() {
		InventoryService invenService = new InventoryService();
		invenService.setmainDao(mainDao());
		return invenService;
	}
	
	@Bean
	public StatisticsService statisticsService() {
		StatisticsService statisticsService = new StatisticsService();
		statisticsService.setmainDao(mainDao());
		return statisticsService;
	}
	
	@Bean
	public P_NamesDao p_namesDao() {
		return new P_NamesDao(dataSource());
	}
	
	@Bean
	public P_PRDao p_prDao() {
		return new P_PRDao(dataSource());
	}
	
	@Bean
	public P_IssueDao p_issueDao() {
		return new P_IssueDao(dataSource());
	}
	
	@Bean
	public P_InvenDao p_invenDao() {
		return new P_InvenDao(dataSource());
	}
	
	@Bean
	public L_NamesDao l_namesDao() {
		return new L_NamesDao(dataSource());
	}
	
	@Bean
	public L_PRDao l_prDao() {
		return new L_PRDao(dataSource());
	}
	
	@Bean
	public L_IssueDao l_issueDao() {
		return new L_IssueDao(dataSource());
	}
	
	@Bean
	public L_InvenDao l_invenDao() {
		return new L_InvenDao(dataSource());
	}
}
