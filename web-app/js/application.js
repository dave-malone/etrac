$(document).ready(function(){	
	$("#taskOrderSearch select").change(function(){
		$(this).parent().submit()
	})
	
	$('#resetTaskOrderSearch').click(function(){
		window.location = '/va/taskOrder/list'
		return false
	})
	
	
	$("#addLineItem").click(function(){	
		var installedComponentsTable = document.getElementById('installedComponents')
		var tbody = installedComponentsTable.tBodies[0]
		var rows = tbody.rows
		
		jQuery.ajax({
			async: false,
			type:'GET',		           			
			url:'/va/taskOrder/addLineItem?number=' + rows.length,
			success:function(data, textStatus){
				if(data){
					$(tbody).append(data)			
				}else{
					alert("There was a problem servicing your request.  Please try again later.  If the problem persists, please contact us");
				}
			},
			error:function(XMLHttpRequest,textStatus,errorThrown){
				alert("There was a problem servicing your request.  Please try again later.  If the problem persists, please contact us");
			}
		});
		
		return false;
	});
});

function forumMessageCallback(data){
	if(data.success){
		$('#forum-message-form input[name="message"]').val('')
		$(data.html).hide().prependTo('#forum-messages').fadeIn('slow')
	}else{
		alert("Failed to submit your Message.  This is probably a bug on our end.  Apologies - we'll get right on to fixing it")
	}
}

function messageCommentCallback(data){
	if(data.success){
		$('#forum-message-comment-form-' + data.messageId + ' input[name="comment"]').val('')
		$(data.html).hide().appendTo('#post-comments-' + data.messageId).fadeIn('slow')		   			
	}else{
		alert("Failed to submit your Comment.  This is probably a bug on our end.  Apologies - we'll get right on to fixing it")
	}
}

function messageCommentFailure(xhr,textStatus,errorThrown){
	alert("Failed to submit your Comment.  This is probably a bug on our end.  Apologies - we'll get right on to fixing it; \n" + textStatus + "\n" + errorThrown)
}

var Ajax;
if (Ajax && (Ajax != null)) {
	Ajax.Responders.register({
	  onCreate: function() {
        if($('spinner') && Ajax.activeRequestCount>0)
          Effect.Appear('spinner',{duration:0.5,queue:'end'});
	  },
	  onComplete: function() {
        if($('spinner') && Ajax.activeRequestCount==0)
          Effect.Fade('spinner',{duration:0.5,queue:'end'});
	  }
	});
}
