<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String type = request.getParameter("type");
if (type.equals("Cleaning")) 
{
    response.sendRedirect("maidclean.jsp");
} 
else if(type.equals("Cooking"))
{
    response.sendRedirect("maidcook.jsp");
}
else
{
	response.sendRedirect("index.html");
}
%>
</body>
</html>