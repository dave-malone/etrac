package fta.vacs.domain

import org.apache.commons.lang.builder.HashCodeBuilder

import java.io.Serializable;
import java.util.Date;

class InstalledComponent implements Serializable{

	static belongsTo = [taskOrder: TaskOrder, component : Component]
	
	User createdBy
	User updatedBy
	Date dateCreated
	Date lastUpdated
	
	String quantity
	
    static constraints = {
		createdBy nullable:true
		updatedBy nullable:true
		lastUpdated nullable:true
		
		component nullable:false
		quantity blank:false
    }
	@Override
	public boolean equals(Object that) {
		if (!(that instanceof InstalledComponent)) {
			return false
		}

		that.taskOrder?.id == taskOrder?.id &&
		that.component?.id == component?.id &&
		that.quantity == quantity
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (taskOrder) builder.append(taskOrder.id)
		if (component) builder.append(component.id)
		if(quantity) builder.append(quantity)
		builder.toHashCode()
	}
	

	@Override
	public String toString() {
		return "InstalledComponent [component=" + component + ", quantity=" + quantity + "]";
	}
	
	static mapping = {
		id composite: ['taskOrder', 'component']
		version false
	}
	
	
}
