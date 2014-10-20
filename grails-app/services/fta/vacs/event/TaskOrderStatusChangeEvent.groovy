package fta.vacs.event

import java.text.DateFormat;
import java.text.DecimalFormat
import java.text.NumberFormat;
import java.text.SimpleDateFormat

import org.springframework.context.ApplicationEvent;

import fta.vacs.domain.*

class TaskOrderStatusChangeEvent extends ApplicationEvent{

	static final NumberFormat TASK_ORDER_ID_FORMAT = new DecimalFormat("0000")
	static final DateFormat TASK_ORDER_DATE_CREATED_FORMAT = new SimpleDateFormat("MM-dd-yyyy 'at' h:mma")
	
	def email
	String status
	
	public TaskOrderStatusChangeEvent(Object source, TaskOrder taskOrder){
		super(source)
		
		this.status = taskOrder.status
		def taskOrderNumber = TASK_ORDER_ID_FORMAT.format(taskOrder.id)
		
		def statusDate = null
		
		if(taskOrder.status == TaskOrder.NEW){
			statusDate = taskOrder.dateCreated
		}else if(taskOrder.status == TaskOrder.SCHEDULED){
			statusDate = taskOrder.dateScheduled
		}else if(taskOrder.status == TaskOrder.COMPLETED){
			statusDate = taskOrder.dateCompleted
		}else if(taskOrder.status == TaskOrder.APPROVED){
			statusDate = taskOrder.dateApproved
		}else if(taskOrder.status == TaskOrder.INVOICED){
			statusDate = taskOrder.dateInvoiced
		}else if(taskOrder.status == TaskOrder.CERTIFIED){
			statusDate = taskOrder.dateCertified
		}else if(taskOrder.status == TaskOrder.REQUIRES_ATTENTION){
			statusDate = taskOrder.lastUpdated
		}
		
		this.email = [
			subject: "Task Order ${taskOrderNumber}, Status Change $taskOrder.status",
			template:"/taskOrder/email/_task_order",
			model: [taskOrderNumber: taskOrderNumber, statusDate: TASK_ORDER_DATE_CREATED_FORMAT.format(statusDate), status: taskOrder.status]
		]		
	}
	
	
	@Override
	public String toString(){
		return "TaskOrderStatusChangeEvent [status=" + status + ", email=" + email + "]";
	}
	
}
