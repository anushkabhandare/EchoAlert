<%@page import="java.util.*" %>
<%@page import="java.sql.*"%>
<%@page import="com.smarthonking.*"%>



<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
String id = request.getParameter("id");

//String old = request.getParameter("oldTxt");

String newpass = request.getParameter("newpassTxt");


if(id != null)
{
Connection con = null;
PreparedStatement ps = null;
int ID = Integer.parseInt(id);
try
{
//System.out.println("hallo");
con = DBconnect.getConnect();

PreparedStatement pss=con.prepareStatement("select * from corporation where id=?");
pss.setString(1, id);
ResultSet rss=pss.executeQuery();

if(rss.next())
{
if(rss.getString("pass").equals(request.getParameter("oldTxt")))
{
String sql="Update corporation set pass=? where id ='"+id+"'";
ps = con.prepareStatement(sql);

ps.setString(1,newpass);

int i = ps.executeUpdate();
if(i > 0)
{
	System.out.println("password Updated");
    response.sendRedirect("welcomeCorporation.jsp");
}
}
else
{
//out.print("There is a problem in updating Record.");
    response.sendRedirect("failPassword.jsp");
}
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