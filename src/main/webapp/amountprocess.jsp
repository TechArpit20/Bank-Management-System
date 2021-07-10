<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page
	import="java.sql.*,java.util.*,java.io.*,javax.servlet.*,javax.servlet.http.*, java.math.*"%>

<%
String amount = request.getParameter("amount");
int accountno = Integer.parseInt(request.getParameter("accountno"));
String password = request.getParameter("password");
Class.forName("com.mysql.cj.jdbc.Driver");
String acc=(String)session.getAttribute("account_no");
Connection conn=null;

try{
		conn = DriverManager.getConnection(System.getenv("product_uri"));

		PreparedStatement st = conn.prepareStatement("select accountno, balance, password from users where accountno=?");
		st.setString(1, acc);
		ResultSet rs = st.executeQuery();
		rs.next();{
		int bal=rs.getInt("balance");

		if (rs.getInt("accountno")==accountno && rs.getString("password").equals(password)) {

			int final_bal= bal+Integer.parseInt(amount);

			PreparedStatement st1 = conn.prepareStatement("UPDATE users set balance=? where accountno=?");
			st1.setInt(1, final_bal);
			st1.setString(2, acc);
			st1.executeUpdate();
			
			String deposit_query = "insert into transaction(c_account, accountno, deposit_amt, trans_details, balance) values("
					+ accountno + ","+ accountno + "," + amount + ",'" + "Self Deposit" + "'," + final_bal + ")";
			Statement st2 = conn.createStatement();
			st2.execute(deposit_query);

			session.setAttribute("title", "Success");
			session.setAttribute("error_name", "Hurray!!");
			session.setAttribute("error_tagline", "SUCCESSFUL");
			session.setAttribute("error_desc", "Money Deposited...");
			session.setAttribute("redirect", "manage.jsp");
			response.sendRedirect("error.jsp");
			}
		else {
			System.out.println("Something is wrong");
			session.setAttribute("title", "Error");
			session.setAttribute("error_name", "404");
			session.setAttribute("error_tagline", "Wrong Details");
			session.setAttribute("redirect", "deposit.html");
			response.sendRedirect("error.jsp"); }
		
		}

} catch (Exception e) {
	System.out.println(e);
	session.setAttribute("title", "Error");
	session.setAttribute("error_name", "404");
	session.setAttribute("error_tagline", "Wrong Details");
	session.setAttribute("redirect", "deposit.html");
	response.sendRedirect("error.jsp");
}
%>


