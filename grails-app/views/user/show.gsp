
<%@ page import="fta.vacs.domain.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title>${userInstance.firstName} ${userInstance.lastName}</title>
    </head>
    <body>
        <div class="body">
            <h1>${userInstance.firstName} ${userInstance.lastName}</h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.username.label" default="Email" /></td>                            
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "username")}</td>                            
                        </tr>                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.phoneNumber.label" default="Phone Number" /></td>                            
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "phoneNumber")}</td>                            
                        </tr>
                                                
                        <sec:ifAnyGranted roles="ROLE_FTA_ADMIN">                    
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="user.accountExpired.label" default="Account Expired" /></td>	                            
	                            <td valign="top" class="value"><g:formatBoolean boolean="${userInstance?.accountExpired}" /></td>	                            
	                        </tr>
	                    
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="user.accountLocked.label" default="Account Locked" /></td>	                            
	                            <td valign="top" class="value"><g:formatBoolean boolean="${userInstance?.accountLocked}" /></td>	                            
	                        </tr>
	                    
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="user.enabled.label" default="Enabled" /></td>	                            
	                            <td valign="top" class="value"><g:formatBoolean boolean="${userInstance?.enabled}" /></td>	                            
	                        </tr>
	                    
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="user.passwordExpired.label" default="Password Expired" /></td>	                            
	                            <td valign="top" class="value"><g:formatBoolean boolean="${userInstance?.passwordExpired}" /></td>	                            
	                        </tr>
                    	</sec:ifAnyGranted>
                    </tbody>
                </table>
            </div>
            <sec:ifAnyGranted roles="ROLE_FTA_ADMIN"> 
	            <div class="buttons">
	                <g:form>
	                    <g:hiddenField name="id" value="${userInstance?.id}" />
	                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
	                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
	                </g:form>
	            </div>
            </sec:ifAnyGranted>
        </div>
    </body>
</html>
