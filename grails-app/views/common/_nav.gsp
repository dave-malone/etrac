<div class="nav">	
	<span class="menuButton"><g:link controller="taskOrder" action="list">Dashboard</g:link></span>
	<sec:ifAnyGranted roles="ROLE_FTA_ADMIN, ROLE_VA_TASK_CREATOR">
		<span class="menuButton"><g:link class="create" action="create" controller="taskOrder"><g:message code="default.new.label" args="['Task Order']" /></g:link></span>
	</sec:ifAnyGranted>
	
	<sec:ifAnyGranted roles="ROLE_FTA_ADMIN">		
		<g:if test="${request.entityName && request.entityName != 'Task Order'}">
			<span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[request.entityName]" /></g:link></span>
			<span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[request.entityName]" /></g:link></span>			
		</g:if>		
	</sec:ifAnyGranted>
	
	<sec:ifLoggedIn>
		<span class="menuButton" style="margin-left:40px;">
			Logged in as <sec:loggedInUserInfo field="fullName" />	(<sec:loggedInUserInfo field="username" />)
			<g:link controller="user" action="myAccount">Account Settings</g:link>
			<g:link controller="logout">Log out</g:link>			
		</span>	        
	</sec:ifLoggedIn>
	<sec:ifAnyGranted roles="ROLE_FTA_ADMIN">
		<span class="menuButton"><g:link uri="/admin.gsp">Admin</g:link></span>
	</sec:ifAnyGranted>
</div>