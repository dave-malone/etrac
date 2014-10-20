package fta.vacs.service

import fta.vacs.domain.Document
import fta.vacs.domain.User
import org.springframework.beans.factory.InitializingBean
import org.springframework.web.multipart.MultipartFile
import org.apache.commons.io.FileUtils
import org.apache.commons.lang.StringUtils

class DocumentService implements InitializingBean{

    static transactional = true

	def docsDir
	def grailsApplication
	
	void afterPropertiesSet(){
		this.docsDir = grailsApplication.config.docUploadDir
		log.debug 'doc upload directory set to ' + this.docsDir
	}
	
    def create(MultipartFile mpf) {
		if(mpf != null && !mpf.empty && mpf.size > 0){
			log.debug 'creating new Document'
			log.debug mpf.properties
			log.debug mpf.empty
			log.debug mpf.size
			log.debug mpf.originalFilename
			log.debug mpf.contentType
			
				
			def document = new Document(originalFileName: mpf.originalFilename,
									sizeInBytes: mpf.size,
									mimeType: mpf.contentType,
									extension: mpf.originalFilename.substring(mpf.originalFilename.lastIndexOf('.') + 1),
									data: mpf.bytes)

			
//			User currentUser = userService.getCurrentUser()
//			log.debug "current user: $currentUser"
//			document.createdBy = currentUser
			
			if(document.save()){
				saveDocumentToFS(document)	
				document.save()				
				return document
			}else{
				log.debug 'failed to save the document: ' + document.errors
			}
		}
		
		return null
    }
	

	void saveDocumentToFS(Document doc){
		log.debug 'saving doc to the file system'
		try{
			String docPath = getDocPath(doc)
			File file = new File(docPath)
			log.debug "saving doc to " + file.absolutePath
			FileUtils.writeByteArrayToFile(file, doc.data)
			doc.path = docPath
		}catch(Exception e){
			log.debug "an error occurred when attempting to write doc to file system" + e.message
		}
	}
	
   /**
	* document path format:  {docsDir}/{doc.id}-{doc.originalFileName}
	* 
	*/
   def String getDocPath(Document doc){
	   return "${this.docsDir}/${doc.id}-${doc.originalFileName}"
   }
}
