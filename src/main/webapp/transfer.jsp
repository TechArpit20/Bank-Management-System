<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@page import="java.io.*, org.json.*,org.json.simple.*,org.json.simple.parser.*"%>
<!DOCTYPE html>
<html>
<body>
	<%
	session.setAttribute("redirect", "transfer.html");

	String accountno = request.getParameter("accountno");
	int transfer_amt = Integer.parseInt(request.getParameter("transfer_amt"));
	String name = request.getParameter("name");
	String trans_details = request.getParameter("trans_details");
	Connection conn=null;
	
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		String acc = (String) session.getAttribute("account_no");
		conn = DriverManager.getConnection(System.getenv("product_uri"));

		// for  current user
		PreparedStatement st = conn.prepareStatement("select * from users where accountno=?");
		st.setString(1, acc);

		try {

			// for receiver	
			PreparedStatement st1 = conn.prepareStatement("select * from users where accountno=? and name=? and accountno!=?");
			st1.setString(1, accountno);
			st1.setString(2, name);
			st1.setString(3, acc);

			ResultSet rs = st.executeQuery(); // current user data
			ResultSet rs1 = st1.executeQuery(); // reciever data

			Statement stm = conn.createStatement();

			rs.next();
			{
		int balance_cuser = rs.getInt("balance");

		if (transfer_amt <= balance_cuser) {
			
			rs1.next();
			{
		name = rs1.getString("name").toLowerCase();
		accountno = rs1.getString("accountno");
		int balance = rs1.getInt("balance");
		if (transfer_amt > 0) {
			int updated_amt_ruser = 0;
			updated_amt_ruser = balance + transfer_amt;
			String query1 = "Update users set balance=" + updated_amt_ruser + " where accountno="
					+ accountno;
			stm.execute(query1);

			try {
				String deposit_query = "insert into transaction(c_account, accountno, deposit_amt, trans_details, balance) values("
						+ accountno + ","+ acc + "," + transfer_amt + ",'" + trans_details + "'," + updated_amt_ruser + ")";
				stm.execute(deposit_query);
			} catch (Exception e) {
				out.println("Error");
			}

			int updated_amt_cuser = 0;
			updated_amt_cuser = balance_cuser - transfer_amt;
			String query3 = "Update users set balance=" + updated_amt_cuser + " where accountno="
					+ acc;
			stm.execute(query3);
			
			try {
				String trans_query = "insert into transaction(c_account, accountno, withdraw_amt, trans_details, balance) values("
						+ acc + "," +accountno + "," + transfer_amt + ",'" + trans_details + "'," + updated_amt_cuser + ")";
				stm.execute(trans_query);
			} catch (Exception e) {
				out.println("ERROR");
			}

			session.setAttribute("title", "Success");
			session.setAttribute("error_name", "Hurray!!");
			session.setAttribute("error_tagline", "SUCCESSFUL");
			session.setAttribute("redirect", "manage.jsp");
			response.sendRedirect("error.jsp");
			
			
		} else {
			//Transferred Failed.
			session.setAttribute("title", "Error");
			session.setAttribute("error_name", "404");
			session.setAttribute("error_tagline", "Amount can't be Zero.");
			session.setAttribute("redirect", "transfer.html");
			response.sendRedirect("error.jsp");
		}
			}
			
			
			
			

		} else { // low balance
			session.setAttribute("title", "Error");
			session.setAttribute("error_name", "404");
			session.setAttribute("error_tagline", "Low Balance");
			session.setAttribute("redirect", "manage.jsp");
			response.sendRedirect("error.jsp");
		}
			}
		
		} catch (Exception e) {
			// details not valid
			session.setAttribute("title", "Error");
			session.setAttribute("error_name", "404");
			session.setAttribute("error_tagline", "Wrong Details");
			session.setAttribute("redirect", "transfer.html");
			response.sendRedirect("error.jsp");
		}
	} catch (Exception e) {
		System.out.print(e);
		e.printStackTrace();
	}
	%>
</body>
</html>