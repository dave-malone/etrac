$(document).ready(function(){	
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
