
<%@ page import="fta.vacs.domain.TaskOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'taskOrder.label', default: 'Task Order')}" scope="request"/>
        <title>Task Order <g:formatNumber number="${taskOrderInstance.id}" format="0000" /></title>
    </head>
    <body>
        <div class="body">
        	<h1>Task Order <g:formatNumber number="${taskOrderInstance.id}" format="0000" /></h1>
        
        	<div class="trail">
        		<span class="completed">Posted</span>
				<img src="${resource(dir:'images',file:'ico-next.gif')}" alt="next">
				<g:if test="${taskOrderInstance.status != 'Canceled'}">
					<span class="${taskOrderInstance.status in ['Completed','Approved','Invoiced','Certified'] ? 'completed' : 'uncompleted'}">
						Completed
					</span>
					<img src="${resource(dir:'images',file:'ico-next.gif')}" alt="next">
					<span class="${taskOrderInstance.status in ['Approved','Invoiced','Certified'] ? 'completed' : 'uncompleted'}">
						Approved
					</span>	
					<img src="${resource(dir:'images',file:'ico-next.gif')}" alt="next">
					<span class="${taskOrderInstance.status in ['Invoiced','Certified'] ? 'completed' : 'uncompleted'}">
						Invoiced
					</span>	
					<img src="${resource(dir:'images',file:'ico-next.gif')}" alt="next">
					<span class="${taskOrderInstance.status == 'Certified' ? 'completed' : 'uncompleted'}">
						Certified
					</span>	
				</g:if>	
				<g:else>
					<span class="completed">Canceled</span>	
				</g:else>
			</div>  
        
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <g:if test="${taskOrderInstance.status == 'Requires Attention'}">
            	<div class="errors"><ul><li>This task order Requires Attention before it can move to the next status.  Please check the comments at the bottom of the page</li></ul></div>
            </g:if>
            <g:if test="${taskOrderInstance.status == 'Canceled'}">
            	<div class="errors"><ul><li>This task order has been Canceled</li></ul></div>
            </g:if>
            
            
            <div class="dialog">
            	<table>
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="taskOrder.dateCreated.label" default="Date Posted" /></td>                            
                            <td valign="top" class="value"><g:formatDate date="${taskOrderInstance?.dateCreated}" format="MMM d, yyyy 'at' H:mmz"/></td>                            
                        </tr>
                        
                        <g:if test="${taskOrderInstance?.status in ['Completed', 'Approved', 'Invoiced', 'Certified']}">
                        	<tr class="prop">
	                            <td valign="top" class="name"><g:message code="taskOrder.dateCompleted.label" default="Date Completed" /></td>	                            
	                            <td valign="top" class="value"><g:formatDate date="${taskOrderInstance?.dateCompleted}" format="MMM d, yyyy 'at' H:mmz" /></td>	                            
	                        </tr>
	                    </g:if>	                    
	                    <g:if test="${taskOrderInstance?.status in ['Approved', 'Invoiced', 'Certified']}">
		                    <tr class="prop">
	                            <td valign="top" class="name"><g:message code="taskOrder.dateApproved.label" default="Date Approved" /></td>	                            
	                            <td valign="top" class="value"><g:formatDate date="${taskOrderInstance?.dateApproved}" format="MMM d, yyyy 'at' H:mmz" /></td>	                            
	                        </tr>                 
                        </g:if>                    
                    	<g:if test="${taskOrderInstance?.status in ['Invoiced', 'Certified']}">
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="taskOrder.dateInvoiced.label" default="Date Invoiced" /></td>	                            
	                            <td valign="top" class="value"><g:formatDate date="${taskOrderInstance?.dateInvoiced}" format="MMM d, yyyy 'at' H:mmz" /></td>	                            
	                        </tr>
                    	</g:if>
                    	<g:if test="${taskOrderInstance?.status == 'Certified'}">
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="taskOrder.dateCertified.label" default="Date Certified" /></td>	                            
	                            <td valign="top" class="value"><g:formatDate date="${taskOrderInstance?.dateCertified}" format="MMM d, yyyy 'at' H:mmz" /></td>	                            
	                        </tr>
                        </g:if>
                        <g:if test="${taskOrderInstance?.status == 'Canceled'}">
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="taskOrder.dateCanceled.label" default="Date Canceled" /></td>	                            
	                            <td valign="top" class="value"><g:formatDate date="${taskOrderInstance?.dateCanceled}" format="MMM d, yyyy 'at' H:mmz" /></td>	                            
	                        </tr>
                        </g:if>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="taskOrder.createdBy.label" default="Posted By" /></td>                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${taskOrderInstance?.createdBy?.id}">${taskOrderInstance?.createdBy?.encodeAsHTML()}</g:link></td>                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="taskOrder.contractNumber.label" default="Contract Number" /></td>                            
                            <td valign="top" class="value">${fieldValue(bean: taskOrderInstance, field: "contractNumber")}</td>                            
                        </tr>
                        
                         <tr class="prop">
                            <td valign="top" class="name"><g:message code="taskOrder.vaInternalNumber.label" default="VA Internal PO Number" /></td>                            
                            <td valign="top" class="value">${fieldValue(bean: taskOrderInstance, field: "vaInternalNumber").replace("\n", "<br />")}</td>                            
                        </tr>                        
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="taskOrder.priority.label" default="Priority" /></td>                            
                            <td valign="top" class="value">${fieldValue(bean: taskOrderInstance, field: "priority")}</td>                            
                        </tr>
                    
                    	<tr class="prop">
                            <td valign="top" class="name"><g:message code="taskOrder.room.label" default="Room" /></td>                            
                            <td valign="top" class="value">${fieldValue(bean: taskOrderInstance, field: "room")}</td>                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="taskOrder.closet.label" default="Closet" /></td>                            
                            <td valign="top" class="value">${fieldValue(bean: taskOrderInstance, field: "closet")}</td>                            
                        </tr>
                    
                    	<tr class="prop">
                            <td valign="top" class="name"><g:message code="taskOrder.installationType.label" default="Installation Type" /></td>                            
                            <td valign="top" class="value">${fieldValue(bean: taskOrderInstance, field: "installationType")}</td>                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="taskOrder.panelType.label" default="Panel Type" /></td>                            
                            <td valign="top" class="value">${fieldValue(bean: taskOrderInstance, field: "panelType")}</td>                            
                        </tr>
                        
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="taskOrder.numberOfCables.label" default="Number Of Cables" /></td>                            
                            <td valign="top" class="value">${fieldValue(bean: taskOrderInstance, field: "numberOfCables")}</td>                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="taskOrder.numberOfLocations.label" default="Number Of Locations" /></td>                            
                            <td valign="top" class="value">${fieldValue(bean: taskOrderInstance, field: "numberOfLocations")}</td>                            
                        </tr>
                    
                    	<tr class="prop">
                            <td valign="top" class="name"><g:message code="taskOrder.existingPatchPanel.label" default="Existing Patch Panel" /></td>                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${taskOrderInstance?.existingPatchPanel}" true="Yes" false="No" /></td>                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="taskOrder.existingRack.label" default="Existing Rack" /></td>                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${taskOrderInstance?.existingRack}" true="Yes" false="No" /></td>                            
                        </tr> 
                        
                        <tr class="prop">
		                	<td colspan="2">
								<h2>Attached Documents - <g:link action="addDocument" id="${taskOrderInstance?.id}">Add</g:link></h2>
								<br />
								<ul>
			                    	<g:each in="${taskOrderInstance.documents}" var="doc">
			                    		<li>
			                        		<g:link controller="document" action="download" id="${doc?.id}">${doc?.title ?: doc?.originalFileName}</g:link>
			                        	</li>
			                    	</g:each>
			                    </ul>                     	
		                	</td>
		                </tr>
		                <%-- TODO - which status can/can't you edit the list of installed components, and which roles (if any) can modify this list at any time --%>
		                <g:if test="${!(taskOrderInstance.status in ['Posted','Approved','Invoiced','Certified'])}">
		              		<tr class="prop">
		              			<td colspan="2">
			                     	<h2>Installed Components - <g:link action="complete" id="${taskOrderInstance?.id}">Edit</g:link></h2>
			                     	<br />
			                     	<table>
			                     		<tr>
			                     			<th>Component/Item</th>
			                     			<th>Description</th>
			                     			<th>Amount</th>
			                     		</tr>
			                     		<g:each in="${taskOrderInstance.installedComponents}" var="i">
			                     			<tr>
			                               <td>${i.component.name}</td>
			                               <td>${i.component.description}</td>
			                               <td>${i.quantity}</td>
			                              </tr>
			                          </g:each>
			                     	</table>  
		                     	</td>                          	
							</tr>
		                </g:if>            
                    </tbody>
                </table>
                
                <div class="buttons">
	                <g:form>
	                    <g:hiddenField name="id" value="${taskOrderInstance?.id}" />
	                    <g:if test="${taskOrderInstance.status != 'Canceled'}">
	                    	<sec:ifAnyGranted roles="ROLE_FTA_ADMIN, ROLE_VA_TASK_CREATOR">
		                    	<g:if test="${!(taskOrderInstance.status in ['Completed','Approved','Invoiced','Certified'])}">
		                    		<span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>		                    	
		                    	</g:if>
		                    </sec:ifAnyGranted>
		                    <sec:ifAnyGranted roles="ROLE_FTA_ADMIN, ROLE_FTA_INSTALLER">
		                    	<g:if test="${taskOrderInstance.status == 'Posted'}">
				                    <span class="button"><g:actionSubmit class="edit" action="complete" value="${message(code: 'default.button.complete.label', default: 'Complete')}" /></span>
			                    </g:if>
		                    </sec:ifAnyGranted>
		                    <sec:ifAnyGranted roles="ROLE_VA_TASK_APPROVER">
		                    	<g:if test="${taskOrderInstance.status == 'Completed'}">
		                    		<span class="button"><g:actionSubmit class="edit" action="approve" value="${message(code: 'default.button.approve.label', default: 'Approve')}" /></span>
		                    	</g:if>
		                    </sec:ifAnyGranted>
		                    <sec:ifAnyGranted roles="ROLE_FTA_ADMIN, ROLE_FTA_INVOICER">
		                    	<g:if test="${taskOrderInstance.status == 'Approved'}">
		                    		<span class="button"><g:actionSubmit class="edit" action="invoice" value="${message(code: 'default.button.invoice.label', default: 'Invoiced')}" /></span>
		                    	</g:if>
		                    </sec:ifAnyGranted>
		                    <sec:ifAnyGranted roles="ROLE_VA_CERTIFIER">
		                    	<g:if test="${taskOrderInstance.status == 'Invoiced'}">
			                    	<span class="button"><g:actionSubmit class="edit" action="certify" value="${message(code: 'default.button.certify.label', default: 'Certify')}" /></span>
			                    </g:if>		                    
		                    </sec:ifAnyGranted>	
	                    </g:if>   
	                    <sec:ifAnyGranted roles="ROLE_FTA_ADMIN, ROLE_VA_TASK_CREATOR">
	                    	<g:if test="${!(taskOrderInstance.status in ['Completed','Approved','Invoiced','Certified'])}">
	                    		<span class="button"><g:actionSubmit class="delete" action="cancel" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" /></span>
	                    	</g:if>
	                    </sec:ifAnyGranted>                 
	                    <sec:ifAnyGranted roles="ROLE_FTA_ADMIN">
	                    	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
	                    </sec:ifAnyGranted>
	                </g:form>
	            </div>
                
                
                
                <div class="comments" style="border:1px solid #ccc; margin-top:15px; padding:5px;">
					<h2><g:message code="taskOrder.comments.label" default="Comments" /></h2>
					
					<g:form action="comment" method="post" style="margin:20px 0;">
						<input type="hidden" name="taskOrderId" value="${taskOrderInstance?.id}" />
						<textarea style="width:790px;" cols="10" rows="10" name="comment"></textarea>
						<br />
						<input type="submit" name="Post Comment" value="Post Comment" />
						<sec:ifAnyGranted roles="ROLE_VA_CERTIFIER, ROLE_VA_TASK_APPROVER">
	                    	<g:if test="${taskOrderInstance.status in ['Completed', 'Invoiced'] }">
	                    		<span class="button"><g:actionSubmit class="edit" action="requiresAttention" value="${message(code: 'default.button.requiresAttention.label', default: 'Requires Attention')}" /></span>
	                    	</g:if>
	                    </sec:ifAnyGranted>
					</g:form>					

					<g:each in="${taskOrderInstance.comments}" var="c" status="i">
						<div style="width:800px; margin:12px 0; text-align: justify;" class="${(i % 2) == 0 ? 'odd' : 'even'}">
							<h4><g:link controller="user" action="show" id="${c?.createdBy?.id}">${c?.createdBy?.fullName}</g:link> - <g:formatDate date="${c?.dateCreated}" format="MMMM d, yyyy 'at' H:mm"/></h4>
							<p style="padding:10px;">${c?.text}</p>
						</div>
					</g:each>
               </div>
            </div>            
        </div>
    </body>
</html>
