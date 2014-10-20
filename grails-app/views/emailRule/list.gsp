
<%@ page import="fta.vacs.domain.EmailRule" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'emailRule.label', default: 'Email Rule')}" scope="request"/>
        <title><g:message code="default.list.label" args="[request.entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.list.label" args="[request.entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'emailRule.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="status" title="${message(code: 'emailRule.status.label', default: 'Status')}" />
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'emailRule.dateCreated.label', default: 'Date Created')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${emailRuleInstanceList}" status="i" var="emailRuleInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${emailRuleInstance.id}">${fieldValue(bean: emailRuleInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: emailRuleInstance, field: "status")}</td>
                        
                            <td><g:formatDate date="${emailRuleInstance.dateCreated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="pagination">
                <g:paginate total="${emailRuleInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
