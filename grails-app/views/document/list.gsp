
<%@ page import="fta.vacs.domain.Document" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}" scope="request"/>
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
                            <g:sortableColumn property="id" title="${message(code: 'document.id.label', default: 'Id')}" />                        
                            <g:sortableColumn property="originalFileName" title="${message(code: 'document.originalFileName.label', default: 'Original Filename')}" />                        
                            <th><g:message code="document.createdBy.label" default="Created By" /></th>                        
                            <g:sortableColumn property="path" title="${message(code: 'document.path.label', default: 'Path on Disk')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${documentInstanceList}" status="i" var="documentInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">                        
                            <td><g:link action="show" id="${documentInstance.id}">${fieldValue(bean: documentInstance, field: "id")}</g:link></td>                        
                        	<td>${fieldValue(bean: documentInstance, field: "originalFileName")}</td>
                        	<td>${documentInstance.createdBy?.fullName}</td>
                            <td>${documentInstance.path}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="pagination">
                <g:paginate total="${documentInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
