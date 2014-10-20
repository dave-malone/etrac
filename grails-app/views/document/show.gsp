
<%@ page import="fta.vacs.domain.Document" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}" scope="request"/>
        <title><g:message code="default.show.label" args="[request.entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.show.label" args="[request.entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="document.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="document.mimeType.label" default="Mime Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "mimeType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="document.extension.label" default="Extension" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "extension")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="document.updatedBy.label" default="Updated By" /></td>
                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${documentInstance?.updatedBy?.id}">${documentInstance?.updatedBy?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="document.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${documentInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="document.originalFileName.label" default="Original Filename" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "originalFileName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="document.path.label" default="Path" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "path")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="document.sizeInBytes.label" default="Size In Bytes" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: documentInstance, field: "sizeInBytes")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="document.createdBy.label" default="Created By" /></td>
                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${documentInstance?.createdBy?.id}">${documentInstance?.createdBy?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="document.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${documentInstance?.dateCreated}" /></td>
                            
                        </tr>                                        
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${documentInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
