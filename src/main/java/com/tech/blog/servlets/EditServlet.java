package com.tech.blog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

/**
 * Servlet implementation class EditServlet
 */
@MultipartConfig
@WebServlet("/EditServlet")
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

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
		
		// fetch all data
		PrintWriter out = response.getWriter();
		
		String userEmail = request.getParameter("user_email");
		String userName = request.getParameter("user_name");
		String userPassword = request.getParameter("user_password");
		String userAbout = request.getParameter("user_about");
		Part part = request.getPart("image");
		
		
		String imageName = part.getSubmittedFileName();
		
		// get the user from the session
		HttpSession s = request.getSession();
		User user = (User) s.getAttribute("currentUser");
		user.setEmail(userEmail);
		user.setName(userName);
		user.setPassword(userPassword);
		user.setAbout(userAbout);
		String oldFile=user.getProfile();
		user.setProfile(imageName);
		
		// update database...
		UserDao userDao = new UserDao(ConnectionProvider.getConnection());
		boolean ans = userDao.updateUser(user);
		if(ans) {
			
			
			String path = request.getServletContext().getRealPath("/pics")+File.separator + user.getProfile();
			
				// delete code
			String pathOldFile = request.getServletContext().getRealPath("/pics")+File.separator + oldFile;
				
				if(!oldFile.equals("default.png")) {
					Helper.deleteFile(pathOldFile);
				
				}
			
				if(Helper.saveFile(part.getInputStream(), path)) {
					out.print("Profile updated");
					System.out.println("Saving file to: " + path);

					Message msg = new Message("Profile details updated...", "success", "alert-success");
					
					s.setAttribute("msg", msg);
				} else {
					out.print("File not saved");
					Message msg = new Message("Something went wrong...", "error", "alert-danger");
					
					s.setAttribute("msg", msg);
					
				}
			
		} else {
			out.println("not updated");
			Message msg = new Message("Something went wrong...", "error", "alert-danger");
			s.setAttribute("msg", msg);
		}
		
		response.sendRedirect("profile.jsp");
		
	}

}
