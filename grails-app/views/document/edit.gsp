

<%@ page import="fta.vacs.domain.Document" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}" scope="request"/>
        <title><g:message code="default.edit.label" args="[request.entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[request.entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${documentInstance}">
            <div class="errors">
                <g:renderErrors bean="${documentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post"  enctype="multipart/form-data">
                <g:hiddenField name="id" value="${documentInstance?.id}" />
                <g:hiddenField name="version" value="${documentInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
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
                                  <label for="extension"><g:message code="document.extension.label" default="Extension" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: documentInstance, field: 'extension', 'errors')}">
                                    <g:textField name="extension" value="${documentInstance?.extension}" />
                                </td>
                            </tr>                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
