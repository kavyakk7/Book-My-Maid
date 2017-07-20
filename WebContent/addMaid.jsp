<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BookMyMaid</title>
</head>
<body>
<%
String maidname = request.getParameter("maidname");
String maidtype = request.getParameter("maidtype");
String maidphone = request.getParameter("phone");
String locations =request.getParameter("check");
try 
{
String connectionURL = "jdbc:mysql://localhost:3306/maiddatabase"; 
Connection connection = null; 
Class.forName("com.mysql.jdbc.Driver").newInstance();
connection = DriverManager.getConnection(connectionURL, "root", "root");
Statement st = connection.createStatement();
int i = st.executeUpdate("insert into maid_details values(null,'" + maidname + "','" + maidtype + "','" + locations + "','" + maidphone + "')");
if (i > 0) {
    response.sendRedirect("adminHome1.jsp");
} else {
    response.sendRedirect("adminHome.jsp");
}
}
catch(Exception ex){
out.println("Unable to connect to database.");
}
%>
</body>
</html>