package fta.vacs.domain

import java.util.Date;

import org.springframework.web.multipart.MultipartFile

class TaskOrder {

	
	static final String NEW = "Posted"
	static final String SCHEDULED = "Scheduled"
	static final String COMPLETED = "Completed"
	static final String APPROVED = "Approved"
	static final String INVOICED = "Invoiced"
	static final String CERTIFIED = "Certified"
	static final String CANCELED = "Canceled"
	static final String REQUIRES_ATTENTION = "Requires Attention"
	static final String ADD = "Add"
	static final String MOVE = "Move"
	static final String FACE_PLATE = "Flush Wall Mt."
	static final String SURFACE_MOUNT = "Suface Mount"
	static final String FURNITURE_MOUNT = "Furniture Mount"
	static final String URGENT = "Urgent"
	static final String HIGH = "High"
	static final String STANDARD = "Standard"
	
	
	static hasMany = [comments : Comment, installedComponents : InstalledComponent, documents : Document]
	
	User createdBy
	User updatedBy
	Date dateCreated
	Date dateScheduled
	Date dateCompleted
	Date dateApproved
	Date dateInvoiced
	Date dateCertified
	Date dateCanceled
	Date lastUpdated
	
	String room
	String closet
	String priority = STANDARD
	String status = NEW
	String installationType = ADD
	String panelType
	Integer numberOfCables = 0
	Integer numberOfLocations = 1
	Boolean existingPatchPanel
	Boolean existingRack	
	
	String contractNumber
	String vaInternalNumber
	
    static constraints = {
		createdBy nullable:true
		updatedBy nullable:true
		dateScheduled nullable:true
		dateCompleted nullable:true
		dateApproved nullable:true
		dateInvoiced nullable:true
		dateCertified nullable:true
		dateCanceled nullable:true
		lastUpdated nullable:true
		
		room blank:false
		closet blank:false
		installationType nullable:false, inList:[ADD, MOVE]
		panelType nullable:false, inList:[FACE_PLATE, SURFACE_MOUNT, FURNITURE_MOUNT]
		status nullable:false, inList:[NEW, SCHEDULED, COMPLETED, APPROVED, INVOICED, CERTIFIED, REQUIRES_ATTENTION, CANCELED]
		priority nullable:false, inList:[STANDARD, HIGH, URGENT]
    }
	
	static mapping = {
		comments sort:'dateCreated', order:'desc'
	}
}
