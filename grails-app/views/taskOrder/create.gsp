<%@ page import="fta.vacs.domain.TaskOrder" %>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'taskOrder.label', default: 'Task Order')}" scope="request"/>
        <title><g:message code="default.create.label" args="[request.entityName]" /></title>
        <r:script>
        	$(document).ready(function(){
				$("#dueDate").datepicker({dateFormat: 'MM d, yy', changeMonth: true, changeYear: true});
			})
        </r:script>
    </head>
    <body>
            <h1><g:message code="default.create.label" args="[request.entityName]" /></h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${taskOrderInstance}">
	            <div class="errors">
	                <g:renderErrors bean="${taskOrderInstance}" as="list" />
	            </div>
            </g:hasErrors>
            <g:form action="save" method="post" enctype="multipart/form-data">
                
                    <table>
                        <tbody>
                        
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dueDate"><g:message code="taskOrder.dueDate.label" default="Due Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: taskOrderInstance, field: 'dueDate', 'errors')}">
                                    <g:textField name="dueDate" value="${taskOrderInstance?.dueDate?.format('MMMM d, yyyy')}" />
                                </td>
                            </tr>
                        
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contractNumber"><g:message code="taskOrder.contractNumber.label" default="Contract Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: taskOrderInstance, field: 'contractNumber', 'errors')}">
                                    <g:textField name="contractNumber" value="${taskOrderInstance?.contractNumber}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="vaInternalNumber"><g:message code="taskOrder.vaInternalNumber.label" default="VA Internal PO Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: taskOrderInstance, field: 'vaInternalNumber', 'errors')}">
                                	<g:textArea name="vaInternalNumber" style="width:200px; height:50px;"/>  
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="priority"><g:message code="taskOrder.priority.label" default="Priority" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: taskOrderInstance, field: 'priority', 'errors')}">
                                    <g:select name="priority" from="${taskOrderInstance.constraints.priority.inList}" value="${taskOrderInstance?.priority}" valueMessagePrefix="taskOrder.priority"  />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="installationInstructionsFile">Installation Instructions <br /> (PDF or Word Doc)</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: taskOrderInstance, field: 'installationInstructions', 'errors')}">
                                    <input type="file" id="installationInstructionsFile" name="installationInstructionsFile" multiple="multiple" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="room"><g:message code="taskOrder.room.label" default="Room" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: taskOrderInstance, field: 'room', 'errors')}">
                                    <g:textField name="room" value="${fieldValue(bean: taskOrderInstance, field: 'room')}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="closets"><g:message code="taskOrder.closet.label" default="Closet" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: taskOrderInstance, field: 'closet', 'errors')}">
                                    <g:textField name="closet" value="${fieldValue(bean: taskOrderInstance, field: 'closet')}" />
                                </td>
                            </tr>
                            
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="installationType"><g:message code="taskOrder.installationType.label" default="Installation Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: taskOrderInstance, field: 'installationType', 'errors')}">
                                    <g:radioGroup name="installationType" values="${taskOrderInstance.constraints.installationType.inList}" labels="${taskOrderInstance.constraints.installationType.inList}" value="${taskOrderInstance?.installationType}">
                                    	<span style="margin-right:20px;">${it.radio} ${it.label}</span>
                                    </g:radioGroup>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="panelType"><g:message code="taskOrder.panelType.label" default="Panel Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: taskOrderInstance, field: 'panelType', 'errors')}">
                                	<g:radioGroup name="panelType" values="${taskOrderInstance.constraints.panelType.inList}" labels="${taskOrderInstance.constraints.panelType.inList}" value="${taskOrderInstance?.panelType}">
                                    	<span style="margin-right:20px;">${it.radio} ${it.label}</span>
                                    </g:radioGroup>
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numberOfCables"><g:message code="taskOrder.numberOfCables.label" default="Total Number Of Cables" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: taskOrderInstance, field: 'numberOfCables', 'errors')}">
                                    <g:textField name="numberOfCables" value="${fieldValue(bean: taskOrderInstance, field: 'numberOfCables')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numberOfLocations"><g:message code="taskOrder.numberOfLocations.label" default="Number Of Locations" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: taskOrderInstance, field: 'numberOfLocations', 'errors')}">
                                    <g:textField name="numberOfLocations" value="${fieldValue(bean: taskOrderInstance, field: 'numberOfLocations')}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="existingPatchPanel"><g:message code="taskOrder.existingPatchPanel.label" default="Existing Patch Panel" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: taskOrderInstance, field: 'existingPatchPanel', 'errors')}">
                                    <g:checkBox name="existingPatchPanel" value="${taskOrderInstance?.existingPatchPanel}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="existingRack"><g:message code="taskOrder.existingRack.label" default="Existing Rack" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: taskOrderInstance, field: 'existingRack', 'errors')}">
                                    <g:checkBox name="existingRack" value="${taskOrderInstance?.existingRack}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name" colspan="2">
                                    <label for="comment">Additional Notes/Comments</label>
                                    <br />
                                    <g:textArea name="comment" style="width:550px; height:75px;"/>  
                                </td>
                            </tr>                        
                        </tbody>
                    </table>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Submit Task Order')}" /></span>
                </div>
            </g:form>
    </body>
</html>
