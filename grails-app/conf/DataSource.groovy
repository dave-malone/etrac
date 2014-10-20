dataSource {
    pooled = true
    driverClassName = "org.hsqldb.jdbcDriver"
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "create-drop" // one of 'create', 'create-drop','update'
            //url = "jdbc:hsqldb:file:devDB;shutdown=true"
			url = "jdbc:hsqldb:mem:devDb"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:hsqldb:mem:testDb"
        }
    }
    production {
        dataSource {
            driverClassName = "com.mysql.jdbc.Driver"
			username = "root"
			password = "m@L0ne82"
			url = "jdbc:mysql://localhost:3306/vacs"			
			
			// use this driver to enable p6spy logging
			//driverClassName = "com.p6spy.engine.spy.P6SpyDriver"
			dbCreate = "update"			
			
			//	jndiName = "java:comp/env/standardpar"
			//  info to access the prod database outside of the prod server
			//url = "jdbc:mysql://standardpar.com:3306/standardpar"
			//username = "root"
			//password = "58caEHZHb"
			properties {
				maxActive = 50
				maxIdle = 25
				minIdle = 5
				initialSize = 5
				minEvictableIdleTimeMillis = 60000
				timeBetweenEvictionRunsMillis = 60000
				maxWait = 15
				removeAbandoned = true
				removeAbandonedTimeout = 60
				logAbandoned = true
				testWhileIdle = true
				validationQuery = "SELECT 1"
			}
        }
    }
}
