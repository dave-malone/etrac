package fta.vacs.controller

import fta.vacs.domain.Document
import grails.plugins.springsecurity.Secured
import javax.servlet.ServletOutputStream

@Secured(['ROLE_FTA_ADMIN'])
class DocumentController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	@Secured(['IS_AUTHENTICATED_REMEMBERED'])
	def download = {
		Document document = Document.get(params.id)
		
		File file = new File(document.path)
		
		ServletOutputStream op = response.getOutputStream()		
		String mimetype = servletContext.getMimeType(document.path)

		//  Set the response and go!

		response.setContentType((mimetype != null) ? mimetype : "application/octet-stream")
		response.setContentLength((int)file.length())
		response.setHeader("Content-Disposition", "attachment; filename=\"${document.originalFileName}\"")


		//  Stream to the requester.
		byte[] bbuf = new byte[2048]
		int length = 0
		DataInputStream is = new DataInputStream(new FileInputStream(file))
		while ((is != null) && ((length = is.read(bbuf)) != -1))
		{
			op.write(bbuf,0,length)
		}

		is.close()
		op.flush()
		op.close()
		
		return null
	}

	def index = {
		redirect(action: "list", params: params)
	}

	def list = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[documentInstanceList: Document.list(params), documentInstanceTotal: Document.count()]
	}

	def create = {
		def documentInstance = new Document()
		documentInstance.properties = params
		return [documentInstance: documentInstance]
	}

	def save = {
		def documentInstance = new Document(params)
		if (documentInstance.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'document.label', default: 'Document'), documentInstance.id])}"
			redirect(action: "show", id: documentInstance.id)
		}
		else {
			render(view: "create", model: [documentInstance: documentInstance])
		}
	}

	def show = {
		def documentInstance = Document.get(params.id)
		if (!documentInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])}"
			redirect(action: "list")
		}
		else {
			[documentInstance: documentInstance]
		}
	}

	def edit = {
		def documentInstance = Document.get(params.id)
		if (!documentInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [documentInstance: documentInstance]
		}
	}

	def update = {
		def documentInstance = Document.get(params.id)
		if (documentInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (documentInstance.version > version) {

					documentInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'document.label', default: 'Document')] as Object[], "Another user has updated this Document while you were editing")
					render(view: "edit", model: [documentInstance: documentInstance])
					return
				}
			}
			documentInstance.properties = params
			if (!documentInstance.hasErrors() && documentInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'document.label', default: 'Document'), documentInstance.id])}"
				redirect(action: "show", id: documentInstance.id)
			}
			else {
				render(view: "edit", model: [documentInstance: documentInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])}"
			redirect(action: "list")
		}
	}

	def delete = {
		def documentInstance = Document.get(params.id)
		if (documentInstance) {
			try {
				documentInstance.delete(flush: true)
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'document.label', default: 'Document'), params.id])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'document.label', default: 'Document'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])}"
			redirect(action: "list")
		}
	}
}
