<div id="wrapper">
<header >  <!--header starts-->

<script type="text/javascript"> 
function display_c(){
	var refresh=1000; // Refresh rate in milli seconds
	mytime=setTimeout('display_ct()',refresh)
}

function display_ct() {
	
	var mydate=new Date()
	var year=mydate.getYear()
	if (year < 1000)
	year+=1900
	var day=mydate.getDay()
	var month=mydate.getMonth()
	/* if (month<10)
	month="0"+month */
	var daym=mydate.getDate()
	/* if (daym<10)
	daym="0"+daym */
	
	var secs = mydate.getSeconds()
	if (secs<10)
		secs="0"+secs
	
	var montharray=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
			
	var x1=daym + "/" + montharray[month] + "/" + year; 
	x1 = x1 + " - " +  mydate.getHours()+ ":" +  mydate.getMinutes() + ":" +  secs;
	
	document.getElementById('ct').innerHTML = x1;

	tt=display_c();
 }
</script>

    <div class="container header">
      <div class="row">
        <div class="col-md-9"></div>
        <div class="col-md-3">
        <a href="logout" class="logout">Logout
          <spring:message code="header.logout"/>
        </a>
          <h3 class="pull-right">FileCopy Job Scheduler<!-- <spring:message code="label.header.automationbuilder" /> --></h3>
		 <b><span class="pull-right" id='ct' ><font style="color: red"></font></span></b>
          </div>
        </div>
    </div>
  </header>
  <body onload="display_ct();">  
  </body>

</div>