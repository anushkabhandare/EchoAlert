<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>EchoAlert System</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Colored Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript">
	
	
	
	
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 




</script>
<!-- bootstrap-css -->
<link rel="stylesheet" href="css/bootstrap.css">
<!-- //bootstrap-css -->
<!-- Custom CSS -->
<link href="css/style.css" rel='stylesheet' type='text/css' />
<!-- font CSS -->
<link
	href='//fonts.googleapis.com/css?family=Roboto:400,100,100italic,300,300italic,400italic,500,500italic,700,700italic,900,900italic'
	rel='stylesheet' type='text/css'>
<!-- font-awesome icons -->
<link rel="stylesheet" href="css/font.css" type="text/css" />
<link href="css/font-awesome.css" rel="stylesheet">
<!-- //font-awesome icons -->
<script src="js/jquery2.0.3.min.js"></script>
<script src="js/modernizr.js"></script>
<script src="js/jquery.cookie.js"></script>
<script src="js/screenfull.js"></script>
<script>
	$(function() {
		$('#supported').text('Supported/allowed: ' + !!screenfull.enabled);

		if (!screenfull.enabled) {
			return false;
		}

		$('#toggle').click(function() {
			screenfull.toggle($('#container')[0]);
		});
	});
</script>

</head>
<body class="dashboard-page">

	<nav class="main-menu">
		<ul>
			<li><a href="welcome.jsp"> <i class="fa fa-home nav_icon"></i>
					<span class="nav-text"> Home </span>
			</a></li>
			<li class="has-subnav"><a href="AddMuncipalcorporation.jsp">
					<i class="fa fa-check-square-o nav_icon"></i> <span
					class="nav-text"> Add Muncipal corporation </span></li>

			<li><a href="ViewMuncipalcorporation.jsp"> <i
					class="icon-table nav-icon"></i> <span class="nav-text">Muncipal
						corporation Data</span>
			</a></li>

		<ul class="logout">
				<li><a href="index.jsp"> <i class="icon-off nav-icon"></i>
						<span class="nav-text"> Logout </span>
				</a></li>
			</ul>
		</ul>
	</nav>
	<section class="wrapper scrollable">
		<nav class="user-menu">
			<a href="javascript:;" class="main-menu-access"> <i
				class="icon-proton-logo"></i> <i class="icon-reorder"></i>
			</a>
		</nav>
		<section class="title-bar">
			<div class="logo">
				<h3>
					<a href="index.html"><img src="images/logo.png" alt="" />Honking
						Zone</a>
				</h3>
			</div>
		</section>

	</section>
	<section class="wrapper scrollable">
	<form class="form-horizontal" action="AddCorporationData" method="post">
		<nav class="user-menu">
			<a href="javascript:;" class="main-menu-access"> <i
				class="icon-proton-logo"></i> <i class="icon-reorder"></i>
			</a>
		</nav>

		<div class="main-grid">

			<div class="main-grid">
				<div class="panel panel-widget forms-panel">
					<div class="progressbar-heading general-heading">
						<h4>Add Muncipal corporations </h4>
					</div>
					<div class="forms">
						<h3 class="title1"></h3>
						<div class="form-three widget-shadow">
							
								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label">Name</label>
									<div class="col-sm-8">
										<textarea cols="7" rows="1" class="form-control"
											name="nameTxt" placeholder="Enter FullName" required></textarea>
									</div>

								</div>
								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label">Location</label>
									<div class="col-sm-8">
										<textarea cols="7" rows="1" class="form-control"
											name="locationTxt" placeholder="Enter FullName" required></textarea>
									</div>

								</div>

								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label">Email</label>
									<div class="col-sm-8">
										<textarea type="email" cols="7" rows="1" class="form-control"
											name="emailTxt" placeholder="Enter Email ID"
											onblur="validateEmail(this);" required></textarea>
									</div>

								</div>

								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label">Contact</label>
									<div class="col-sm-8">
										<textarea cols="7" rows="1" class="form-control"
											name="ContactTxt" placeholder="Enter Contact Number"
											onkeypress="return isNumberKey(event)" minlength="10"
											maxlength="10" required></textarea>
									</div>

								</div>




								<div class="form-group">
									<label for="inputPassword" class="col-sm-2 control-label">Password</label>
									<div class="col-sm-8">
										<input type="password" class="form-control1" name="passwordTxt"
											 placeholder="Password" required>
									</div>
								</div>

								<div class="form-group row m-b-0">
									<div class="col-sm-offset-3 col-sm-9">
										<button type="submit" class="btn btn-primary">Submit</button>
									</div>
								</div>
							
						</div>
					</div>
				</div>

			</div>
		</div>
</form>
	</section>
	
	<script src="js/bootstrap.js"></script>
	<script src="js/proton.js"></script>
		<SCRIPT language=Javascript>
		function isNumberKey(evt) {
			var charCode = (evt.which) ? evt.which : event.keyCode;

			if (charCode > 31 && (charCode<48 || charCode>57))
				return false;

			return true;
		}
	</SCRIPT>
</body>
</html>
