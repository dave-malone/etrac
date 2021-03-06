import grails.plugins.springsecurity.SecurityConfigType
import java.util.concurrent.Executors


/*
*
* Currently utilizing the Spring Events Plugin
* documentation: http://grails.org/plugin/spring-events
*/
applicationEventMulticaster {
  taskExecutor = Executors.newFixedThreadPool(50)
}

// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if(System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }


grails.views.javascript.library="jquery"

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// whether to install the java.util.logging bridge for sl4j. Disable for AppEngine!
grails.logging.jul.usebridge = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// set per-environment serverURL stem for creating absolute links
environments {
    production {
        grails.serverURL = "https://etrac.fedtechadvantage.com/va"
    }
    development {
        grails.serverURL = "http://localhost:8080/va"
    }
    test {
        grails.serverURL = "http://localhost:8080/va"
    }

}

// log4j configuration
log4j = {
    root {
		error stdout
		additivity = true
	}
	
    appenders {
        console name:'stdout', layout:pattern(conversionPattern: '%d [%t] %-5p %c{2} - %m%n')
		//rollingFile name: 'rollingFile', file: "/var/log/tomcat6/vacs.log", maxFileSize: '5MB', layout:pattern(conversionPattern: '%d [%t] %-5p %c{2} - %m%n')		
    }
	
	

	debug  'grails.app.bootstrap',
		   'grails.app.controller',
		   'grails.app.service',
		   'grails.app.filters'
		   //'grails.app.task'
		   //'org.springframework.security'
		   

    error  'org.codehaus.groovy.grails.web.servlet', //  controllers
		   'org.codehaus.groovy.grails.web.pages', //  GSP
           'org.codehaus.groovy.grails.web.sitemesh', //  layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping', // URL mapping
           'org.codehaus.groovy.grails.commons', // core / classloading
           'org.codehaus.groovy.grails.plugins', // plugins
           'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'

    warn   'org.mortbay.log'
}

// make sure to leave the trailing forward slash off of this path 
docUploadDir = '/eTrac/docs'
taskOrder.default.contractNumber='VA-263-11-IQ-0502'

// Added by the Spring Security Core plugin:
grails.plugins.springsecurity.userLookup.userDomainClassName = 'fta.vacs.domain.User'
grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'fta.vacs.domain.UserRole'
grails.plugins.springsecurity.authority.className = 'fta.vacs.domain.Role'

grails.plugins.springsecurity.securityConfigType = SecurityConfigType.Annotation
grails.plugins.springsecurity.password.algorithm='SHA-512'

grails.plugins.springsecurity.rejectIfNoRule = true
grails.plugins.springsecurity.successHandler.defaultTargetUrl = '/taskOrder/list'
grails.plugins.springsecurity.controllerAnnotations.staticRules = [
	'/css/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
	'/images/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
	'/js/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
	'/plugins/jquery-1.6.1.1/**' : ['IS_AUTHENTICATED_ANONYMOUSLY'],
	'/login/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
	'/logout/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
	'/admin.gsp': ['ROLE_FTA_ADMIN'],
	'/**':['IS_AUTHENTICATED_REMEMBERED']
 ]


//Grails Mail plugin configurations
grails.mail.default.from = "eTrac Advantage <etrac@fedtechadvantage.com>"
grails.mail.host = "smtpout.secureserver.net"
grails.mail.port = 25
grails.mail.username = "etrac@fedtechadvantage.com"
grails.mail.password = "etracadv"
grails.mail.props = ["mail.smtp.auth":"true"]