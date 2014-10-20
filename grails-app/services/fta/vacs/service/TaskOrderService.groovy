package fta.vacs.service

import org.springframework.web.multipart.MultipartFile;

import fta.vacs.domain.*
import fta.vacs.event.*

class TaskOrderService {

    static transactional = true

	def documentService
	
	def create(TaskOrder taskOrder, MultipartFile installationInstructionsFile, def comment) {
		def document = documentService.create(installationInstructionsFile)
		if(document){
			taskOrder.addToDocuments(document)
		}
		
		if(comment){
			taskOrder.addToComments(new Comment(text:comment))
		}		
		
		if(taskOrder.save(flush: true)){		
			TaskOrderStatusChangeEvent event = new TaskOrderStatusChangeEvent(this, taskOrder)
			publishEvent(event)
			return true
		}else{
			log.error("Failed to create task order")
			return false
		}
	}
	
	def schedule(def id, Date dateScheduled, def comment) {
		TaskOrder taskOrder = TaskOrder.get(id)
		taskOrder.status = TaskOrder.SCHEDULED
		taskOrder.dateScheduled = dateScheduled
		
		if(comment){
			taskOrder.addToComments(new Comment(text:comment))
		}
		
		return taskOrder.save(flush: true)
	}
	
	def saveCompletedInfo(TaskOrder taskOrder, MultipartFile testResultsFile, def comment) {
		def document = documentService.create(testResultsFile)
		if(document){
			taskOrder.addToDocuments(document)
		}
		
		if(comment){
			taskOrder.addToComments(new Comment(text:comment))
		}
		
		if(taskOrder.save(flush: true)){
			return true
		}else{
			log.error("Failed to complete task order")
			return false
		}
	}
	
	def complete(TaskOrder taskOrder, MultipartFile testResultsFile, def comment) {
		taskOrder.status = TaskOrder.COMPLETED
		taskOrder.dateCompleted = new Date()
		
		def document = documentService.create(testResultsFile)
		if(document){
			taskOrder.addToDocuments(document)
		}
		
		if(comment){
			taskOrder.addToComments(new Comment(text:comment))
		}
		
		if(taskOrder.save(flush: true)){
			TaskOrderStatusChangeEvent event = new TaskOrderStatusChangeEvent(this, taskOrder)
			publishEvent(event)
			return true
		}else{
			log.error("Failed to complete task order")
			return false
		}
	}
	
	def approve(def id, def comment) {
		TaskOrder taskOrder = TaskOrder.get(id)
		taskOrder.status = TaskOrder.APPROVED
		taskOrder.dateApproved = new Date()
		
		if(comment){
			taskOrder.addToComments(new Comment(text:comment))
		}
		
		if(taskOrder.save(flush: true)){
			TaskOrderStatusChangeEvent event = new TaskOrderStatusChangeEvent(this, taskOrder)
			publishEvent(event)
			return true
		}else{
			log.error("Failed to approve task order")
			return false
		}
	}
	
	def invoice(def id, def comment) {
		TaskOrder taskOrder = TaskOrder.get(id)
		taskOrder.status = TaskOrder.INVOICED
		taskOrder.dateInvoiced = new Date()
		
		if(comment){
			taskOrder.addToComments(new Comment(text:comment))
		}
		
		if(taskOrder.save(flush: true)){
			TaskOrderStatusChangeEvent event = new TaskOrderStatusChangeEvent(this, taskOrder)
			publishEvent(event)
			return true
		}else{
			log.error("Failed to invoice task order")
			return false
		}
		
	}
	
	def requiresAttention(def id, def comment){
		TaskOrder taskOrder = TaskOrder.get(id)
		taskOrder.status = TaskOrder.REQUIRES_ATTENTION
		
		if(comment){
			taskOrder.addToComments(new Comment(text:comment))
		}
		
		if(taskOrder.save(flush: true)){
			TaskOrderStatusChangeEvent event = new TaskOrderStatusChangeEvent(this, taskOrder)
			publishEvent(event)
			return true
		}else{
			log.error("Failed to update task order")
			return false
		}
	}
	
	def certify(def id, def comment) {
		TaskOrder taskOrder = TaskOrder.get(id)
		taskOrder.status = TaskOrder.CERTIFIED
		taskOrder.dateCertified = new Date()
		
		if(comment){
			taskOrder.addToComments(new Comment(text:comment))
		}
		
		return taskOrder.save(flush: true)
	}
	
	def cancel(def id, def comment) {
		TaskOrder taskOrder = TaskOrder.get(id)
		taskOrder.status = TaskOrder.CANCELED
		taskOrder.dateCanceled = new Date()
		
		if(comment){
			taskOrder.addToComments(new Comment(text:comment))
		}
		
		return taskOrder.save(flush: true)
	}
}
