package fta.vacs.service

import org.springframework.beans.factory.InitializingBean
import org.springframework.mail.MailException 
import org.springframework.mail.MailSender 
import org.springframework.mail.javamail.MimeMessageHelper
import org.codehaus.groovy.grails.commons.ConfigurationHolder


import javax.mail.internet.MimeMessage 
import javax.mail.internet.InternetAddress
import grails.util.Environment
import org.springframework.context.*
import fta.vacs.event.*
import fta.vacs.domain.*

/**
 * @see http://www.grails.org/plugin/mail for more options
 * @author DMalone
 *
 */
class EmailService implements ApplicationListener<TaskOrderStatusChangeEvent>{
	
	boolean transactional = false
	def mailService	
	
	
	void onApplicationEvent(TaskOrderStatusChangeEvent event) {
		log.debug "Recieved event '$event' in thread ${Thread.currentThread().id}"
		try{
			def email = event.email
			
			if(Environment.getCurrent() == Environment.DEVELOPMENT){
			  email.to = ['avidmalone@gmail.com']
			}else{
				log.debug "looking up list of to email addresses for status $event.status"
				def emailRule = EmailRule.findByStatus(event.status)
				def to = emailRule.usersToEmail*.username
				email.to = to
			}
			
			log.debug "email.to = $email.to"
			
			send(email)
		}catch(Exception e){
			throw new Exception("failed to send email for event $event; $e.message")
		}
		
	}

		
	def send(def mail) throws MailException {	
		if(!mailService){
			throw new IllegalStateException("[mailService] was null")
		}	
		
		log.debug "Sending email: $mail"
		log.debug "Mail configs:"
		log.debug "Host: " + ConfigurationHolder.config.grails.mail.host
		log.debug "Port: " + ConfigurationHolder.config.grails.mail.port
		log.debug "Username: " + ConfigurationHolder.config.grails.mail.username
		log.debug "Password: " + ConfigurationHolder.config.grails.mail.password
		log.debug "Properties: " + ConfigurationHolder.config.grails.mail.props
		
		
		if(mail.template){
			mailService.sendMail{
				to mail.to
				subject mail.subject
				body( view:mail.template, model:mail.model )		  
			}
		}else if(!mail.template && mail.body){
			mailService.sendMail{
				to mail.to
				subject mail.subject
				body mail.body
			}
		}else{
			throw new IllegalArgumentException("You must supply either a template or body text to send in the email")
		}
	}
}
