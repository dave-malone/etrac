<li class="forum-message">
	<ul class="post-meta">
		<li>
			<img src="${resource(dir: 'images', file: 'post-time.png')}" width="19" height="18" alt="Post Time">
			<g:formatDate  date="${message?.dateCreated}" format="MMM dd 'at' hh:mm a"/>
		</li>
		<li>
			<img src="${resource(dir: 'images', file: 'post-author.png')}" width="19" height="18" alt="Post Author">
			<g:link controller="user" action="show" id="${message?.createdBy?.id}">${message?.createdBy?.fullName}</g:link>
		</li>
	</ul>
	
	<div class="post-content">${message?.content}</div>
	
	<div class="post-feedback" id="post-feedback-${message.id}">
		<sec:ifLoggedIn>
			<ul class="post-comments ${message.responses?.isEmpty() ? 'hidden' : ''}" id="post-comments-${message.id}">
				<g:each in="${message.responses?.sort{ it.dateCreated }}" var="responseMessage">
					<g:render model="${[responseMessage:responseMessage]}" template="/forum/message_reply" />	
				</g:each>
			</ul>
			<g:formRemote class="forum-message-comment-form" name="forum-message-comment-form-${message.id}" url="${[controller: 'forum', action:'reply', id:message.id]}" onSuccess="messageCommentCallback(data)" onFailure="messageCommentFailure(XMLHttpRequest,textStatus,errorThrown)">
				<input type="text" name="comment" placeholder="Reply..."/>
			</g:formRemote>
		</sec:ifLoggedIn>
	</div>
</li>