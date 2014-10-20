
<%@ page import="fta.vacs.domain.TaskOrder" %>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Task Orders</title>
    </head>
    <body>
        <h1>Task Order Dashboard</h1>
        <g:if test="${flash.message}">
        	<div class="message">${flash.message}</div>
        </g:if>
        
        <h2>Task Orders</h2>
       	<g:form name="taskOrderSearch" action="list" method="GET">
       		Status:<g:select name="status" from="${TaskOrder.constraints.status.inList}" value="${selectedStatuses}" multiple="true"/>
       		Priority:<g:select name="priority" from="${TaskOrder.constraints.priority.inList}" value="${selectedPriorities}" multiple="true"/>
       		<input type="submit" value="Reset" id="resetTaskOrderSearch" />
       	</g:form>
        
        
        <g:set var="sortAndPaginationParams" value="${['status':selectedStatuses, 'priority':selectedPriorities] }"/>
        
        <g:if test="${taskOrders}">
	        <table>
	            <thead>
	                <tr>                        
	                    <g:sortableColumn property="id" params="${sortAndPaginationParams}" title="${message(code: 'taskOrder.id.label', default: 'TO Number')}" />
	                    <g:sortableColumn property="vaInternalNumber" params="${sortAndPaginationParams}" title="${message(code: 'taskOrder.vaInternalNumber.label', default: 'VA PO')}" />
	                    <g:sortableColumn property="priority" params="${sortAndPaginationParams}" title="${message(code: 'taskOrder.priority.label', default: 'Priority')}" /> 
	                    <g:sortableColumn property="room" params="${sortAndPaginationParams}" title="${message(code: 'taskOrder.room.label', default: 'Room')}" /> 
	                    <g:sortableColumn property="numberOfCables" params="${sortAndPaginationParams}" title="${message(code: 'taskOrder.numberOfCables.label', default: 'Cables')}" />
	                    <g:sortableColumn property="numberOfLocations" params="${sortAndPaginationParams}" title="${message(code: 'taskOrder.numberOfLocations.label', default: 'Locations')}" />
	                    <g:sortableColumn property="status" params="${sortAndPaginationParams}" title="${message(code: 'taskOrder.status.label', default: 'Status')}" />
	                    <th>Time In Current Status</th>
	                    <g:sortableColumn property="dueDate" params="${sortAndPaginationParams}" title="${message(code: 'taskOrder.dueDate.label', default: 'Time Until Due')}" />                                          
	                </tr>
	            </thead>
	            <tbody>
	             <g:each in="${taskOrders}" status="i" var="taskOrder">
	                 <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">                        
	                     <td><g:link action="show" id="${taskOrder.id}"><g:formatNumber number="${taskOrder.id}" format="0000" /></g:link></td>
	                     <td>${fieldValue(bean: taskOrder, field: "vaInternalNumber").replace("\n", "<br />")}</td>
	                     <td>${fieldValue(bean: taskOrder, field: "priority")}</td>
	                     <td>${fieldValue(bean: taskOrder, field: "room")}</td>
	                     <td>${fieldValue(bean: taskOrder, field: "numberOfCables")}</td>
	                     <td>${fieldValue(bean: taskOrder, field: "numberOfLocations")}</td>
	                     <td>${fieldValue(bean: taskOrder, field: "status")}</td> 
	                     <td>
	                     	<g:if test="${taskOrder.status == 'Posted'}">
	                     		<g:set var="statusDate" value="${taskOrder.dateCreated}" />
	                     	</g:if>
	                     	<g:if test="${taskOrder.status == 'Completed'}">
	                     		<g:set var="statusDate" value="${taskOrder.dateCompleted}" />
	                     	</g:if>
	                     	<g:if test="${taskOrder.status == 'Approved'}">
	                     		<g:set var="statusDate" value="${taskOrder.dateApproved}" />
	                     	</g:if>
	                     	<g:if test="${taskOrder.status == 'Invoiced'}">
	                     		<g:set var="statusDate" value="${taskOrder.dateInvoiced}" />
	                     	</g:if>
	                     	<g:if test="${taskOrder.status == 'Requires Attention'}">
	                     		<g:set var="statusDate" value="${taskOrder.lastUpdated}" />
	                     	</g:if>
	                     	<g:else>
	                     		<g:set var="statusDate" value="${null}" />
	                     	</g:else>
	                     	
	                     	<g:if test="${statusDate}">
		                     	<g:set var="durationInCurrentStatus" value="${groovy.time.TimeCategory.minus( new Date(), statusDate )}" />
	                    		${durationInCurrentStatus.days} days, ${durationInCurrentStatus.hours} hours, ${durationInCurrentStatus.minutes} minutes
                    		</g:if>
	                     </td>
						<td>
					<g:if test="${taskOrder.status != 'Completed'}">
	                       	<g:if test="${taskOrder.dueDate}">
	                       		<g:set var="durationUntilDueDate" value="${groovy.time.TimeCategory.minus( taskOrder.dueDate, new Date())}" />
	                       		${durationUntilDueDate.days} days, ${durationUntilDueDate.hours} hours
	                       	</g:if>
	                       	<g:else>
	                       		No Due Date
	                       	</g:else>
	                     	</g:if>
	                     </td>
	                 </tr>
	            	 </g:each>
	            </tbody>
	        </table>
	        <div class="pagination">
	            <g:paginate total="${taskOrderTotal}" params="${sortAndPaginationParams}" />
	        </div>
        </g:if>
        <g:else>
        	<div class="message">No Task Orders found for Statuses ${selectedStatuses} & Priorities ${selectedPriorities}</div>
        </g:else>
        
        <hr />
        
        <h2>eTrac Forum - Ask Questions, Get Answers</h2>
        <g:formRemote name="forum-message-form" url="${[controller: 'forum', action:'message']}" onSuccess="forumMessageCallback(data)">
			<input type="text" id="post-new-message" name="message" placeholder="Post a Message or Ask a Question - Hit Enter to Submit"/>
		</g:formRemote>
		
		<ul id="forum-messages">			
			<g:each in="${recentForumMessages}" var="message">
				<g:render model="${[message:message]}" template="/forum/message" />				
			</g:each>
		</ul>
    </body>
</html>
