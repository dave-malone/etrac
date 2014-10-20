
<%@ page import="fta.vacs.domain.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" scope="request"/>
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
                            <g:sortableColumn property="id" title="${message(code: 'user.id.label', default: 'Id')}" />
                            <g:sortableColumn property="firstName" title="${message(code: 'user.firstName.label', default: 'First Name')}" />                        
                            <g:sortableColumn property="lastName" title="${message(code: 'user.lastName.label', default: 'Last Name')}" />
                            <g:sortableColumn property="username" title="${message(code: 'user.username.label', default: 'Email')}" />
                            <g:sortableColumn property="phoneNumber" title="${message(code: 'user.phoneNumber.label', default: 'Phone Number')}" />                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${userInstanceList}" status="i" var="userInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">                        
                            <td><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "id")}</g:link></td>
                        	<td>${fieldValue(bean: userInstance, field: "firstName")}</td>                        
                            <td>${fieldValue(bean: userInstance, field: "lastName")}</td>                        
                            <td>${fieldValue(bean: userInstance, field: "username")}</td>                        
                            <td>${fieldValue(bean: userInstance, field: "phoneNumber")}</td>                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${userInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
