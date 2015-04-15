<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% response.addHeader("Refresh","10"); %>
<script type="text/javascript">
function gotoDetails(id){
	
}

function sendRequest(url, divId) {

	var doIt = true;
	if((url.indexOf("deleteJobDetail") != -1)){
		doIt=confirm('Do you want to delete the record?');
		
	}
	if(doIt){
		$.ajax({
			type : "GET",
			url : url,
			success : function(response) {
				submit();
			}
		});
	}
	
}
function submit(){
	document.getElementById("httptoFtpForm").submit();
}
</script>
<form method="get" action="list" id="httptoFtpForm">
<input type="hidden"/>
</form>
<!-- <div id="toggleDiv" ></div> -->
<table border="0"  cellpadding="0" cellspacing="1" class="table table-bordered table-striped">
	<tr>
		<th width="19%"><spring:message code="label.jobName" /></th>
		<th width="24%"><spring:message code="label.scheduleOn" /></th>
		<th width="15%"><spring:message code="label.scheduleTime" />		
		<th width="15%"><spring:message code="label.status" /></th>
		<th width="15%"><spring:message code="label.LastSuccessJobDoneOn" /></th>
        <th class="info-icon" width="6%"><spring:message code="label.edit" /></th>
        <th class="info-icon" width="6%"><spring:message code="label.delete" /></th>
	</tr>
	<c:if test="${empty jobsList}">
		<tr class="">
			<td class="empty-data"  align="center" colspan="9"><span class="r-mark"><font color="red"><spring:message code="Data.does.not.exist" /></font></span></td>
		</tr>
	</c:if>
	<c:forEach items="${jobsList}" var="job" varStatus="index">
		<tr class="${rowClass}">
			<td align="center" width="15%">${job.jobName}</td>
			<td align="center" width="20%">${job.scheduleOn}</td>
			<td align="center" width="15%">${job.scheduleTime}</td>
			<td align="center" width="15%">${job.status}</td>
			<td align="center" width="15%"><fmt:formatDate value="${job.lstSuccessJobDone}" type="both" pattern="dd-MMM-yyyy HH:mm:ss" /></td>



			<td align="center" width="10%" class="info-icon"><a
				class="ui-icon1 edit" title="<spring:message code="label.edit"/>"
				href="updateJobDetail?jobId=${job.id}&flag=edit"></a></td>
				
				 <%-- <td align="center" width="10%" class="info-icon"><a
				class="ui-icon1 delete" title="<spring:message code="label.delete"/>"
				href="deleteJobDetail?jobId=${job.id}"></a></td> --%> 
				
				<td align="center" width="10%" class="info-icon"><a
				class="ui-icon1 delete" title="<spring:message code="label.delete"/>"
				href="javascript:sendRequest('<c:url value='deleteJobDetail' />?jobId=${job.id}', 'page')"></a></td>
				
				<%-- <td align="center" width="10%" class="info-icon">
				<a href="javascript:sendRequest('<c:url value='/deleteJobDetail' />?jobId=${job.id}', 'toggleDiv')" class="ui-icon1 delete"><spring:message code="label.delete"/></a>
				</td> --%>
		</tr>
	</c:forEach>
</table>