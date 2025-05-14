package com.services;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smarthonking.DBconnect;
import com.smarthonking.UserInfo;

/**
 * Servlet implementation class AddHonkingArea
 */
public class AddHonkingArea extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddHonkingArea() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		PrintWriter out = response.getWriter();
		{
			System.out.println("hhh");
	
			int id =0;
			String name = request.getParameter("nameTxt");
			String city = request.getParameter("locationTxt");
			String email = request.getParameter("emailTxt");
			String Contact = request.getParameter("ContactTxt");
			String password = "0";
			String area = request.getParameter("areaTxt");
			String type = "0";
			String corporation = UserInfo.getId();

			String lat=request.getParameter("lat");
			String lng=request.getParameter("lng");
			String sql=null;
			PreparedStatement ps1=null;

			Connection conn=DBconnect.getConnect();
			sql="select id from honkarea where id='"+id+"'";
			try {
				ps1=conn.prepareStatement("insert into honkarea values(?,?,?,?,?,?,?,?,?,?,?)");
				
				HttpSession session = request.getSession(true); // reuse existing
				
				session.setAttribute("user",id);
			
				PreparedStatement ps=conn.prepareStatement(sql);
				ResultSet r= ps.executeQuery();
			
				if(r.next())
				{
					request.getSession().setAttribute("msg", "Duplicate ID, Records Already Exist..!!");
	        		response.sendRedirect("AddHonkingArea.jsp"); 
				}else
				{
					ps1.setInt(1, id);
					ps1.setString(2, name);
					ps1.setString(3, city);
					ps1.setString(4, email);
					ps1.setString(5, Contact);
					ps1.setString(6, password);
					ps1.setString(7, area);
					ps1.setString(8, type);
					ps1.setString(9, corporation);
					ps1.setString(10, lat);
					ps1.setString(11, lng);
					
					int n= ps1.executeUpdate();
					System.out.println("Recort inserted");
					if(n>=1)
					{
						request.getSession().setAttribute("msg", "Record Inserted Successfully..!!");
						response.sendRedirect("AddHonkingArea.jsp"); 
					}
					else
					{
						request.getSession().setAttribute("msg", "Record Failed To Insert..!!");
						response.sendRedirect("AddHonkingArea.jsp"); 
					}
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}

}
