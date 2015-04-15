<%@ include file="headerIncludes.jsp"%>
<script type="text/javascript"
	src="./resources/script/datetimepicker.js"></script>
<script type="text/javascript"
	src="./resources/script/jquery-ui-timepicker-addon.js"></script>

<script type="text/javascript">
	function pop() {
		var screen = document.createElement('div');
		screen.id = 'screen';
		screen.className = 'screen';
		document.body.appendChild(screen);
		$("#screen").css({
			'width' : $(document).width(),
			'height' : $(document).height()
		});
		$('body').append($('#configDiv'));
	}
	
	/* var myRegExp =/^(?:(?:https?|ftp):\/\/)(?:\S+(?::\S*)?@)?(?:(?!10(?:\.\d{1,3}){3})(?!127(?:\.\d{1,3}){3})(?!169\.254(?:\.\d{1,3}){2})(?!192\.168(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/[^\s]*)?$/i;
	
	 */
	 function changeDate() {
			document.getElementById("Date_e_div0").setAttribute("hidden", "true");
			status_message.setAttribute("hidden", "true");
		}
	 function listHomePage(){
		 //alert("In list home page :");
		 document.getElementById("httptoFtpForm").action="<c:url value='/list' />";
		document.getElementById("httptoFtpForm").submit();
		
		
	}
		function CheckboxSchedule() {

		var str = '';
		var list = $('#div1 input:checkbox:checked');
		list.foreach(function() {
			str += $(this).attr('value') + ",";
		});
		$('#scheduleOn').val(str);

	}

	$(function() {

		$('#scheduleTime').timepicker();
	});
	
</script>

<script type="text/javascript">
function submitForm() {
	
	var ftpUrlpwd = $("#ftpUrlpwd").val();
	if (ftpUrlpwd != "") {
		 var encryptedftpUrlpwd = $.base64.encode(ftpUrlpwd);
		document.getElementById("ftpUrlpwd").value = encryptedftpUrlpwd;
	}
	var httpUrlpwd = $("#httpUrlpwd").val();
	if (httpUrlpwd != "") {
		 var encryptedhttpUrlpwd = $.base64.encode(httpUrlpwd);
		document.getElementById("httpUrlpwd").value = encryptedhttpUrlpwd;
	}
	document.getElementById("httptoFtpForm").submit();
}
</script>
<script  type="text/javascript">
$(window).load(function() {
	document.getElementById("ftpUrlpwd").value =  $("#FtpUrlpwd").val();
	document.getElementById("httpUrlpwd").value =  $("#HttpUrlpwd").val();
	
});

function submitFormOnEnter(inputElement, event) {
	//alert("hai");
	var operationVal = '${operation}';

	if(operationVal=="add"){
		if(event.keyCode == 13) {
			submitForm();
		}

	}else{
		if(event.keyCode == 13) {
			submitForm();
		}
	}

}

</script> 
<h2>
	<spring:message code="label.heading.updateParams" />
</h2>

<div class="formsections"  onkeyup="submitFormOnEnter(this, event);">

<form:form id="httptoFtpForm" action="successupdate" modelAttribute="httptoFtpForm"
	commandName="httptoFtpForm" method="post">
	<div class="row">
