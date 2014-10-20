package fta.vacs.service

import fta.vacs.domain.User
import org.apache.commons.lang.StringUtils
import org.springframework.dao.DataAccessException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken as AuthToken
import org.springframework.security.core.context.SecurityContextHolder as SCH
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.codehaus.groovy.grails.plugins.springsecurity.GrailsUserDetailsService

class UserService  implements GrailsUserDetailsService{
	
	boolean transactional = true
	
	def springSecurityService
	def daoAuthenticationProvider
	
	@Override
	UserDetails loadUserByUsername(String username, boolean loadRoles) throws UsernameNotFoundException {
		return loadUserByUsername(username)
	}

	@Override
	UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = User.findByUsername(username)
		if (!user) throw new UsernameNotFoundException('User not found', username)
		return user
	}
	
  /**
	* Returns the currently logged in user.  If
	* the current user isn't authenticated, this
	* method will return null
	* @return
	*/
   def User getCurrentUser(){
	   def user
	   
	   if (springSecurityService.isLoggedIn()) {
		   def principal = springSecurityService.principal
		   user = User.get(principal.id)
	   }
	   
	   return user
   }
	
}
