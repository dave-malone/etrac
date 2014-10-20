package fta.vacs.service

import fta.vacs.domain.*

class RoleService {	
	
	boolean transactional = true
	
	def create(roleName){
		log.debug "looking for role: $roleName"		
				
		def role = Role.findByAuthority(roleName)
		
		if(!role){
			log.debug "Role does not exist. Creating role $roleName"
			role = new Role(authority: roleName)
			if(role.validate()) {
				role.save()
				log.debug "$roleName created"
			}else {
				log.debug "failed to create $roleName \nerrors:"
				role.errors.allErrors.each {
					log.error it
				}
			}
		}else{
			log.debug "$roleName exists, skipping creation"
		}
		
		return role
	}
	
	def assignUserToRole(String username, String roleName){
		def user = User.findByUsername(username)
		def role = Role.findByAuthority(roleName)
		return assignUserToRole(user, role)
	}
	
	def assignUserToRole(User user, Role role){	
		def success = false	
		if(user.hasAuthority(role.authority)){
			log.debug "user $user.username already has role $role.authority"
			success = true
		}else{
			log.debug "assigning user $user.username to role $role.authority"
			def userRole = UserRole.create(user, role)
			if(userRole.save()){
				log.debug "successfully assigned user $user.username to role $role.authority"
				success = true
			}else{
				log.error "Failed to assign user $user.user to role $role.authority: \nerrors:"
				user.errors.allErrors.each {
					log.error it
				}
				success = false
			}
		}
		
		return success
	}
}