<input type="hidden" id="FtpUrlpwd" value="${httptoFtpForm.ftpUrlpwd}"/>
<input type="hidden" id="HttpUrlpwd" value="${httptoFtpForm.httpUrlpwd}"/>
<form:hidden path="lstSuccessJobDone" id="lstSuccessJobDone" value="${httptoFtpForm.lstSuccessJobDone}"/>
		<c:if test="${successMessage != null}">
			<div class="col-md-10">
				<div class="alert alert-success" id="status_message">
					<strong>${successMessage}</strong> <a href="viewResults"
						class="reportmgmt " title="Click to View Results">View Results</a>
				</div>
			</div>
		</c:if>
		<c:if test="${failMessage != null}">
			<div class="col-md-7">
				<div class="alert alert-danger" id="status_message">
					<strong>${failMessage}</strong>
				</div>
			</div>
		</c:if>
		<c:if test="${!empty errorMessage}">
			<div class="alert alert-danger">
				<spring:message code="${errorMessage}" />
			</div>
		</c:if>
		<%-- <spring:bind path="httptoFtpForm.*">
			<c:if test="${status.errors.errorCount > 0}">
				<ul>
					<li>
						<div class="alert alert-danger">
							<c:forEach var="error" items="${status.errors.allErrors}">
								<spring:message message="${error}"></spring:message>
								<br />
							</c:forEach>
						</div>
					</li>
				</ul>
			</c:if>
		</spring:bind>  --%>
		<div class="screen" id="screen" style="display: none;"></div>

		<div id="spinner" class="spinner" style="display: none;">
			<img id="img-spinner" src="./resources/images/loading.gif"
				alt="Loading" style="width: 50px; height: 50px;" /> <strong>Executing...</strong>
		</div>


		<table cellpadding="0" cellspacing="0"
			class="table table-bordered table-striped">
			<tr>
				<td align="left"><label class="col-sm-10"><strong><spring:message
								code="label.jobName.name" />&nbsp; <font style="color: red"><spring:message
									code="label.symbol.asterik" /> </font> </strong> </label></td>
				<td><form:input path="jobName" id="jobName"
						class="form-control" size="33" maxlength="500" autocomplete="off"
						onkeyup="keyEventFun(event);" />
						<span><font style="color: red"><form:errors path="jobName"/></font></span>
				</td>
				
				<td align="left"><label class="col-sm-10"><strong><spring:message
								code="label.email.id" />&nbsp; <font style="color: red"><spring:message
									code="label.symbol.asterik" /> </font> </strong> </label></td>
				<td><form:input path="emailID" id="emailID"
						class="form-control" size="33" maxlength="500" autocomplete="off"
						onkeyup="keyEventFun(event);" />
						<span><font style="color: red"><form:errors path="emailID"/></font></span>
				</td>
				
				
				
			</tr>

			<tr>
				<td align="left"><label class="col-sm-10"><strong><spring:message
								code="label.httpUrl.name" />&nbsp; <font style="color: red"><spring:message
									code="label.symbol.asterik" /> </font> </strong> </label></td>
				<td><form:input path="httpUrl" id="httpUrl"
						class="form-control" size="33" maxlength="500" autocomplete="off"
						onkeyup="keyEventFun(event);" />
						<span><font style="color: red"><form:errors path="httpUrl"/></font></span>
						</td>
			</tr>
			<tr>

				<td align="left"><label class="col-sm-10"><strong><spring:message
								code="label.httpUrlUsername.name" />&nbsp; <font
							style="color: red"><spring:message
									code="label.symbol.asterik" /> </font> </strong> </label></td>
				<td><form:input path="httpUrlUsername" id="username"
						class="inptxt httpUrlUsername-input form-control" size="33"
						maxlength="255" autocomplete="off" onkeyup="keyEventFun(event);" />
						<span><font style="color: red"><form:errors path="httpUrlUsername"/></font></span>
						</td>


				<td align="left"><label class="col-sm-10"><strong><spring:message
								code="label.httpUrlpwd.name" />&nbsp; <font style="color: red"><spring:message
									code="label.symbol.asterik" /> </font> </strong> </label>
									</td>

				<td><form:password path="httpUrlpwd" id="httpUrlpwd"
						class="form-control" value="" size="33" maxlength="20"
						autocomplete="off" onkeyup="keyEventFun(event);" />
						<span><font style="color: red"><form:errors path="httpUrlpwd"/></font></span>
						</td>



				<%-- <td><a
					href="javascript:popupDialog('<c:url value="testHttp" />', 'configDiv')"
					class="default-btn pull-right" id="executebtnlink"
					title="Click to execute selected Brands"><spring:message
							code="label.button.testHttp" /></a></td> --%>


			</tr>


			<tr>
				<td align="left"><label class="col-sm-10"><strong><spring:message
								code="label.ftpUrl.name" />&nbsp; <font style="color: red"><spring:message
									code="label.symbol.asterik" /> </font> </strong> </label></td>
				<td><form:input path="ftpUrl" id="httpUrl"
						class="inptxt ftpUrl-input form-control" size="33" maxlength="500"
						autocomplete="off" onkeyup="keyEventFun(event);" />
						<span><font style="color: red"><form:errors path="ftpUrl"/></font></span>
						</td>
			</tr>
			<tr>

				<td align="left"><label class="col-sm-10"><strong><spring:message
								code="label.ftpUrlUsername.name" />&nbsp; <font
							style="color: red"><spring:message
									code="label.symbol.asterik" /> </font> </strong> </label></td>

				<td><form:input path="ftpUrlUsername" id="ftpUrlUsername"
						class="inptxt username-input form-control" size="33"
						maxlength="255" autocomplete="off" onkeyup="keyEventFun(event);" />
						<span><font style="color: red"><form:errors path="ftpUrlUsername"/></font></span>
						</td>


				<td align="left"><label class="col-sm-10"><strong><spring:message
								code="label.ftpUrlpwd.name" />&nbsp; <font style="color: red"><spring:message
									code="label.symbol.asterik" /> </font> </strong> </label></td>

				<td><form:password path="ftpUrlpwd" id="ftpUrlpwd"
						class="form-control" value="" size="33" maxlength="20"
						autocomplete="off" onkeyup="keyEventFun(event);" />
						<span><font style="color: red"><form:errors path="ftpUrlpwd"/></font></span>
						</td>

			<%-- 	<td><a
					href="javascript:popupDialog('<c:url value="/testFtp" />', 'configDiv')"
					class="default-btn pull-right" id="executebtnlink"
					title="Click to execute selected Brands"><spring:message
							code="label.button.testFtp" /></a></td> --%>
			</tr>

			<tr>
				<td align="left"><label class="col-sm-10"><strong><spring:message
								code="label.scheduleOn.name" />&nbsp;  </strong> </label></td>

				<td align="left">
					<div id="divSchedule">
					<c:if test="${MondayVal  eq 'checked'}" >
						<input type="checkbox" name="scheduleOn" value="Monday" checked="${MondayVal }"
							onclick="onChangeCheckbox (this)" />Mon  
							</c:if>
							
							
							<c:if test="${MondayVal  ne 'checked' }">
						<input type="checkbox" name="scheduleOn" value="Monday" 
							onclick="onChangeCheckbox (this)" />Mon 
							</c:if>
							
							<c:if test="${TuesdayVal eq 'checked' }" >
							 <input
							type="checkbox" name="scheduleOn" value=" Tuesday" checked="${ TuesdayVal}"
							onclick="onChangeCheckbox (this)" />Tue 
							</c:if>
							
							<c:if test="${TuesdayVal ne 'checked' }" >
							 <input
							type="checkbox" name="scheduleOn" value=" Tuesday" 
							onclick="onChangeCheckbox (this)" />Tue 
							</c:if>
							
							
							
							
							
							
							<c:if test="${WednesdayVal eq 'checked'}" >
							<input
							type="checkbox" name="scheduleOn" value=" Wednesday" checked="${WednesdayVal }"
							onclick="onChangeCheckbox (this)" />Wed
							</c:if>
							<c:if test="${WednesdayVal ne 'checked' }" >
							<input
							type="checkbox" name="scheduleOn" value=" Wednesday" 
							onclick="onChangeCheckbox (this)" />Wed
							</c:if>
							
							
							
							
							
							<c:if test="${ThursdayVal eq 'checked'}" >
							 <input 
							type="checkbox" name="scheduleOn" value=" Thursday" checked="${ThursdayVal }"
							onclick="onChangeCheckbox (this)" />Thu 
							</c:if>
							
							
							<c:if test="${ThursdayVal  ne 'checked' }">
							 <input 
							type="checkbox" name="scheduleOn" value=" Thursday" 
							onclick="onChangeCheckbox (this)" />Thu 
							</c:if>
							
							
							<c:if test="${FridayVal eq 'checked' }" >
							
							<input
							type="checkbox" name="scheduleOn" value=" Friday" checked="${FridayVal }"
							onclick="onChangeCheckbox (this)" />Fri 
							
							</c:if>
							
							<c:if test="${FridayVal ne 'checked'}" >
							
							<input
							type="checkbox" name="scheduleOn" value=" Friday" 
							onclick="onChangeCheckbox (this)" />Fri 
							
							</c:if>
							
							
							<c:if test="${SaturdayVal  eq 'checked'}" >
							<input
							type="checkbox" name="scheduleOn" value=" Saturday" checked="${SaturdayVal }"
							onclick="onChangeCheckbox (this)" />Sat 
							</c:if>
							<c:if test="${SaturdayVal ne 'checked'}" >
							<input
							type="checkbox" name="scheduleOn" value=" Saturday" 
							onclick="onChangeCheckbox (this)" />Sat 
							</c:if>
							&nbsp&nbsp&nbsp&nbsp&nbsp
							<c:if test="${SundayVal eq 'checked' }" >
							<input
							type="checkbox" name="scheduleOn" value=" Sunday" checked="${SundayVal }"
							onclick="onChangeCheckbox (this)" />Sun
							</c:if>
							<c:if test="${SundayVal  ne 'checked'}">
							<input
							type="checkbox" name="scheduleOn" value=" Sunday" 
							onclick="onChangeCheckbox (this)" />Sun
							</c:if>
							</div>
				</td>
				

				<td align="left"><label class="col-sm-10"><strong><spring:message
								code="label.scheduleTime.name" />&nbsp; <font
							style="color: red"><spring:message
									code="label.symbol.asterik" /> </font> </strong> </label></td>
				<td><form:input id="scheduleTime" path="scheduleTime"
						class="form-control" value="" size="33" maxlength="20"
						autocomplete="off" onkeyup="keyEventFun(event);" />
						<span><font style="color: red"><form:errors path="scheduleTime"/></font></span>
						</td>
						
						

			</tr>
			<tr>
            <form:input type="hidden" name="id" path="id" id="id"/>
            </tr>
           <tr>
            <form:input type="hidden" name="flag" path="flag" id="flag"/>
           </tr>


		</table>


		<div class="Fieldsrow">
			<div class="col-sm-4">&nbsp;</div>
			<div class="col-sm-8 btns pad0">
				<a href="#"  onclick="javascript:submitForm();" 
					
					class="default-btn pull-left" id="executebtnlink"
					title="Click to execute selected Brands"><spring:message
						code="label.button.submit" /></a>
						&nbsp
						 <input class="default-btn pull-right"  type="button" value="Cancel" id="Cancel" onclick="javascript:listHomePage()"/>
			</div>
		</div>


		<div class="col-sm-12 pull-right Note">
			<strong><spring:message code="label.note.text" /></strong>
			<spring:message code="label.note.value1" />
			<font style="color: red"><spring:message
					code="label.symbol.asterik" /></font>
			<spring:message code="label.note.value2" />
		</div>


	</div>
	

</form:form>
</div>


<div class="back-popup-layer" id="bioDataLayer"></div>

<div class="popup-div adduser" id="bioData" style="display: none"></div>


