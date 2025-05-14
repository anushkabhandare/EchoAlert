<%@page import="java.util.*" %>
<%@page import="java.sql.*"%>
<%@page import="com.smarthonking.*"%>


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
			<li><a href="welcomeCorporation.jsp"> <i class="fa fa-home nav_icon"></i>
					<span class="nav-text"> Home </span>
			</a></li>
			<li class="has-subnav"><a href="AdvLocation.jsp"> <i
					class="fa fa-check-square-o nav_icon"></i> <span class="nav-text">
						Add Honking Area </span></li>

			<li><a href="ViewHonkingArea.jsp"> <i class="icon-table nav-icon"></i>
					<span class="nav-text">View Honking Area</span>
			</a></li>
			
			<li><a href="ChangePass.jsp"> <i class="fa fa-check-square-o nav_icon"></i>
					<span class="nav-text">Change Corporation Password</span>
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
					<a href="index.html"><img src="images/logo.png" alt="" /> Municipal Corporation Panel</a>
				</h3>
			</div>
		</section>
			<div class="main-grid">
				<div class="agile-grids">
					<div class="agile-tables">
					</div></div></div>
	</section>
	
	<%
									Statement statement = null;
									ResultSet resultSet = null;
									String hid = request.getParameter("id");
								%>
								<%
									try {
										Connection conn = DBconnect.getConnect();
										statement = conn.createStatement();
										String sql = "select * from honkarea where id = '"+hid+"'";
										resultSet = statement.executeQuery(sql);
										if (resultSet.next()) {
								%>
							
	
	<section class="wrapper scrollable">
	<form class="form-horizontal" action="update_process_HonkArea.jsp?id=<%=resultSet.getString("id")%>" method="post">
		<nav class="user-menu">
			<a href="javascript:;" class="main-menu-access"> <i
				class="icon-proton-logo"></i> <i class="icon-reorder"></i>
			</a>
		</nav>

		<div class="main-grid">

			<div class="main-grid">
				<div class="panel panel-widget forms-panel">
					<div class="progressbar-heading general-heading">
						<h4>Update Honking Area </h4>
					</div>
					<div class="forms">
						<h3 class="title1"></h3>
						<div class="form-three widget-shadow">
							
								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label">Name</label>
									<div class="col-sm-8">
										<input type="text" cols="7" rows="1" class="form-control"
										name="nameTxt"
										value="<%=resultSet.getString(2)%>">
									</div>

								</div>
								
								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label">City</label>
									<div class="col-sm-8">
									<input type="text" cols="7" rows="1" class="form-control"
										name="nameTxt"
										value="<%=resultSet.getString(3)%>">
										
										
										
									</div>

								</div>
								

								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label">Email</label>
									<div class="col-sm-8">
										<input type="text" cols="7" rows="1" class="form-control"
										name="emailTxt" value="<%=resultSet.getString(4)%>">
									</div>

								</div>

								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label">Contact</label>
									<div class="col-sm-8">
									<input type="text" cols="7" rows="1" class="form-control"
										name="mobTxt"
										value="<%=resultSet.getString(5)%>" 
											 minlength="10" maxlength="10">
										
									</div>

								</div>

								</div>
								
								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label">Honking Area Type</label>
									<div class="col-sm-8">
										<select name='areaTxt' id='positionddl'
											class="form-control" >
											<option ><%=resultSet.getString(7)%></option>
											<option>Hospital</option>
											<option>School</option>
											<option>College</option>
											<option>Old age homes</option>
											<option>Goverment offices</option>
										</select>
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
	<%
	}
									//connection.close();
								} catch (Exception e) {
									e.printStackTrace();
								}
								 %>
	
	
	<script src="js/bootstrap.js"></script>
	<script src="js/proton.js"></script>
</body>
</html>