import fta.vacs.service.AuditEventListenerService
import org.codehaus.groovy.grails.orm.hibernate.HibernateEventListeners

//Place your Spring DSL code here
beans = {
	userDetailsService(fta.vacs.service.UserService)
	
	auditListener(AuditEventListenerService){
		springSecurityService = ref("springSecurityService")
	}
	
	hibernateEventListeners(HibernateEventListeners) {
		  listenerMap = ['pre-insert':auditListener,
						 'pre-update':auditListener]
	}
	
}
