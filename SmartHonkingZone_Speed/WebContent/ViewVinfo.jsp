<%@page import="java.util.*"%>
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
<!-- tables -->
<link rel="stylesheet" type="text/css" href="css/table-style.css" />
<link rel="stylesheet" type="text/css" href="css/basictable.css" />
<script type="text/javascript" src="js/jquery.basictable.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#table').basictable();

		$('#table-breakpoint').basictable({
			breakpoint : 768
		});

		$('#table-swap-axis').basictable({
			swapAxis : true
		});

		$('#table-force-off').basictable({
			forceResponsive : false
		});

		$('#table-no-resize').basictable({
			noResize : true
		});

		$('#table-two-axis').basictable();

		$('#table-max-height').basictable({
			tableWrapper : true
		});
	});
</script>
</head>
<body class="dashboard-page">

	<nav class="main-menu">
		<ul>
			<li><a href="welcomeVinfo.jsp"> <i class="fa fa-home nav_icon"></i>
					<span class="nav-text"> Home </span>
			</a></li>
			<li class="has-subnav"><a href="AddVinfo.jsp"> <i
					class="fa fa-check-square-o nav_icon"></i> <span class="nav-text">
						Add Vehical Data</span></li>

			<li><a href="ViewVinfo.jsp"> <i class="icon-table nav-icon"></i>
					<span class="nav-text">View Veical Data</span>
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
					<a href="index.html"><img src="images/logo.png" alt="" />
						Vehical Registration Panel</a>
				</h3>
			</div>
			<div class="main-grid">
				<div class="agile-grids">
					<div class="agile-tables">
						<div class="w3l-table-info">
							<h3>Vehical Data</h3>
							<table id="table">
								<thead>
									<tr>
										<th>id</th>
										<th>Name</th>
										<th>Address</th>
										<th>Email</th>
										<th>Mobile</th>
										<th>Vehical_Type</th>
										<th>Vehical_Number</th>
										<th>Alternative_no</th>
										
										
										<th align="center">Action</th>
										<th align="center">Action</th>

									</tr>
									<%
										Statement statement = null;
										ResultSet resultSet = null;
									%>
									<%
										try {
											Connection conn = DBconnect.getConnect();
											statement = conn.createStatement();
											String corporation = UserInfo.getId();
											String sql = "SELECT * FROM `vinfodata` ";
											resultSet = statement.executeQuery(sql);
											while (resultSet.next()) {
									%>
								
								<tbody>
									<tr>

										<td><%=resultSet.getInt("id")%></td>
										<td><%=resultSet.getString("Name")%></td>
										<td><%=resultSet.getString("Address")%></td>
										<td><%=resultSet.getString("Email")%></td>
										<td><%=resultSet.getString("Mobile")%></td>
										
										<td><%=resultSet.getString("Vehical_Type")%></td>

										<td><%=resultSet.getString("Vehical_Number")%></td>
										<td><%=resultSet.getString("Alternative_no")%></td>
										
										<td><a
											href="UpdateHonkingArea.jsp?id=<%=resultSet.getString("id")%>"
											onclick="return confirm_alert(this);">Edit</a></td>

										<td><a
											href="DeleteHonkingArea.jsp?id=<%=resultSet.getString("id")%>"
											onclick="return confirm_alert(this);">Delete</a></td>

									</tr>
								</tbody>
								<%
									}
										//connection.close();
									} catch (Exception e) {
										e.printStackTrace();
									}
								%>

								</thead>
							</table>
						</div>

					</div>

				</div>

			</div>
		</section>


		<script src="js/bootstrap.js"></script>
		<script src="js/proton.js"></script>
</body>
</html>