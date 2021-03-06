
<%@ page import="fta.vacs.domain.UserRole" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'userRole.label', default: 'UserRole')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        	<%-- 
                            <g:sortableColumn property="role.authority" title="${message(code: 'userRole.role.label', default: 'Role')}" />
                            <g:sortableColumn property="user.username" title="${message(code: 'userRole.user.label', default: 'User')}" />
                            --%>
                            <th>Role</th>
                            <th>User</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${userRoleInstanceList}" status="i" var="userRoleInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td>${userRoleInstance?.role?.authority}</td>
                            <td>${fieldValue(bean: userRoleInstance, field: "user")}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="pagination">
                <g:paginate total="${userRoleInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
