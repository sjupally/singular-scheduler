<%@ taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>

<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<link href="<c:url value='/resources/script/jquery-ui.css' />"
	type="text/css" rel="stylesheet" />
<script type="text/javascript"
	src="<c:url value='/resources/script/jquery.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/resources/script/jquery-ui.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/resources/script/jquery.pagination.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/resources/script/pagination.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/resources/script/md5.js' />"></script>
<link href="<c:url value='/resources/script/bootstrap.css' />"
	type="text/css" rel="stylesheet" />
<link href="<c:url value='/resources/script/style.css' />"
	type="text/css" rel="stylesheet" />
</head>
<div class="LoginScreen">
	<h2 class="LoginHeading">
		<%-- <spring:message code="application.header" /> --%>
	</h2>
	<div class="box-padded">
		<h3 class="heading">
			<spring:message code="signIn.heading" />
		</h3>
		<form:form method="post" modelAttribute="loginForm"
			commandName="loginForm" action="signIn">
			<div class="LoginBlk">
				<div class="ErrorMsgsblk">
					<c:if test="${!empty message}">
						<div class="alert alert-success">
							<spring:message code="logout.success" />
						</div>
					</c:if>
					<c:if test="${!empty errorMessage}">
						<div class="alert alert-danger">


							<spring:message code="${errorMessage}" />
						</div>
					</c:if>
					<spring:bind path="loginForm.*">
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
					</spring:bind>
				</div>
				<div class="row-fluid martb10 wid100">
					<label class="username-label  col-md-4" for="userInput"> <spring:message
							code="login.username" text="User Name" />
					</label>

					<div class="inputarea col-md-8">
						<form:input path="username" id="username"
							class="inptxt username-input form-control" size="33"
							maxlength="20" autocomplete="off" onkeyup="keyEventFun(event);" />
					</div>
				</div>

				<div class="row-fluid martb10 wid100">
					<label class="password-label col-md-4" for="passwordInput"
						id="password"> <spring:message code="login.password"
							text="Password" />
					</label>

					<div class="inputarea col-md-8">
						<form:password path="password" id="passwordInput"
							class="inptxt password-input form-control" value="" size="33"
							maxlength="50" autocomplete="off" onkeyup="keyEventFun(event);" />
					</div>
				</div>
				<div class="row-fluid">
					<label class="col-md-4"></label>
					<div class="col-md-8 btns fll marb10">
						<a title="Click to execute selected Brands" id="executebtnlink"
							onclick="submittingForm();" class="default-btn marb10" href="#"><spring:message
								code="login.submit" /></a>

					</div>
				</div>
			</div>

			<script type="text/javascript">
				formFocus();
				function formFocus() {
					document.getElementById('username').focus();
				}
			</script>


		</form:form>
		<script type="text/javascript">
			function submittingForm() {
				var password = $("#passwordInput").val();
				if (password != "") {
					var strMD5 = $().crypt({
						method : "md5",
						source : $("#passwordInput").val()
					});
					document.getElementById("passwordInput").value = strMD5;
				}
				document.getElementById("loginForm").submit();
			}
		</script>
		<script type="text/javascript">
			function keyEventFun(event) {
				if (event.keyCode == 13) {
					submittingForm();
				}
			}
		</script>
	</div>
</div>


