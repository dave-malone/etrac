package fta.vacs.domain

class Component {

	String name
	String description
	
	User createdBy
	User updatedBy
	Date dateCreated
	Date lastUpdated
	
    static constraints = {
		createdBy nullable:true
		updatedBy nullable:true
		lastUpdated nullable:true
		
		name blank:false, unique:true
		description nullable:true
    }
	
	static mapping = {
		sort name:'desc'
	}

	@Override
	public String toString() {
		return "Component [name=" + name + ", description=" + description + "]";
	}
	
	
}
