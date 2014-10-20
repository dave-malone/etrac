package fta.vacs.domain

class Comment {

	static belongsTo = [createdBy : User, taskOrder: TaskOrder]
	
	String text
	
	User updatedBy
	Date dateCreated
	Date lastUpdated
	
	static constraints = {
		text blank:false, maxSize:10000
		
		createdBy nullable:true
		updatedBy nullable:true
		lastUpdated nullable:true
    }
	
	static mapping = {
		text type: 'text'
		sort dateCreated:'desc'
	}
	
}
