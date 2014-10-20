<li class="post-response">
	<ul class="post-meta">
		<li>
			<img src="${resource(dir: 'images', file: 'post-time.png')}" width="19" height="18" alt="Comment Time">
			<g:formatDate  date="${responseMessage.dateCreated}" format="MMM dd 'at' hh:mm a"/>
		</li>
		<li>
			<img src="${resource(dir: 'images', file: 'post-author.png')}" width="19" height="18" alt="Comment Author">
			<g:link controller="user" action="show" id="${responseMessage.createdBy.id}">${responseMessage.createdBy.fullName}</g:link>
		</li>
	</ul>
	<div class="post-comment-msg">${responseMessage.content}</div>											
</li>