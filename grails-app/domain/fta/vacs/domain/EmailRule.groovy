package fta.vacs.domain

class EmailRule {

	static hasMany = [usersToEmail: User]
	
	String status	
	
	Date dateCreated	
	
    static constraints = {
		status blank:false, unique:true, inList: [TaskOrder.NEW, TaskOrder.SCHEDULED, TaskOrder.COMPLETED, TaskOrder.APPROVED, TaskOrder.INVOICED, TaskOrder.CERTIFIED, TaskOrder.REQUIRES_ATTENTION, TaskOrder.CANCELED]
    }
}
