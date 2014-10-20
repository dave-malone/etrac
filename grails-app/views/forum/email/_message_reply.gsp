<%@ page contentType="text/html"%>
<html>
<body>
	<p>
		This is a message from the eTrack Advantage Task Order Management System
	</p> 
	<p>
		${messageCreatedBy} posted the following message on <g:formatDate date="${messageDateCreated}" format="MM-dd-yyyy 'at' h:mma"/>
		<br /><br />
		<strong>${messageContent}</strong>
		
		<br /><br />
		${replyMessageCreatedBy} replied on <g:formatDate date="${replyMessageDateCreated}" format="MM-dd-yyyy 'at' h:mma"/>
		<br /><br />
		<strong>${replyMessageContent}</strong>
	</p>
	<p>
		<a href="https://etrac.fedtechadvantage.com/va/forum/show/${messageId}">Login to eTrac</a> <br />
		Thank you for using eTrac Advantage! <br />
		eTrack Advantage Task Order Management System is property of FedTech, LLC.
	</p>
	<p>
		Land of the Free...Because of the Brave! <br />		
		<img src="${resource(dir:'images',file:'sdvosb.jpg', absolute:true)}" alt="SDVOSB Seal" />
	</p> 
	<p>
		FedTech LLC. (SDVOSB) <br />		
		Service Disabled Veteran Owned Small Businesses <br />		
		6989 North 55th Street, Suite D <br />
		Oakdale, MN 55128
	</p> 
	<p>
		<a href="www.fedtechadvantage.com">www.fedtechadvantage.com</a> <br />
		Office - 651-294-3939 <br />
		Toll Free - 866-96-FedTech <br />
		Fax - 651-779-1029
	</p>
</body>
</html>