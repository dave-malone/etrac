<html>
    <head>
        <meta name="layout" content="main" />
        <title>eTrac Forum</title>
    </head>
    <body>
        <h1>eTrac Forum - Message #${params.id}</h1>
           
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		
		<ul id="forum-messages">
			<g:render model="${[message:message]}" template="/forum/message" />			
		</ul>
    </body>
</html>
