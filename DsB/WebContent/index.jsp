<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.models.bookstore.Login"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<%
    session=request.getSession(false);

    if(session.getAttribute("authUser") != null)
    {
    	Login l = (Login)session.getAttribute("authUser");
    	
    	 if (l.getRole().equals("adm"))
    		 response.sendRedirect("admin/admin.jsp");
    	 else if (l.getRole().equals("cus"))
    		 response.sendRedirect("customer/customer.jsp");
    }

%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Book Store</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
  		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dbs.css">
	</head>
<body>
<!-- *********** Navbar begins *********** -->
<nav class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand">Book Store</a>
		</div>
		<ul class="nav navbar-nav">
			<li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
			<li><a href="${pageContext.request.contextPath}/contact_us.jsp">Contact Us</a></li>
			<li><a href="${pageContext.request.contextPath}/about_us.jsp">About Us</a></li>
			</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="#"><span class="glyphicon glyphicon-user"></span> ${sessionScope.authUser.getUserId()} </a></li>
        </a>
		</ul>
	</div>
</nav>
<!-- *********** Navbar ends *********** -->

<div class="container-fluid">
    <div class="row">
    <div class="col-sm-4" ></div>
    <div class="col-sm-4">
	
	     <form action="UserLogin" method="POST">
			<div class="form-group">
				<label for="username">User ID:</label>
				<input type="text" class="form-control" id="userId" name="userId" required>
            </div>
            <div class="form-group">
                <label for="Password">Password:</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-default">Submit</button>
        </form>

 	</div>
    <div class="col-sm-4"></div>
	</div>
</div>
</body>
</html>