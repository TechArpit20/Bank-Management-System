<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@page
	import="java.io.*, org.json.*,org.json.simple.*,org.json.simple.parser.*"%>


<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<!-- <link
	href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
-->

<style>
.carousel-control-prev-icon {
	background-image:
		url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23000' viewBox='0 0 8 8'%3E%3Cpath d='M5.25 0l-4 4 4 4 1.5-1.5-2.5-2.5 2.5-2.5-1.5-1.5z'/%3E%3C/svg%3E")
		!important;
}

.carousel-control-next-icon {
	background-image:
		url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23000' viewBox='0 0 8 8'%3E%3Cpath d='M2.75 0l-1.5 1.5 2.5 2.5-2.5 2.5 1.5 1.5 4-4-4-4z'/%3E%3C/svg%3E")
		!important;
}
</style>
<title>manage account</title>
</head>

<body style="background-color: skyblue">
	<br>
	<br>
	<center>
		<div id="banner">
			<h1>
				<u>AJP Bank</u>
			</h1>
			<br />
		</div>
		<h3 id="sub">An online banking management system</h3>
		<br /> <br />
		<div id="banner">
	</center>



	<div class="container">
		<div style="max-width: 100%">
			<div class="alert alert-success" role="success">
				<button type="button"
					onclick="this.parentNode.parentNode.removeChild(this.parentNode);"
					class="close" data-dismiss="alert">
					<span aria-hidden="true">×</span><span class="sr-only">Close</span>
				</button>
				<center>
					<strong><i class="fa fa-warning"></i> Welcome!</strong>
				</center>
				<marquee>
					<p style="font-family: Impact; font-size: 18pt">
						Hello
						<% 
					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
						
						Connection conn = DriverManager.getConnection(System.getenv("product_uri"));
						String acc=(String)session.getAttribute("account_no");

						PreparedStatement st=conn.prepareStatement("select name from users where accountno=?");
						st.setString(1, acc);
						ResultSet rs=st.executeQuery();
						
						rs.next();
						{
							String name = rs.getString("name");
							out.println(name.toUpperCase());
						}

					} catch (Exception e) {
						session.setAttribute("title","Error");
						session.setAttribute("error_name", "404");
						session.setAttribute("error_tagline", "Something Went Wrong!!! Please Relogin");
						session.setAttribute("redirect", "index.html");
						response.sendRedirect("error.jsp");
					}
					%>

					</p>
				</marquee>
			</div>
		</div>
	</div>
	<div class="container" style="width: 600px">
		<div id="carouselExampleIndicators" class="carousel slide"
			data-ride="carousel" style="border: 4px solid red">
			<ol class="carousel-indicators">
				<li data-target="#carouselExampleIndicators" data-slide-to="0"
					class="active"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<a href="deposit.html"> <img class="d-block w-100"
						src="img/deposit.jpg" alt="Deposit">
					</a>
				</div>
				<div class="carousel-item">
					<a href="balance.jsp"> <img class="d-block w-100"
						src="img/balance.jpg" alt="Check Balance">
						<div class="carousel-caption d-none d-md-block"></a>
				</div>
			</div>
			<div class="carousel-item">
				<a href="transfer.html"> <img class="d-block w-100"
					src="img/transfer.jpg" alt="Money Transfer">
					<div class="carousel-caption d-none d-md-block"></a>
			</div>
		</div>
	</div>
	<a class="carousel-control-prev" href="#carouselExampleIndicators"
		role="button" data-slide="prev"> <span
		class="carousel-control-prev-icon" aria-hidden="true"></span> <span
		class="sr-only">Previous</span>
	</a>
	<a class="carousel-control-next" href="#carouselExampleIndicators"
		role="button" data-slide="next"> <span
		class="carousel-control-next-icon" aria-hidden="true"></span> <span
		class="sr-only">Next</span>
	</a>
	</div>



	</div>
	<br>
	<br>
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
</body>
</html>