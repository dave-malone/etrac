<%@ page contentType="text/html"%>
<html>
<body>
	<p>
		This is a message from the eTrack Advantage Task Order Management System
	</p> 
	<p>
		Task Order <g:formatNumber number="${taskOrderNumber}" format="0000" /><br />		
		${commentCreatedBy} posted comment on <g:formatDate date="${commentDate}" format="MM-dd-yyyy 'at' h:mma"/>
		
		<br /><br />
		
		<strong>${commentText}</strong>
		
		<br /><br />
		
		Please log into eTrac to see any previous comments or the details of the task order.
	</p>
	<p>
		<a href="https://etrac.fedtechadvantage.com/va/taskOrder/show/${taskOrderNumber}">View Task Order <g:formatNumber number="${taskOrderNumber}" format="0000" /></a> <br />
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