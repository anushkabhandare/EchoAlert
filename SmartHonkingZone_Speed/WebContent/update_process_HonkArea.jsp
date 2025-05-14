<%@page import="java.util.*" %>
<%@page import="java.sql.*"%>
<%@page import="com.smarthonking.*"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>EchoAlert System</title>
</head>
<body>
<%
String id = request.getParameter("id");

String name = request.getParameter("nameTxt");

String city = request.getParameter("cityTxt");
String email = request.getParameter("emailTxt");
String mob = request.getParameter("mobTxt");
String area = request.getParameter("areaTxt");

if(id != null)
{
Connection con = null;
PreparedStatement ps = null;
int ID = Integer.parseInt(id);
try
{
//System.out.println("hallo");
con = DBconnect.getConnect();
String sql="Update honkarea set name=?,city=?,email=?,mob=?,areause=? where id ='"+id+"'";
ps = con.prepareStatement(sql);

ps.setString(1,name);
ps.setString(2,city);
ps.setString(3,email);
ps.setString(4,mob);
ps.setString(5,area);

int i = ps.executeUpdate();
if(i > 0)
{
	System.out.println("Honking Area Updated");
    response.sendRedirect("ViewHonkingArea.jsp");
}
else
{
out.print("There is a problem in updating Record.");
}
}
catch(SQLException sql)
{
request.setAttribute("error", sql);
out.println(sql);
}
}

%>
</body>
</html>