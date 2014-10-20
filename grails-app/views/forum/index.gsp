<html>
    <head>
        <meta name="layout" content="main" />
        <title>eTrac Forum</title>
    </head>
    <body>
        <h1>eTrac Forum - Ask Questions, Get Answers</h1>
           
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		
		<g:formRemote name="forum-message-form" url="${[controller: 'forum', action:'message']}" onSuccess="forumMessageCallback(data)">
			<input type="text" id="post-new-message" name="message" placeholder="Post a Message or Ask a Question - Hit Enter to Submit"/>
		</g:formRemote>
		
		<ul id="forum-messages">
			<g:each in="${messages}" var="message">
				<g:render model="${[message:message]}" template="/forum/message" />				
			</g:each>
		</ul>
		
		<g:set var="pagination"><g:paginate total="${totalMessages}"/></g:set>
		<g:if test="${pagination}">
			<div class="pagination">${pagination}</div>
		</g:if>
    </body>
</html>
