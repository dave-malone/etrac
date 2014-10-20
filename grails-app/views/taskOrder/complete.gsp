
<%@ page import="fta.vacs.domain.TaskOrder" %>
<%@ page import="fta.vacs.domain.Component" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'taskOrder.label', default: 'Task Order')}" scope="request"/>
        <title>Complete Task Order <g:formatNumber number="${taskOrderInstance.id}" format="0000" /></title>  
    </head>
    <body>
        <div class="body">
            <h1>Complete Task Order <g:formatNumber number="${taskOrderInstance.id}" format="0000" /></h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <g:hasErrors bean="${taskOrderInstance}">
	            <div class="errors">
	                <g:renderErrors bean="${taskOrderInstance}" as="list" />
	            </div>
            </g:hasErrors>
            <g:form method="post" enctype="multipart/form-data">
                <g:hiddenField name="id" value="${taskOrderInstance?.id}" />
                <g:hiddenField name="version" value="${taskOrderInstance?.version}" />
	            <div class="dialog">
	            	<table>
	                    <tbody>
	                    	<tr class="prop">
                                <td valign="top" class="name">
                                  <label for="testResultsFile"><g:message code="taskOrder.testResults.label" default="Test Results (PDF or Word Doc)" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: taskOrderInstance, field: 'testResults', 'errors')}">
                                    <input type="file" id="testResultsFile" name="testResultsFile" size="80"/>
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name" colspan="2">
                                  	<h3>Installed Components</h3>
                                  	<br />
                                  	<table id="installedComponents">
                                  		<thead>
                                  			<tr>
                                  				<th>Component</th>
                                  				<th>Amount</th>
                                  			</tr>
                                  		</thead>
                                  		<tbody>
                                  			<g:each in="${taskOrderInstance.installedComponents ?: (0..< 1)}" var="installedComponent" status="cCount">
											    <tr class="${(cCount % 2) == 0 ? 'even' : 'odd'}">
													<td>
														<g:select name="componentIds.${cCount}" from="${Component.list().sort{ it.name }}" optionKey="id" optionValue="${{StringUtils.rightPad(it.name, 20, ' - ') + ' ' + it.description}}" value="${taskOrderInstance.installedComponents ? installedComponent?.component?.id : null}"  noSelection="['':'-Select Component-']"/>
													</td>
													<td><g:textField name="quantities.${cCount}" size="5" value="${taskOrderInstance.installedComponents ? installedComponent?.quantity : ''}" /></td>								                            	
											     </tr>
											</g:each>
                                  		</tbody>
                                  	</table>
                                  	<div style="margin:10px 0">
                                  		<a href="#" id="addLineItem">Add Line Item</a>
                                  	</div>
                                </td>
                            </tr>
	                    
	                        <tr class="prop">
                                <td valign="top" class="name" colspan="2">
                                    <h3>Additional Notes/Comments</h3>
                                    <br />
                                    <g:textArea name="comment" style="width:550px; height:75px;"/>  
                                </td>
                            </tr>                     
	                    </tbody>
	                </table>
	                
	                <div class="buttons">
	                	<span class="button"><g:actionSubmit class="edit" action="saveCompletedInfo" value="${message(code: 'default.button.saveCompletedInfo.label', default: 'Save')}" /></span>						
						<span class="button"><g:actionSubmit class="edit" action="markAsCompleted" value="${message(code: 'default.button.markAsCompleted.label', default: 'Complete')}" /></span>
		            </div>
	                
	            </div>
			</g:form>
        </div>
    </body>
</html>
