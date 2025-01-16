package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tech.blog.dao.LikeDao;
import com.tech.blog.helper.ConnectionProvider;


public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		try(PrintWriter out = response.getWriter()) {
			String operation = request.getParameter("operation");
			int uid = Integer.parseInt(request.getParameter("uid"));
			int pid = Integer.parseInt(request.getParameter("pid"));
			
			/*
			 * out.println("data from server: "); out.println(operation); out.println(uid);
			 * out.println(pid);
			 */
			
			LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
			if(operation.equals("like") && !ldao.isLikedByUser(pid, uid)) {
				boolean f = ldao.insertLike(pid, uid);
				out.print(f);
			} else {
				boolean f = ldao.deleteLike(pid, uid);
				out.print("deletedLike");
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
