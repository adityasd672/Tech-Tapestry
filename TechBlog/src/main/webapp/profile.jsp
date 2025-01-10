<%@page import="java.util.ListIterator"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp"%>

<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login_page.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TechSoft</title>

<!-- css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
.banner-background {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 90%, 69% 85%, 35% 95%, 0 91%, 0 0);
}

body {
		background:url(img/bg-img.jpg);
		background-size: cover;
		background-attachment:fixed;
	
	}
</style>

</head>
<body>

	<!-- navbar -->

	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href="index.jsp"> <span
			class="fa fa-asterisk"></span> Tech Tapestry
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="#"> <span
						class="	fa fa-bell-o"></span> Explore Blogs <span
						class="sr-only">(current)</span></a></li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <span class="	fa fa-check-square-o"></span>
						Categories
				</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Programming Language</a> <a
							class="dropdown-item" href="#">Project Implementation</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Data Structure</a>
					</div></li>

				<li class="nav-item"><a class="nav-link" href="#"> <span
						class="	fa fa-address-card-o"></span> Contact
				</a></li>

				<li class="nav-item"><a class="nav-link" href="#!"
					data-toggle="modal" data-target="#add-post-modal"> <span
						class="	fa fa-asterisk"></span> Do Post
				</a></li>



			</ul>

			<ul class="navbar-nav mr-right">

				<li class="nav-item"><a class="nav-link" href="#!"
					data-toggle="modal" data-target="#profile-modal"> <span
						class="fa fa-user-circle "></span> <%=user.getName()%>
				</a></li>
				<li class="nav-item"><a class="nav-link" href="LogoutServlet">
						<span class="fa fa-user-plus "></span> Logout
				</a></li>
			</ul>

		</div>
	</nav>

	<!-- 	end of navbar -->

	<%
	Message m = (Message) session.getAttribute("msg");
	if (m != null) {
	%>
	<div class="alert <%=m.getCssClass()%>" role="alert">
		<%=m.getContent()%>
	</div>
	<%
	session.removeAttribute("msg");

	}
	%>


	<!-- 	main body of the page -->


	<main>
		<div class="container">
			<div class="row mt-4">
				<!-- first col -->

				<div class="col-md-4">

					<!-- categories -->

					<div class="list-group">
						<a href="#" onclick="getPosts(0, this)" class="c-link list-group-item list-group-item-action list-group-item-dark active" aria-current="true">All Posts</a> 
							
							<%
								// get all categories
								PostDao d = new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> list1 = d.getAllCategories();
								for(Category cc: list1) { %>
									<a href="#" onclick="getPosts(<%= cc.getCid() %>, this)" class="c-link list-group-item list-group-item-action list-group-item-dark"><%= cc.getName() %></a>
								<%}
							
							
							%>
						
						 
					</div>

				</div>

				<!-- 	second col -->
				<div class="col-md-8">

					<!-- posts -->
					
					<div class="container text-center" id="loader" >
						<i class="fa fa-refresh fa-4x fa-spin"></i>
						<h3 class="mt-2">Loading...</h3>
					</div>
					
					<div class="container-fluid" id="post-container">
						
					</div>
					
					

				</div>


			</div>

		</div>
	</main>



	<!-- 	end main body of the page -->



	<!-- profile modal -->

	<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white text-center">
					<h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">

						<img src="pics/<%=user.getProfile()%>" class="img-fluid"
							alt="users-profile" style="border-radius: 50%; max-width: 150px">
						<h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5>
						<!-- details -->

						<div id="profile-details">

							<table class="table">

								<tbody>
									<tr>
										<th scope="row">ID:</th>
										<td><%=user.getId()%></td>

									</tr>
									<tr>
										<th scope="row">Email:</th>
										<td><%=user.getEmail()%></td>

									</tr>
									<tr>
										<th scope="row">Gender:</th>
										<td><%=user.getGender()%></td>

									</tr>
									<tr>
										<th scope="row">Status:</th>
										<td><%=user.getAbout()%></td>

									</tr>
									<tr>
										<th scope="row">Registered on:</th>
										<td><%=user.getDateTime().toLocaleString()%></td>

									</tr>
								</tbody>
							</table>
						</div>

						<!-- profile edit -->

						<div id="profile-edit" style="display: none">
							<h3 class="mt-2">Please Edit carefully</h3>
							<form action="EditServlet" method="post"
								enctype="multipart/form-data">
								<table class="table">

									<tr>
										<th scope="row">ID:</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Email:</th>
										<td><input type="email" name="user_email"
											class="form-control" value="<%=user.getEmail()%>"></td>
									</tr>
									<tr>
										<th scope="row">Name:</th>
										<td><input type="text" name="user_name"
											class="form-control" value="<%=user.getName()%>"></td>
									</tr>
									<tr>
										<th scope="row">Password:</th>
										<td><input type="text" name="user_password"
											class="form-control" value="<%=user.getPassword()%>"></td>
									</tr>

									<tr>
										<th scope="row">Gender:</th>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>
									<tr>
										<th scope="row">About:</th>
										<td><textarea class="form-control" name="user_about"
												rows="3"><%=user.getAbout()%></textarea></td>
									</tr>
									<tr>
										<th scope="row">New profile:</th>
										<td><input type="file" name="image"
											class="form-control border-0"></td>
									</tr>



								</table>

								<div class="container">
									<button type="submit" class="btn btn-outline-primary">Save</button>
								</div>

							</form>

						</div>


					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id="edit-profile-button" type="button"
						class="btn btn-primary">EDIT</button>
				</div>
			</div>
		</div>
	</div>

	<!-- end of profile modal -->

	<!-- add post modal -->

	<div class="modal fade" id="add-post-modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Provide the
						post details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">

					<form id="add-post-form" action="AddPostServlet" method="post"
						enctype="multipart/form-data">

						<div class="form-group rows">
							<select class="form-control col-md-6" name="cid">
								<option selected disabled>----Select Category----</option>

								<%
								PostDao postd = new PostDao(ConnectionProvider.getConnection());

								ArrayList<Category> list = postd.getAllCategories();

								for (Category c : list) {
								%>
								<option value="<%=c.getCid()%>"><%=c.getName()%></option>
								<%
								}
								%>
							</select>
						</div>

						<div class="form-group">

							<input name="pTitle" type="text"
								placeholder="Enter post title..." class="form-control">

						</div>

						<div class="form-group">

							<textarea name="pContent" class="form-control"
								style="height: 200px" rows="" cols=""
								placeholder="Enter your content"></textarea>
						</div>

						<div class="form-group">

							<textarea name="pCode" class="form-control" style="height: 100px"
								rows="" cols="" placeholder="Enter your program (if any)"></textarea>
						</div>
						<div class="form-group">
							<label>Select your pic : </label> <input name="pic" type="file"
								class="form-control border-0">
						</div>


						<div class="container text-center">
							<button type="submit" class="btn btn-outline-primary">Post</button>

						</div>


					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<!-- <button type="button" class="btn btn-primary">Save changes</button> -->
				</div>
			</div>
		</div>
	</div>



	<!-- end post modal -->


	<!-- javascripts -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
		integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
		integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"
		integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>

	<script src="js/myjs.js" type="text/javascript"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			let editStatus = false;

			$("#edit-profile-button").click(function() {

				// Toggle logic
				if (editStatus == false) {
					$("#profile-details").hide();
					$("#profile-edit").show();
					editStatus = true;
					$(this).text("Back");
				} else {
					$("#profile-details").show();
					$("#profile-edit").hide();
					editStatus = false;
					$(this).text("EDIT");
				}

			})
		})
	</script>

	<!-- now add post js -->

	<script type="text/javascript">
		$(document)
				.ready(
						function(e) {
							// 
							$("#add-post-form")
									.on(
											"submit",
											function(event) {
												// this code gets called when form is submitted...
												event.preventDefault();
												let form = new FormData(this);

												// now requesting to server
												$
														.ajax({
															url : "AddPostServlet",
															type : "POST",
															data : form,
															success : function(
																	data,
																	textStatus,
																	jqXHR) {
																// success...
																console
																		.log(data);
																if (data.trim() == 'done') {
																	swal(
																			"Good job!",
																			"Saved Successfully!",
																			"success");
																} else {
																	swal(
																			"Error!",
																			"Something went wrong try again...",
																			"error");
																}
															},
															error : function(
																	jqXHR,
																	textStatus,
																	errorThrown) {
																// error...
																swal(
																		"Error!",
																		"Something went wrong try again...",
																		"error");
															},

															processData : false,
															contentType : false
														// kyunki form mein photo bhi hain
														})
											})
						})
	</script>
	
	<!-- loading post using ajax -->
	<script>
	
		function getPosts(catId, temp) {
			
			$("#loader").show();
			$("#post-container").hide();
			
			$(".c-link").removeClass('active');
			$.ajax({
				url: "load_posts.jsp",
				data: {cid: catId},
				success: function (data, textStatus, jqXHR) {
					console.log(data);
					$("#loader").hide();
					$("#post-container").show();
					$("#post-container").html(data);
					$(temp).addClass('active');
				}
			})
		}
		$(document).ready(function(e) {
			let allPostRef = $('.c-link')[0];
			getPosts(0, allPostRef);
			
		})
	
	</script>


</body>
</html>
