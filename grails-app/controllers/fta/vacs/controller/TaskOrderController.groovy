package fta.vacs.controller

import fta.vacs.domain.Comment
import fta.vacs.domain.Component
import fta.vacs.domain.InstalledComponent
import fta.vacs.domain.TaskOrder
import grails.plugins.springsecurity.Secured
import org.springframework.beans.factory.InitializingBean


class TaskOrderController implements InitializingBean{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", comment: "POST"]
	
	def documentService
	def taskOrderService
	
	def grailsApplication
	def defaultContractNumber
	
	void afterPropertiesSet(){
		this.defaultContractNumber = grailsApplication.config.taskOrder.default.contractNumber
	}

    def index = {
        redirect(action: "list", params: params)
    }

	@Secured(['IS_AUTHENTICATED_REMEMBERED'])
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		params.sort = params.sort ?: "id"
		params.order = params.order ?:"desc"
		
        [taskOrderInstanceList: TaskOrder.list(params), taskOrderInstanceTotal: TaskOrder.count()]
    }
	
	
	@Secured(['ROLE_FTA_ADMIN', 'ROLE_FTA_INSTALLER', 'ROLE_VA_TASK_CREATOR'])
	def addDocument = {
		def taskOrderInstance = TaskOrder.get(params.id)
		if (!taskOrderInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'taskOrder.label', default: 'TaskOrder'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [taskOrderInstance: taskOrderInstance]
		}
	}
	
	@Secured(['ROLE_FTA_ADMIN', 'ROLE_FTA_INSTALLER', 'ROLE_VA_TASK_CREATOR'])
	def uploadDocument = {
		def taskOrderInstance = TaskOrder.get(params.id)
		if (!taskOrderInstance) {			
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'taskOrder.label', default: 'TaskOrder'), params.id])}"
			redirect(action: "list")
		}
		else {
			def document = documentService.create(params.document)
			if(document){
				document.title = params.title
				taskOrderInstance.addToDocuments(document)
			}
			
			if(taskOrderInstance.save(flush:true)){
				flash.message = "Successfully attached document"
			}else{
				flash.message = "Failed to attach the document to your task order.  If this problem persists, please contact the site admin"
			}
			
			redirect(action: "show", id: taskOrderInstance.id)
		}
	}

	@Secured(['ROLE_FTA_ADMIN', 'ROLE_VA_TASK_CREATOR'])
    def create = {
        def taskOrderInstance = new TaskOrder(contractNumber: this.defaultContractNumber)
        taskOrderInstance.properties = params
        return [taskOrderInstance: taskOrderInstance]
    }

	@Secured(['ROLE_FTA_ADMIN', 'ROLE_VA_TASK_CREATOR'])
    def save = {
        def taskOrderInstance = new TaskOrder(params)
		
		if (taskOrderService.create(taskOrderInstance, params.installationInstructionsFile, params.comment)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'taskOrder.label', default: 'TaskOrder'), taskOrderInstance.id])}"
            redirect(action: "show", id: taskOrderInstance.id)
        }
        else {
            render(view: "create", model: [taskOrderInstance: taskOrderInstance])
        }
    }
	

	@Secured(['IS_AUTHENTICATED_REMEMBERED'])
    def show = {
        def taskOrderInstance = TaskOrder.get(params.id)
        if (!taskOrderInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'taskOrder.label', default: 'TaskOrder'), params.id])}"
            redirect(action: "list")
        }
        else {
            [taskOrderInstance: taskOrderInstance]
        }
    }
	
	@Secured(['IS_AUTHENTICATED_REMEMBERED'])
	def comment = {
		def taskOrderInstance = TaskOrder.get(params.taskOrderId)
		if (!taskOrderInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'taskOrder.label', default: 'TaskOrder'), params.id])}"
			redirect(action: "list")
		}
		else {
			if(params.comment){			
				def comment = new Comment(text:params.comment)
				taskOrderInstance.addToComments(comment)
				if(taskOrderInstance.save(flush:true)){
					flash.message = "Your comment was saved"
				}else{
					flash.message = "Failed to save your comment.  If this problem persists, please contact the site admin"
				}							
			}else{
				flash.message = "You did not enter any text into the comment field.  If you wish to comment on this Task Order, please enter some text into the Comment Text Area prior to hitting the 'Post Comment' button"
			}
			
			redirect(action: "show", id: taskOrderInstance.id)			
		}
	}

	@Secured(['ROLE_FTA_ADMIN', 'ROLE_VA_TASK_CREATOR'])
    def edit = {
        def taskOrderInstance = TaskOrder.get(params.id)
        if (!taskOrderInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'taskOrder.label', default: 'TaskOrder'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [taskOrderInstance: taskOrderInstance]
        }
    }

	@Secured(['ROLE_FTA_ADMIN', 'ROLE_VA_TASK_CREATOR'])
    def update = {
        def taskOrderInstance = TaskOrder.get(params.id)
        if (taskOrderInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (taskOrderInstance.version > version) {
                    
                    taskOrderInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'taskOrder.label', default: 'TaskOrder')] as Object[], "Another user has updated this TaskOrder while you were editing")
                    render(view: "edit", model: [taskOrderInstance: taskOrderInstance])
                    return
                }
            }
            taskOrderInstance.properties = params
            if (!taskOrderInstance.hasErrors() && taskOrderInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'taskOrder.label', default: 'TaskOrder'), taskOrderInstance.id])}"
                redirect(action: "show", id: taskOrderInstance.id)
            }
            else {
                render(view: "edit", model: [taskOrderInstance: taskOrderInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'taskOrder.label', default: 'TaskOrder'), params.id])}"
            redirect(action: "list")
        }
    }

	@Secured(['ROLE_FTA_ADMIN'])
    def delete = {
        def taskOrderInstance = TaskOrder.get(params.id)
        if (taskOrderInstance) {
            try {
                taskOrderInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'taskOrder.label', default: 'TaskOrder'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'taskOrder.label', default: 'TaskOrder'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'taskOrder.label', default: 'TaskOrder'), params.id])}"
            redirect(action: "list")
        }
    }
	
	@Secured(['ROLE_FTA_ADMIN', 'ROLE_FTA_INSTALLER'])
	def complete = {
		[taskOrderInstance: TaskOrder.get(params.id)]
	}
	
	@Secured(['ROLE_FTA_ADMIN', 'ROLE_FTA_INSTALLER'])
	def addLineItem = {
		[]
	}
	
	@Secured(['ROLE_FTA_ADMIN', 'ROLE_FTA_INSTALLER'])
	def saveCompletedInfo = {
		TaskOrder taskOrder = TaskOrder.get(params.id)
		
		for(int i = 0; i < 50; i++){
			def componentIdParamName = "componentIds.${i}"
			def quantityParamName = "quantities.${i}"
			try{
				def componentId = params[componentIdParamName]?.toInteger()
				def quantity = params[quantityParamName]
				if(componentId && quantity){
					def component = Component.get(componentId)
					def installedComponent = new InstalledComponent(component: component, quantity:quantity, taskOrder: taskOrder)
					if(!taskOrder.installedComponents.contains(installedComponent)){
						taskOrder.addToInstalledComponents(installedComponent)
					}else{
						for(def ic : taskOrder.installedComponents){
							if(ic.equals(installedComponent)){
								ic.quantity = quantity
							}
						}
					}
				}
			}catch(NumberFormatException e){
				//it's safe to swallow this exception
			}
		}
	
		log.debug("task order installed components: ${taskOrder.installedComponents}")
		
		if(taskOrderService.saveCompletedInfo(taskOrder, params.testResultsFile, params.comment)){
			flash.message = "Task Order Saved"
			redirect(action: "show", id:taskOrder.id)
		}else{
			flash.message = "Failed to Save Task Order"
			render(view: "complete", model: [taskOrderInstance: taskOrder])
		}
	}
	
	@Secured(['ROLE_FTA_ADMIN', 'ROLE_FTA_INSTALLER'])
	def markAsCompleted = {
		TaskOrder taskOrder = TaskOrder.get(params.id)
		
		for(int i = 0; i < 50; i++){
			def componentIdParamName = "componentIds.${i}"
			def quantityParamName = "quantities.${i}"
			try{
				def componentId = params[componentIdParamName]?.toInteger()
				def quantity = params[quantityParamName]
				if(componentId && quantity){
					def component = Component.get(componentId)				
					def installedComponent = new InstalledComponent(component: component, quantity:quantity, taskOrder: taskOrder)
					if(!taskOrder.installedComponents.contains(installedComponent)){
						taskOrder.addToInstalledComponents(installedComponent)
					}else{
						for(def ic : taskOrder.installedComponents){
							if(ic.equals(installedComponent)){
								ic.quantity = quantity
							}
						}
					}
				}	
			}catch(NumberFormatException e){
				//it's safe to swallow this exception
			}
		}
	
		log.debug("task order installed components: ${taskOrder.installedComponents}")		
		
		if(taskOrderService.complete(taskOrder, params.testResultsFile, params.comment)){
			flash.message = "Task Order Completed"
			redirect(action: "show", id:taskOrder.id)
		}else{
			flash.message = "Failed to Complete Task Order"
			render(view: "complete", model: [taskOrderInstance: taskOrder])
		}
	}
	
	@Secured(['ROLE_VA_TASK_APPROVER'])
	def approve = {
		if(taskOrderService.approve(params.id, params.comment)){
			flash.message = "This Task Order has been Approved"
			redirect(action: "show", id:params.id)
		}else{
			flash.message = "Failed to Approve Task Order"
			redirect(action: "show", id:params.id)
		}
	}
	
	@Secured(['ROLE_FTA_ADMIN', 'ROLE_FTA_INVOICER'])
	def invoice = {
		if(taskOrderService.invoice(params.id, params.comment)){
			flash.message = "This Task Order has been marked as Invoiced"
			redirect(action: "show", id:params.id)
		}else{
			flash.message = "Failed to mark Task Order as Invoiced"
			redirect(action: "show", id:params.id)
		}
		
	}
	
	@Secured(['ROLE_VA_CERTIFIER'])
	def certify = {		
		if(taskOrderService.certify(params.id, params.comment)){
			flash.message = "This Task Order has been Certified"
			redirect(action: "show", id:params.id)
		}else{
			flash.message = "Failed to Certify Task Order"
			redirect(action: "show", id:params.id)
		}
	}
	
	@Secured(['ROLE_FTA_ADMIN', 'ROLE_VA_TASK_CREATOR'])
	def cancel = {		
		if(taskOrderService.cancel(params.id, params.comment)){
			flash.message = "This Task Order has been canceled"
			redirect(action: "show", id:params.id)
		}else{
			flash.message = "Failed to Cancel Task Order"
			redirect(action: "show", id:params.id)
		}
	}
	
	@Secured(['ROLE_VA_TASK_APPROVER', 'ROLE_VA_CERTIFIER'])
	def requiresAttention = {
		if(taskOrderService.requiresAttention(params.taskOrderId, params.comment)){
			flash.message = "This Task Order has marked as 'Requires Attention'"
			redirect(action: "show", id:params.taskOrderId)
		}else{
			flash.message = "Failed to mark Task Order as 'Requires Attention'"
			redirect(action: "show", id:params.taskOrderId)
		}
	}
}
