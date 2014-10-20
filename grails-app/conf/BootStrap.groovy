import fta.vacs.domain.*
import grails.util.Environment


class BootStrap {


	def roleService
	
    def init = { servletContext ->
		
		if(Environment.getCurrent() == Environment.DEVELOPMENT){		
			def vaTaskCreatorRole = roleService.create('ROLE_VA_TASK_CREATOR')
			def vaTaskApproverRole = roleService.create('ROLE_VA_TASK_APPROVER')
			def vaCertifierRole = roleService.create('ROLE_VA_CERTIFIER')
			def ftaInstallerRole = roleService.create('ROLE_FTA_INSTALLER')
			def ftaInvoicerRole = roleService.create('ROLE_FTA_INVOICER')
			def ftaAdminRole = roleService.create('ROLE_FTA_ADMIN')
			
			def michael = createUser('Michael.Reed1@va.gov', 'admin123', 'Michael', 'Reed', '612-344-2152', [vaTaskCreatorRole])
			def shawn = createUser('Shawn.Staples@va.gov', 'admin123', 'Shawn', 'Staples', '612-919-5464', [vaTaskCreatorRole, vaTaskApproverRole])
			def lori = createUser('Lori.Geisler@va.gov', 'admin123', 'Lori', 'Geisler', '612-467-3224', [vaTaskApproverRole, vaCertifierRole])
			
			def daveM = createUser("avidmalone@gmail.com", 'admin123', 'Dave', 'Malone', '', [ftaAdminRole])
			def jamie = createUser('Jamieb@fedtechadvantage.com', 'admin123', 'Jamie', 'Baillargeon', '651-294-3939', [ftaAdminRole])
			def jeff = createUser('jruhl@fedtechadvantage.com', 'admin123', 'Jeff', 'Ruhl', '763-413-5242', [ftaInstallerRole])
			def daveW = createUser('djwaller@pdscomm.com', 'admin123', 'Dave', 'Waller', '', [ftaInstallerRole])
			def rene = createUser('rjfuentes@pdscomm.com', 'admin123', 'Rene', 'Fuentes', '', [ftaInstallerRole])
			def amy = createUser('Atousey@fedtechadvantage.com', 'admin123', 'Amy', 'Tousey', '651-294-3939', [ftaInvoicerRole])
			def tom = createUser('tbest@fedtechadvantage.com', 'admin123', 'Tom', 'Best', '', [ftaAdminRole])		
			
			
			log.debug 'created new email rule for status NEW? ' + new EmailRule(status:TaskOrder.NEW, usersToEmail: [jeff, jamie, shawn]).save()
			log.debug 'created new email rule for status COMPLETED? ' + new EmailRule(status:TaskOrder.COMPLETED, usersToEmail: [jeff, jamie, shawn, lori]).save()
			log.debug 'created new email rule for status APPROVED? ' + new EmailRule(status:TaskOrder.APPROVED, usersToEmail: [amy]).save()
			log.debug 'created new email rule for status INVOICED? ' + new EmailRule(status:TaskOrder.INVOICED, usersToEmail: [lori]).save()
			log.debug 'created new email rule for status REQUIRES_ATTENTION? ' + new EmailRule(status:TaskOrder.REQUIRES_ATTENTION, usersToEmail: [jamie, jeff]).save()
			
			new Component(name:'375-CJ688TGGR', description:'CAT 6 JACK GREEN').save()
			new Component(name:'375-CJ688TGVL', description:'CAT 6 JACK VIOLET').save()
			new Component(name:'375-DP24688TGY', description:'CAT 6 PATCH PANEL 24 PORT').save()
			new Component(name:'375-DP48WSBLY', description:'CAT 6 PATCH PANEL 48 PORT').save()
			new Component(name:'375-CP48WSBLY', description:'BLANK PATCH PANEL 48 PORT').save()
			new Component(name:'375-CFPSL4EIY', description:'FACE PLATE 4 PORT ELECTRICAL IVORY').save()
			new Component(name:'375-CBXJ4EI-A', description:'4 PORT SURFACE MOUNT BOX ELEC IVORY').save()
			new Component(name:'375-KWP6PY', description:'CAT 6 WALL PHONE PLATE WITH LUGS').save()
			new Component(name:'375-CMBEI-W', description:'BLANK INSERT').save()
			new Component(name:'375-UTPSP3BUY', description:'3\' PATCH CORD BLUE').save()
			new Component(name:'375-UTPSP5BUY', description:'5\' PATCH CORD BLUE').save()
			new Component(name:'375-UTPSP15BUY', description:'15\' PATCH CORD BLUE').save()
			new Component(name:'375-CFFPEBSL4', description:'MODULAR FURNITURE FACEPLATE').save()
			new Component(name:'375-GPBW24-X', description:'96PR CAT 6 110 PUNCHDOWN BLOCK W CLIPS').save()
			new Component(name:'479-11224', description:'7\' RELAY RACK ALUMINUM FINISH').save()
			new Component(name:'555-250-15-2', description:'HORIZONTAL CABLE MANAGEMENT 1.75').save()
			new Component(name:'555-250-35-3', description:'HORIZONTAL CABLE MANAGEMENT 3.5').save()
			new Component(name:'425-35100', description:'SURFACE MOUNT RACEWAY IVORY 3/4"').save()
			new Component(name:'425-35300', description:'SURFACE MOUNT RACEWAY IVORY 1-1/4"').save()
			new Component(name:'425-35500', description:'SURFACE MOUNT RACEWAY IVORY 1-3/4"').save()
			new Component(name:'425-FITTING', description:'SURFACE MOUNT RACEWAY IVORY FITTINGS').save()
			new Component(name:'351-LCI-300', description:'FIRE CAULK').save()
			new Component(name:'351-SSP-100', description:'FIRE PUTTY 36cu in').save()
			new Component(name:'351-EZDP44', description:'EZ PATH 4" INTUMESSENT SLEVE').save()
		}
    }
	
	
    def destroy = {
    }
	
	def createUser(def username, def password, def firstName, def lastName, def phoneNumber, def roles){
		def user = User.findByUsername(username)
		if(!user){
			log.debug "Creating user $username"
			
			user = new User(accountExpired:false,
							accountLocked:false,
							enabled:true,
							passwordExpired:false,
							password:password,
							username: username,
							firstName: firstName,
							lastName:lastName,
							phoneNumber: phoneNumber)
			
			
			if(!user.save()){
				log.error "Failed to create user $username: \nerrors:"
				user.errors.allErrors.each {
					log.error it
				}
			}else{
				log.debug "user $username created; assigning roles $roles"
				
				for(def role : roles){
					roleService.assignUserToRole(user, role)
				}
			}
		}else{
			log.debug "User $username already exists, skipping creation"
		}
		
		return user
	}
}
