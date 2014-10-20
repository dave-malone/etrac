

<%@ page import="fta.vacs.domain.Document" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}" scope="request"/>
        <title><g:message code="default.create.label" args="[request.entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.create.label" args="[request.entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${documentInstance}">
            <div class="errors">
                <g:renderErrors bean="${documentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save"  enctype="multipart/form-data">
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="mimeType"><g:message code="document.mimeType.label" default="Mime Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'mimeType', 'errors')}">
                                    <g:textField name="mimeType" value="${documentInstance?.mimeType}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="extension"><g:message code="document.extension.label" default="Extension" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'extension', 'errors')}">
                                    <g:textField name="extension" value="${documentInstance?.extension}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updatedBy"><g:message code="document.updatedBy.label" default="Updated By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'updatedBy', 'errors')}">
                                    <g:select name="updatedBy.id" from="${fta.vacs.domain.User.list()}" optionKey="id" value="${documentInstance?.updatedBy?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="originalFileName"><g:message code="document.originalFileName.label" default="Original Filename" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'originalFileName', 'errors')}">
                                    <g:textField name="originalFileName" value="${documentInstance?.originalFileName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="path"><g:message code="document.path.label" default="Path" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'path', 'errors')}">
                                    <g:textField name="path" value="${documentInstance?.path}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="sizeInBytes"><g:message code="document.sizeInBytes.label" default="Size In Bytes" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'sizeInBytes', 'errors')}">
                                    <g:textField name="sizeInBytes" value="${fieldValue(bean: documentInstance, field: 'sizeInBytes')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="createdBy"><g:message code="document.createdBy.label" default="Created By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'createdBy', 'errors')}">
                                    <g:select name="createdBy.id" from="${fta.vacs.domain.User.list()}" optionKey="id" value="${documentInstance?.createdBy?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="document.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${documentInstance?.name}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
