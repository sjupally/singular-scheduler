<%@ include file="headerIncludes.jsp"%>
<script type="text/javascript"
	src="./resources/script/datetimepicker.js"></script>
<script type="text/javascript">
	// To highlight the selcted menu
	$(document).ready(function() {
		$('ul li').find('.reportmgmt').addClass('reportmgmt active');
		getResultCount();

	});
</script>
<script type="text/javascript">
	var counturl = "<c:url value='/countResults' />";
	var resulturl = "<c:url value='/listResults' />";


	function getSearchData() {
		var startDate = document.getElementById("startDate").value;
		var endDate = document.getElementById("endDate").value;
		var datepattern = /^\d{2}\/\d{2}\/\d{4}$/;
		var inputs, index;
		var form = document.getElementById("viewResultsForm");
		inputs = form.getElementsByTagName('input');
		// checking the fields for null,empty,date fromat
		var isDataError=false
		for (index = 0; index < inputs.length; ++index) {
			// deal with inputs[index] element.
			if (inputs[index].value == null || inputs[index].value == ""
					|| !datepattern.test(inputs[index].value)) {
				document.getElementById("Date_e_div" + index).removeAttribute(
						"hidden");
				document.getElementById("DateErr" + index).innerHTML = "Please select Date by clicking Calender";
				isDataError=true;

			} else {
				document.getElementById("Date_e_div" + index).setAttribute(
						"hidden", "true");

			}
		}
		if(isDataError)
		return false;

		if (datepattern.test(endDate) && (startDate.trim() > endDate.trim())) {

			validate_e_div.removeAttribute("hidden");
			validDateErr.innerHTML = "From Date should not be greater then To Date";
			return false;
		} else {
			validDateErr.innerHTML = "";
			validate_e_div.setAttribute("hidden", "true");
		}
		
    if (!populateReportData()) {
				return;
	}
		getResultCount();
	}

	function changestartDate() {
		document.getElementById("Date_e_div0").setAttribute("hidden", "true");
		validate_e_div.setAttribute("hidden", "true");
	}

	function changeendDate() {
		document.getElementById("Date_e_div1").setAttribute("hidden", "true");
		validate_e_div.setAttribute("hidden", "true");
	}
</script>


<form:form commandName="viewResultsForm" method="post"
	name="viewResultsForm" id="viewResultsForm">
	<div class="col-md-9 Content">
		<h2><spring:message
              code="label.heading.searchcriteria" /></h2>
		<div class="row">
			<div class="col-md-9">
				<div class="Fieldsrow">
					<label class="col-sm-3"><spring:message
              code="label.network" />&nbsp;<font style="color: red"><spring:message
								code="label.symbol.asterik" /></font> </label>
					<div class="col-sm-8 FieldsHeight">
						<form:select path="networkId" id="networkId"
							items="${allNetworks}" var="brandListObj"
							class="form-control Wid90" title="Select Network from list">
							<form:options itemValue="networkId" itemLabel="networkName" />
						</form:select>
						<span class="errormsgs"></span>
					</div>
				</div>



				<div class="Fieldsrow FieldsError" style="float: left;">
					<label class="col-sm-3"><spring:message
              code="label.fromdate" />&nbsp;<font style="color: red"><spring:message
								code="label.symbol.asterik" /></font></label>
					<div class="col-sm-8 FieldsHeight">
						<form:input path="startDate" id="startDate" name="startDate"
							value="${viewResultsForm.startDate}"
							class="form-control  DateField Wid90" 
							onchange="changestartDate()" readonly="true"/>
						<img src="./resources/images/calendar.jpg" width="20" height="35"
							onclick="javascript:NewCssCal('startDate','','','','','','past')"
							style="cursor: pointer" class="calendar-icon" title="Click to select FromDate"/>
						<div hidden="true" class="col-md-12" id="Date_e_div0"
							style="width: 280px; float: left;">
							<div class="alert alert-danger" id="status_message">
								<span class="errormsgs" id="DateErr0"></span>
							</div>
						</div>
					</div>
				</div>




				<div class="Fieldsrow FieldsError" style="float: left;">
					<label class="col-sm-3"><spring:message
              code="label.todate" />&nbsp;<font style="color: red"><spring:message
								code="label.symbol.asterik" /></font></label>
					<div class="col-sm-8 FieldsHeight">
						<form:input path="endDate" id="endDate" name="endDate"
							value="${viewResultsForm.endDate}"
							class="form-control DateField Wid90" 
							onchange="changeendDate()" readonly="true"/>

						<img src="./resources/images/calendar.jpg" width="20" height="35"
							onclick="javascript:NewCssCal('endDate','','','','','','past')"
							style="cursor: pointer" class="calendar-icon" title="Click to select ToDate" />
						<div hidden="true" class="col-md-12" id="Date_e_div1"
							style="width: 280px; float: left;">
							<div class="alert alert-danger" id="status_message">
								<span class="errormsgs" id="DateErr1"></span>
							</div>
						</div>

						<div hidden="true" class="col-md-12" id="validate_e_div"
							style="width: 280px; float: left;">
							<div class="alert alert-danger" id="status_message">
								<span class="errormsgs" id="validDateErr"></span>
							</div>
						</div>

					</div>



				</div>


				<div class="Fieldsrow ">
					<div class="col-sm-3">&nbsp;</div>
					<div class="col-sm-7 btns">
						<a href="#" class="default-btn" onclick="getSearchData()" title="Click to search data betweeen selected dates"><spring:message
              code="label.button.search" /></a>
					</div>
				</div>


				<div></div>
			</div>
			<div class="col-sm-12 pull-right Note">
      <strong><spring:message code="label.note.text" /></strong> <spring:message code="label.note.value1" /> <font style="color: red"><spring:message code="label.symbol.asterik" /></font>
     <spring:message code="label.note.value2" />
    </div>
		</div>

		<div id="searchResults" align="left"></div>
		<div>
			<ul id="pagination" class="pagination"></ul>
		</div>
</form:form>
