<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>eTrac - <g:layoutTitle /></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
		<r:require modules="core"/>
		<r:layoutResources />
		<g:layoutHead/>		
	</head>
	<body>
		<div id="grailsLogo" role="banner">
			<g:link uri="/"><img src="${resource(dir:'images',file:'logo.jpg')}" alt="eTrac Advantage - Task Order Management System" /></g:link>			
			<div id="title">
				eTrac Advantage<br />
				Task Order Management System
			</div>					
		</div>
		
		<div style="clear:both;"></div>
		
		<div class="nav" role="navigation">
			<ul style="float:left;">
				<li><g:link controller="taskOrder" action="list">Dashboard</g:link></li>
				<li><g:link controller="forum">Forum</g:link></li>				
				<sec:ifAnyGranted roles="ROLE_FTA_ADMIN, ROLE_VA_TASK_CREATOR">
					<g:if test="${request.entityName == null}">
						<li><g:link class="create" action="create" controller="taskOrder"><g:message code="default.new.label" args="['Task Order']" /></g:link></li>
					</g:if>
				</sec:ifAnyGranted>
				<sec:ifAnyGranted roles="ROLE_FTA_ADMIN">		
					<g:if test="${request.entityName != null && request.entityName != 'Task Order'}">
						<li><g:link class="list" action="list"><g:message code="default.list.label" args="[request.entityName]" /></g:link></li>
						<li><g:link class="create" action="create"><g:message code="default.new.label" args="[request.entityName]" /></g:link></li>			
					</g:if>		
				</sec:ifAnyGranted>				
			</ul>
			<sec:ifLoggedIn>
				<ul style="float:right">
					<li><g:link controller="user" action="myAccount">${session.currentUser.fullName}</g:link></li>
					<li><g:link controller="logout">Log out</g:link></li>				
					<sec:ifAnyGranted roles="ROLE_FTA_ADMIN">
						<li><g:link uri="/admin">Admin</g:link></li>
					</sec:ifAnyGranted>
				</ul>
			</sec:ifLoggedIn>
			<div style="clear:both;"></div>
		</div>
		
		<g:layoutBody/>
		
		<div class="footer" role="contentinfo">
			<img style="float:left" src="${resource(dir:'images',file:'sdvosb.jpg', absolute:true)}" alt="SDVOSB Seal" />
			<img style="float:right" src="${resource(dir:'images',file:'sdvosb.jpg', absolute:true)}" alt="SDVOSB Seal" />
		</div>
		<div style="clear:both"></div>
		<r:layoutResources />
	</body>
</html>
