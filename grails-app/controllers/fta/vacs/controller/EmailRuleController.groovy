package fta.vacs.controller

import fta.vacs.domain.EmailRule;
import grails.plugins.springsecurity.Secured

@Secured(['ROLE_FTA_ADMIN'])
class EmailRuleController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [emailRuleInstanceList: EmailRule.list(params), emailRuleInstanceTotal: EmailRule.count()]
    }

    def create = {
        def emailRuleInstance = new EmailRule()
        emailRuleInstance.properties = params
        return [emailRuleInstance: emailRuleInstance]
    }

    def save = {
        def emailRuleInstance = new EmailRule(params)
        if (emailRuleInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'emailRule.label', default: 'EmailRule'), emailRuleInstance.id])}"
            redirect(action: "show", id: emailRuleInstance.id)
        }
        else {
            render(view: "create", model: [emailRuleInstance: emailRuleInstance])
        }
    }

    def show = {
        def emailRuleInstance = EmailRule.get(params.id)
        if (!emailRuleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'emailRule.label', default: 'EmailRule'), params.id])}"
            redirect(action: "list")
        }
        else {
            [emailRuleInstance: emailRuleInstance]
        }
    }

    def edit = {
        def emailRuleInstance = EmailRule.get(params.id)
        if (!emailRuleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'emailRule.label', default: 'EmailRule'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [emailRuleInstance: emailRuleInstance]
        }
    }

    def update = {
        def emailRuleInstance = EmailRule.get(params.id)
        if (emailRuleInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (emailRuleInstance.version > version) {
                    
                    emailRuleInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'emailRule.label', default: 'EmailRule')] as Object[], "Another user has updated this EmailRule while you were editing")
                    render(view: "edit", model: [emailRuleInstance: emailRuleInstance])
                    return
                }
            }
            emailRuleInstance.properties = params
            if (!emailRuleInstance.hasErrors() && emailRuleInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'emailRule.label', default: 'EmailRule'), emailRuleInstance.id])}"
                redirect(action: "show", id: emailRuleInstance.id)
            }
            else {
                render(view: "edit", model: [emailRuleInstance: emailRuleInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'emailRule.label', default: 'EmailRule'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def emailRuleInstance = EmailRule.get(params.id)
        if (emailRuleInstance) {
            try {
                emailRuleInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'emailRule.label', default: 'EmailRule'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'emailRule.label', default: 'EmailRule'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'emailRule.label', default: 'EmailRule'), params.id])}"
            redirect(action: "list")
        }
    }
}
