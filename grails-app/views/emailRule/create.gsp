

<%@ page import="fta.vacs.domain.EmailRule" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'emailRule.label', default: 'Email Rule')}" scope="request"/>
        <title><g:message code="default.create.label" args="[request.entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.create.label" args="[request.entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${emailRuleInstance}">
            <div class="errors">
                <g:renderErrors bean="${emailRuleInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="emailRule.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: emailRuleInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${emailRuleInstance.constraints.status.inList}" value="${emailRuleInstance?.status}" valueMessagePrefix="emailRule.status"  />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="usersToEmail"><g:message code="emailRule.usersToEmail.label" default="Users To Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: emailRuleInstance, field: 'usersToEmail', 'errors')}">
                                    <g:select name="usersToEmail" from="${fta.vacs.domain.User.list()}" multiple="yes" optionKey="id" size="10" value="${emailRuleInstance?.usersToEmail*.id}" />
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
