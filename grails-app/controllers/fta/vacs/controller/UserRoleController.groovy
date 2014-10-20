package fta.vacs.controller

import fta.vacs.domain.UserRole
import fta.vacs.domain.User
import fta.vacs.domain.Role
import grails.plugins.springsecurity.Secured

@Secured(['ROLE_FTA_ADMIN'])
class UserRoleController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		//params.offset = 0
		//params.order = params.order ?: 'asc'
		//params.sort = params.sort ?: 'user.username'
		
		/*def userRoles = userRoles = UserRole.withCriteria{
			maxResults(params.max)
			firstResult(params.offset)
			if(params.sort == 'role.authority'){
				role {
					like("authority", "%")
					order('authority', params.order)
				}
			}else if(params.sort == 'user.username'){
				user {
					like("username", "%")
					order('username', params.order)
				}
			}
		}*/
		
        [userRoleInstanceList: UserRole.list(params), userRoleInstanceTotal: UserRole.count()]
    }

    def create = {
        def userRoleInstance = new UserRole()
        userRoleInstance.properties = params
        return [userRoleInstance: userRoleInstance]
    }

    def save = {
		log.debug "saving user role"
		log.debug "params: $params"
		def user = User.get(params['user.id'])
		def role = Role.get(params['role.id'])
        def userRoleInstance = UserRole.create(user, role)
        if (userRoleInstance) {
            flash.message = "Successfully created UserRole for user $user.username and role $role.authority"
            redirect(action: "list")
        }
        else {
			flash.message = "Failed to create UserRole for user $user.username and role $role.authority"
            render(view: "create", model: [userRoleInstance: userRoleInstance])
        }
    }

    def show = {
        def userRoleInstance = UserRole.get(params.id)
        if (!userRoleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userRole.label', default: 'UserRole'), params.id])}"
            redirect(action: "list")
        }
        else {
            [userRoleInstance: userRoleInstance]
        }
    }

    def edit = {
        def userRoleInstance = UserRole.get(params.id)
        if (!userRoleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userRole.label', default: 'UserRole'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [userRoleInstance: userRoleInstance]
        }
    }

    def update = {
        def userRoleInstance = UserRole.get(params.id)
        if (userRoleInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (userRoleInstance.version > version) {
                    
                    userRoleInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'userRole.label', default: 'UserRole')] as Object[], "Another user has updated this UserRole while you were editing")
                    render(view: "edit", model: [userRoleInstance: userRoleInstance])
                    return
                }
            }
            userRoleInstance.properties = params
            if (!userRoleInstance.hasErrors() && userRoleInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'userRole.label', default: 'UserRole'), userRoleInstance.id])}"
                redirect(action: "show", id: userRoleInstance.id)
            }
            else {
                render(view: "edit", model: [userRoleInstance: userRoleInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userRole.label', default: 'UserRole'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def userRoleInstance = UserRole.get(params.id)
        if (userRoleInstance) {
            try {
                userRoleInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'userRole.label', default: 'UserRole'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'userRole.label', default: 'UserRole'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userRole.label', default: 'UserRole'), params.id])}"
            redirect(action: "list")
        }
    }
}
