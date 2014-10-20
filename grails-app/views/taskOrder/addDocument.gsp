

<%@ page import="fta.vacs.domain.TaskOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'taskOrder.label', default: 'Task Order')}" scope="request"/>
        <title>Attach a Document to Task Order <g:formatNumber number="${taskOrderInstance.id}" format="0000" /></title>
    </head>
    <body>
        <div class="body">
            <h1>Attach a Document to Task Order <g:formatNumber number="${taskOrderInstance.id}" format="0000" /></h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${taskOrderInstance}">
	            <div class="errors">
	                <g:renderErrors bean="${taskOrderInstance}" as="list" />
	            </div>
            </g:hasErrors>
            <g:form action="uploadDocument" method="post" enctype="multipart/form-data">
                <g:hiddenField name="id" value="${taskOrderInstance?.id}" />
                <g:hiddenField name="version" value="${taskOrderInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="room">Title</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: taskOrderInstance, field: 'room', 'errors')}">
                                    <g:textField name="title" value="" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="document">Document</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: taskOrderInstance, field: 'installationInstructions', 'errors')}">
                                    <input type="file" id="document" name="document" />
                                </td>
                            </tr>                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="uploadDocument" value="Attach Document to Task Order" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
