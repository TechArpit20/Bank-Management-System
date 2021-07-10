
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*,java.io.*,javax.servlet.*,javax.servlet.http.*"%>
<%@page import="org.json.*,org.json.simple.*,org.json.simple.parser.*"%>


<%

	String acc=request.getParameter("acc");
	String password=request.getParameter("password");
Class.forName("com.mysql.cj.jdbc.Driver");

Connection conn=null;

try{
	conn = DriverManager.getConnection(System.getenv("product_uri"));
	System.out.println("Connection Established");
}
catch(Exception e){
	System.out.println("Connection Failed "+e);
}

Statement st=conn.createStatement();

String sql = "SELECT accountno,password FROM users where accountno='"+acc+"'";
ResultSet rs= st.executeQuery(sql);
try{
rs.next();
 if(rs.getString("accountno").equals(acc) && rs.getString("password").equals(password))
	  {
		  String ano = rs.getString("accountno");
	      session.setAttribute("account_no",ano);
	  
		  response.sendRedirect("manage.jsp");}
	  else
	  {		
		  session.setAttribute("title","Error");
		  session.setAttribute("error_name", "404");
			session.setAttribute("error_tagline", "Invalid Login");
			session.setAttribute("redirect", "index.html");
			response.sendRedirect("error.jsp");
	 }
}
catch(Exception e)
{	
	session.setAttribute("redirect","home.html");
	session.setAttribute("title","Error");
	  session.setAttribute("error_name", "404");
		session.setAttribute("error_tagline", "Invalid Login");
		session.setAttribute("redirect", "index.html");
		response.sendRedirect("error.jsp");
} 
%>
