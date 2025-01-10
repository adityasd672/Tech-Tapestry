<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ page errorPage="error_page.jsp"%>

<%@page import="java.sql.*"%>

<% 
User user = (User) session.getAttribute("currentUser");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP Page</title>

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
	</style>


</head>
<body>

	<!-- navbar -->
	<%@include file="normal_navbar.jsp"%>

	<!-- banner -->

	<div class="container-fluid p-0 m-0">

		<div class="jumbotron primary-background banner-background text-white">
			<div class="container">
				<h3 class="display-3">Welcome to Tech Tapestry</h3>
				<p>A programming language is a system of notation for writing
					computer programs.[1] Programming languages are described in terms
					of their syntax (form) and semantics (meaning), usually defined by
					a formal language. Languages usually provide features such as a
					type system, variables, and mechanisms for error handling.</p>
				<p>An implementation of a programming language is required in
					order to execute programs, namely an interpreter or a compiler. An
					interpreter directly executes the source code, while a compiler
					produces an executable program.</p>
				<% if(user == null) {%>
				<button class="btn btn-outline-light btn-lg">
					<span class="fa fa-user-plus"></span> Start! its Free
				</button>
				<a href="login_page.jsp" class="btn btn-outline-light btn-lg">
					<span class="fa fa-user-circle fa-spin"></span> Login
				</a>
				<% }%>
			</div>
		</div>

	</div>

	<br>

	<!-- cards -->

	<div class="container">

		<div class="row mb-2">
			<!-- posts -->
					
					

					<!-- posts -->
					
					<div class="container text-center" id="loader" >
						<i class="fa fa-refresh fa-4x fa-spin"></i>
						<h3 class="mt-2">Loading...</h3>
					</div>
					
					<div class="container-fluid" id="post-container">
						
					</div>
					
					

				
		</div>
		
		

	</div>



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

	<script src="js/myjs.js" type="text/javascript"></script>
	
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

	<script>
		
	</script>
</body>
</html>