package fta.vacs.domain

import org.springframework.security.core.userdetails.UserDetails

class User implements UserDetails, Serializable{

	transient springSecurityService
	static transients = ['fullName', 'accountNonExpired', 'accountNonLocked', 'credentialsNonExpired']
	static hasMany = [userRoles : UserRole]

	/**
	* Application fields
	*/
	String firstName
	String lastName
	String phoneNumber
	
	
	/**
	* Spring Security Core required fields
	*/
	String username
	String password
	boolean enabled
	boolean accountExpired
	boolean credentialsExpired
	boolean accountLocked
	boolean passwordExpired
	
	
	static constraints = {
		username email:true, blank: false, unique: true
		password blank: false, minSize:6
		
		firstName blank:false
		lastName blank:false
		phoneNumber nullable:true
		
	}

	static mapping = {
		password column: '`password`'
	}
	
	public String getFullName(){
		return firstName + " " + lastName;
	}
	
	@Override
	public String toString(){
		return getFullName()
	}

	@Override
	Collection<Role> getAuthorities() {
		UserRole.withTransaction{
			UserRole.findAllByUser(this).collect { it.role } as Set
		}
	}
	
	@Override
	public boolean isAccountNonExpired(){
		return !accountExpired
	}

	@Override
	public boolean isAccountNonLocked(){
		return !accountLocked
	}

	@Override
	public boolean isCredentialsNonExpired(){
		return !credentialsExpired
	}
	
	boolean hasAuthority(roleName){
		for(Set<Role> role : getAuthorities()){
			if(role.authority.equalsIgnoreCase(roleName)){
				return true
			}
		}
		return false
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}
}
