package fta.vacs.domain

import java.util.Date;

class Document {

	static transients = ['data']
	
	byte[] data
	
	String title
	
	String mimeType
	String extension
	String originalFileName
	String path
	int sizeInBytes
	
	User createdBy
	User updatedBy
	Date dateCreated
	Date lastUpdated
	
    static constraints = {
		mimeType blank:false
		extension blank:false
		
		title nullable:true
		createdBy nullable:true
		updatedBy nullable:true
		lastUpdated nullable:true
		originalFileName nullable:true
		data nullable:true
		path nullable:true
		sizeInBytes nullable:true
    }
}
