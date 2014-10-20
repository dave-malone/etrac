package fta.vacs.controller

import fta.vacs.domain.Component
import grails.plugins.springsecurity.Secured

@Secured(['ROLE_FTA_ADMIN'])
class ComponentController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [componentInstanceList: Component.list(params), componentInstanceTotal: Component.count()]
    }

    def create = {
        def componentInstance = new Component()
        componentInstance.properties = params
        return [componentInstance: componentInstance]
    }

    def save = {
        def componentInstance = new Component(params)
        if (componentInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'component.label', default: 'Component'), componentInstance.id])}"
            redirect(action: "show", id: componentInstance.id)
        }
        else {
            render(view: "create", model: [componentInstance: componentInstance])
        }
    }

    def show = {
        def componentInstance = Component.get(params.id)
        if (!componentInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'component.label', default: 'Component'), params.id])}"
            redirect(action: "list")
        }
        else {
            [componentInstance: componentInstance]
        }
    }

    def edit = {
        def componentInstance = Component.get(params.id)
        if (!componentInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'component.label', default: 'Component'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [componentInstance: componentInstance]
        }
    }

    def update = {
        def componentInstance = Component.get(params.id)
        if (componentInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (componentInstance.version > version) {
                    
                    componentInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'component.label', default: 'Component')] as Object[], "Another user has updated this Component while you were editing")
                    render(view: "edit", model: [componentInstance: componentInstance])
                    return
                }
            }
            componentInstance.properties = params
            if (!componentInstance.hasErrors() && componentInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'component.label', default: 'Component'), componentInstance.id])}"
                redirect(action: "show", id: componentInstance.id)
            }
            else {
                render(view: "edit", model: [componentInstance: componentInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'component.label', default: 'Component'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def componentInstance = Component.get(params.id)
        if (componentInstance) {
            try {
                componentInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'component.label', default: 'Component'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'component.label', default: 'Component'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'component.label', default: 'Component'), params.id])}"
            redirect(action: "list")
        }
    }
}
