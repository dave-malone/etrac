package fta.vacs.service

import org.hibernate.event.PreInsertEvent
import org.hibernate.event.PreUpdateEvent
import org.hibernate.event.PreUpdateEventListener
import org.hibernate.event.PreInsertEventListener

class AuditEventListenerService implements PreInsertEventListener, PreUpdateEventListener{

	static transactional = true
	
	def springSecurityService    

	@Override
	boolean onPreUpdate(PreUpdateEvent event) {
		def entity = event.entity
		
		log.debug "pre-update for entity: " + entity?.class?.simpleName
		
		if(entity && entity.properties.containsKey('lastUpdatedBy')){
			def user = springSecurityService.currentUser
			log.debug "updated by: $user"
			entity.lastUpdatedBy = user
		}
		
		return false
	}

	@Override
	boolean onPreInsert(PreInsertEvent event) {		
		def entity = event.entity		
		
		log.debug "pre-insert for entity: " + entity?.class?.simpleName
		
		if(entity && entity.properties.containsKey('createdBy')){
			def user = springSecurityService.currentUser
			log.debug "created by: $user"
			entity.createdBy = user
		}
		
		return false
	}
    
	
	
}
