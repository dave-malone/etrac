
<%@ page import="fta.vacs.domain.TaskOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'taskOrder.label', default: 'Task Order')}" scope="request"/>
        <title><g:message code="default.create.label" args="[request.entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1>Task Orders</h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>                        
                            <g:sortableColumn property="id" title="${message(code: 'taskOrder.id.label', default: 'TO Number')}" />
                            <g:sortableColumn property="vaInternalNumber" title="${message(code: 'taskOrder.vaInternalNumber.label', default: 'VA PO')}" />
                            <g:sortableColumn property="priority" title="${message(code: 'taskOrder.priority.label', default: 'Priority')}" /> 
                            <g:sortableColumn property="room" title="${message(code: 'taskOrder.room.label', default: 'Room')}" /> 
                            <g:sortableColumn property="numberOfCables" title="${message(code: 'taskOrder.numberOfCables.label', default: 'Number of Cables')}" />
                            <g:sortableColumn property="numberOfLocations" title="${message(code: 'taskOrder.numberOfLocations.label', default: 'Number of Locations')}" />  
                            <g:sortableColumn property="status" title="${message(code: 'taskOrder.status.label', default: 'Status')}" />
                            <th>Time</th>                                          
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${taskOrderInstanceList}" status="i" var="taskOrderInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">                        
                            <td><g:link action="show" id="${taskOrderInstance.id}"><g:formatNumber number="${taskOrderInstance.id}" format="0000" /></g:link></td>
                            <td>${fieldValue(bean: taskOrderInstance, field: "vaInternalNumber").replace("\n", "<br />")}</td>
                            <td>${fieldValue(bean: taskOrderInstance, field: "priority")}</td>
                            <td>${fieldValue(bean: taskOrderInstance, field: "room")}</td>
                            <td>${fieldValue(bean: taskOrderInstance, field: "numberOfCables")}</td>
                            <td>${fieldValue(bean: taskOrderInstance, field: "numberOfLocations")}</td>
                            <td>${fieldValue(bean: taskOrderInstance, field: "status")}</td>  
                            <td>
                            	<g:if test="${taskOrderInstance.status == 'Posted'}">
                            		${groovy.time.TimeCategory.minus( new Date(), taskOrderInstance.dateCreated ).toString()}
                            	</g:if>
                            	<g:if test="${taskOrderInstance.status == 'Completed'}">
                            		${groovy.time.TimeCategory.minus( new Date(), taskOrderInstance.dateCompleted ).toString()}
                            	</g:if>
                            	<g:if test="${taskOrderInstance.status == 'Approved'}">
                            		${groovy.time.TimeCategory.minus( new Date(), taskOrderInstance.dateApproved ).toString()}
                            	</g:if>
                            	<g:if test="${taskOrderInstance.status == 'Invoiced'}">
                            		${groovy.time.TimeCategory.minus( new Date(), taskOrderInstance.dateInvoiced ).toString()}
                            	</g:if>
                            	<g:if test="${taskOrderInstance.status == 'Requires Attention'}">
                            		${groovy.time.TimeCategory.minus( new Date(), taskOrderInstance.lastUpdated ).toString()}
                            	</g:if>
                            </td>                                                     
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${taskOrderInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
