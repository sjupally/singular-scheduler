<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
</head>
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
	<link href="<c:url value='/resources/script/bootstrap.css' />" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/resources/script/jquery.base64.js' />"></script>
<link href="<c:url value='/resources/script/style.css' />" type="text/css" rel="stylesheet" />
<script type="text/javascript">

	var resultCount = 0;
	var params = {};
	var current_page = 0;
	$(function() {
		//alert("master");
		

		$('#configDiv').hide();

		 // add multiple select / deselect functionality
    $("#selectall").click(function () {
          $('.selectBrandIds1').attr('checked', this.checked);
    });
 
    // if all checkbox are selected, check the selectall checkbox
    // and viceversa
    $(".selectBrandIds1").click(function(){
 
        if($(".selectBrandIds1").length == $(".selectBrandIds1:checked").length) {
            $("#selectall").attr("checked", "checked");
        } else {
            $("#selectall").removeAttr("checked");
        }
 
    });

	});
	function popupDialog(url, divId) {
		$("#" + divId).html('');
		$.ajax({
			type : "GET",
			url : url,
			success : function(response) {
				$("#" + divId).html(response);
				$('#configDiv').show();
				popupOpen();
			}
		});
	}
	function popupOpen() {
		var popheight = $(".popup-div").height();
		var popWidth = $(".popup-div").width();
		var pageWidth = $(document).width();
		var pageHeight = $(document).height();
		var windowHeight = $(window).height();
		var left = (pageWidth - popWidth) / 2;
		var sTop = $(window).scrollTop();
		var top = ((windowHeight - popheight) / 2) + sTop;
		$(".popup-div").css({
			"left" : left,
			"top" : top
		});
		$(".back-popup-layer").show().css({
			"height" : pageHeight,
			"width" : pageWidth
		});
		$(".popup-div").show();
	}
	function closePopup() {
		$(".back-popup-layer").hide()
		$(".popup-div").hide();

	}

</script>


<body>
	<div id="page" class="">
		<%@ include file="/WEB-INF/jsp/templates/header.jsp"%>
		<div id="body">
			<div class="container">
				<div class="row">
					<div class="ContentArea">
						<div class="col-md-3 Menu">
							<%@ include file="/WEB-INF/jsp/templates/navigation.jsp"%>
						</div>

						<div class="col-md-9 Content">

							<decorator:body />
						</div>
					</div>
					<div class="popup-div" id="configDiv"></div>
				</div>
			</div>
		</div>
		<%@ include file="/WEB-INF/jsp/templates/footer.jsp"%>
	</div>
</body>
</html>