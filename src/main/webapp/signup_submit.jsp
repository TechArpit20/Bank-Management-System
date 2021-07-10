<html>
<head>
<meta charset="ISO-8859-1">
<title>Account created</title>
</head>
<body style="background-color: skyblue;">
<center>
<div style=" min-height:700px; background: url(img/bank1.jpg) no-repeat center center; background-size: cover;">
<div style="text-align: center;
            margin-top: 0%;
            margin-right: 20%;
            margin-left: 20%;
	padding-bottom: 5%;
	border: 10px solid black;
	background-color: white;">
<div id="banner2" >
<h1>AJP Bank</h1>
</div>
<h3 id="sub">An online banking management system</h3><br/>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@page import="java.io.*, org.json.*,org.json.simple.*,org.json.simple.parser.*"%>


<%
String name=request.getParameter("name");
String email=request.getParameter("email");
String password=request.getParameter("password");
String contact=request.getParameter("contact");
String address=request.getParameter("address");

Class.forName("com.mysql.cj.jdbc.Driver");

Connection conn=null;
try{
	conn = DriverManager.getConnection(System.getenv("product_uri"));
}
catch(Exception e){
	session.setAttribute("title","Error");
	session.setAttribute("error_name", "404");
	session.setAttribute("error_tagline", "Connection Failed");
	session.setAttribute("redirect", "index.html");
	response.sendRedirect("error.jsp");
}

Statement st=conn.createStatement();

int i=st.executeUpdate("insert into users(name,email,password,contact,address)values('"+name.toLowerCase()+"','"+email+"','"+password+"','"+contact+"','"+address+"')");%>
<h2 style="color:red">Your Account has been succcessfully created
</h2><br/>
<h3>Your account number is </h3>
<%  String sql = "SELECT accountno FROM users where email='"+email+"'";
ResultSet rs = st.executeQuery(sql); 
try
{
rs.next();
{ String ano = rs.getString("accountno");
out.println(ano);
session.setAttribute("account_no",ano);}%>

<h3>To manage your account <a href="manage.jsp">Click here</a><br/>
	</h3>



<%}
catch(Exception e)
{
	session.setAttribute("redirect","signup.html");
	session.setAttribute("error_name", "404");
	session.setAttribute("error_tagline", "Something went wrong");
	session.setAttribute("redirect", "signup.html");
	response.sendRedirect("error.jsp");
}
%>

</div>
</div>
<footer style="margin-top:0%;
    padding: 10px 0;
 background-color: #101010;
 color:#9d9d9d;
 bottom:0;
 width:100%;
 position:relative;">
 <div class="container">
         <div>
             <h3>AJP Bank | Contact: +91-123-000000</h3>
             
             
         </div>
     </div>
</footer>
</center>
</body>
</html>