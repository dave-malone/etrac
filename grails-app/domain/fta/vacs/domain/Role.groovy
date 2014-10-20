package fta.vacs.domain

import org.springframework.security.core.GrantedAuthority

class Role implements GrantedAuthority, Serializable{

	static hasMany = [userRoles : UserRole]
	
	String authority
	String description

	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
		description nullable:true
	}
}
