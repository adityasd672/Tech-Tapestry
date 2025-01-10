<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Page.</title>

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

	<%@include file="normal_navbar.jsp" %>


	<main class="primary-background banner-background " style="padding-bottom: 150px;">

		<div class="container ">

			<div class="col-md-6 offset-md-3">

				<div class="card">

					<div class="card-header text-center primary-background text-white">
						<span class="fa fa-user-circle fa-3x"></span> <br> Register
						here

					</div>
					<div class="card-body">
						<form id="reg-form" action="RegisterServlet" method="post">


							<div class="form-group">
								<label for="user_name">User Name</label> <input name="user_name" type="text"
									class="form-control" id="user_name"
									aria-describedby="emailHelp">
							</div>

							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input name="user_email" 
									type="email" class="form-control" id="exampleInputEmail1"
									aria-describedby="emailHelp"> <small id="emailHelp"
									class="form-text text-muted">We'll never share your
									email with anyone else.</small>
							</div>




							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> <input name="user_password" class="form-control"
									type="password" id="exampleInputPassword1">
							</div>

							<div class="form-group">
								<label for="user_gender">Select Gender</label>
								<br>
								<input type="radio"	 name="user_gender" value="male"> Male
								<input type="radio"	 name="user_gender" value="female"> Female
							</div>
							
							<div class="form-group">
								<textarea name="about" class="form-control" rows="5" placeholder="Enter something about yourself"></textarea>
							</div>

							<div class="form-group form-check">
								<input name="check" type="checkbox" class="form-check-input"
									id="exampleCheck1"> <label class="form-check-label"
									for="exampleCheck1">Agree Terms and Conditions</label>
							</div>
							
							<br>
							
							
							<div class="container text-center" id="loader" style="display: none">
								<span class="fa fa-refresh fa-spin fa-4x"></span>
								<h4> Please wait...</h4>
							</div>


							<button type="submit" id="submit-btn" class="btn btn-primary">Submit</button>
						</form>

					</div>

				</div>

			</div>

		</div>

	</main>


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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

	<script>
	
		$(document).ready(function() {
			console.log("loaded..........");
			
			$('#reg-form').on('submit', function(event) {
				event.preventDefault();
				
				let form = new FormData(this);
				
				$('#submit-btn').hide();
				$('#loader').show();
				// send register servlet
				
				$.ajax({
					url: "RegisterServlet",
					type: 'POST',
					data: form,
					success: function (data, textStatus,  jqXHR) {
						console.log(data);
						
						$('#submit-btn').show();
						$('#loader').hide();
						
						if(data.trim() === 'done') {
						swal("Registered Successfully.. we redirecting to login page.")
						.then((value) => {
						  window.location="login_page.jsp"
						});
						} else {
							swal(data);
						}
					},
					error: function (jqXHR, textStatus, errorThrown) {
						$('#submit-btn').show();
						$('#loader').hide();
						swal("Something went wrong.. try again")
						
					},
					processData: false,
					contentType: false
					
					
				})
			})
		})
		
		
		
		
	</script>
</body>
</html>