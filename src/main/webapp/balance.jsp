<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@page
	import="java.io.*, org.json.*,org.json.simple.*,org.json.simple.parser.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Balance</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>

</head>
<body style="background-color: skyblue">
	<%
	session.setAttribute("redirect", "manage.jsp");

	try {
		Connection conn = DriverManager.getConnection(System.getenv("product_uri"));
		String acc = (String) session.getAttribute("account_no");

		PreparedStatement st = conn.prepareStatement("select * from users where accountno=?");
		st.setString(1, acc);
		ResultSet rs = st.executeQuery();
		rs.next();
		{
			session.setAttribute("name", rs.getString("name"));
			session.setAttribute("email", rs.getString("email"));
			session.setAttribute("contact", rs.getString("contact"));
			session.setAttribute("address", rs.getString("address"));
			session.setAttribute("balance", rs.getString("balance"));
		}

	} catch (Exception e) {
		session.setAttribute("title", "Error");
		session.setAttribute("error_name", "404");
		session.setAttribute("error_tagline", "Connection Failed!!!");
		session.setAttribute("redirect", "manage.jsp");
		response.sendRedirect("error.jsp");
	}
	%>
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

	<br>
	<div class="container" style="width: 900px">
		<table class="table table-bordered"
			style="background-color: white; text-align: center">
			<thead class="thead-light">
				<tr>
					<th scope="col">Name</th>
					<td scope="col">
						<%
						out.println((String) session.getAttribute("name"));
						%>
					</td>
				</tr>
				<tr>
					<th scope="col">E-mail</th>
					<td scope="col"><%=(String) session.getAttribute("email")%></td>
				</tr>
				<tr>
					<th scope="col">Contact</th>
					<td scope="col"><%=(String) session.getAttribute("contact")%></td>
				</tr>
				<tr>
					<th scope="col">Address</th>
					<td scope="col"><%=(String) session.getAttribute("address")%></td>
				</tr>
				<tr>
					<th scope="col">Balance</th>
					<td scope="col"><%=(String) session.getAttribute("balance") == null ? 0 : (String) session.getAttribute("balance")%></td>
				</tr>
			</thead>
		</table>
	</div>
	<br>
	<br>

	<center>
		<h1>Transaction Details</h1>
	</center>
	<br>
	<div class="container" style="width: 1400px">
		<table class="table table-bordered" style="background-color: white">
			<thead class="thead-dark">
				<tr>
					<th scope="col">Account No.</th>
					<th scope="col">Date</th>
					<th scope="col">Transaction ID</th>
					<th scope="col">Transaction Details</th>
					<th scope="col">Withdraw Amount</th>
					<th scope="col">Deposit Amount</th>
					<th scope="col">Balance</th>
				</tr>
				<%
				try {
					Connection conn = DriverManager.getConnection(System.getenv("product_uri"));
					String acc = (String) session.getAttribute("account_no");

					PreparedStatement st = conn.prepareStatement("select * from transaction where c_account=?");
					st.setString(1, acc);
					ResultSet rs = st.executeQuery();
					while (rs.next()) {
						out.println("<tr><td>");
						out.println(rs.getString("accountno"));
						out.println("</td><td>");
						out.println(rs.getString("date"));
						out.println("</td><td>");
						out.println(rs.getString("trans_id"));
						out.println("</td><td>");
						out.println(rs.getString("trans_details"));
						out.println("</td><td>");
						out.println(((rs.getString("withdraw_amt") == null) ? 0 : rs.getString("withdraw_amt")));
						out.println("</td><td>");
						out.println(((rs.getString("deposit_amt") == null) ? 0 : rs.getString("deposit_amt")));
						out.println("</td><td>");
						out.println(rs.getString("balance"));
						out.println("</td></tr>");
					}

				} catch (Exception e) {
					session.setAttribute("title", "Error");
					session.setAttribute("error_name", "404");
					session.setAttribute("error_tagline", "Connection Failed!!!");
					session.setAttribute("redirect", "manage.jsp");
					response.sendRedirect("error.jsp");
				}
				%>
			</thead>
		</table>
	</div>
</body>
</html>