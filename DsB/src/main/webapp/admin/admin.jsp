
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="main.java.bookstore.models.bookstore.Login"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<%
    session=request.getSession(false);
    if(session.getAttribute("authUser")==null){
        response.sendRedirect(request.getContextPath()+"/index.jsp");
    }

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Book Store: Admin</title>
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
			<li class="active"><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
			<li><a href="${pageContext.request.contextPath}/contact_us.jsp">Contact Us</a></li>
			<li><a href="${pageContext.request.contextPath}/about_us.jsp">About Us</a></li>
			</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="#"><span class="glyphicon glyphicon-user"></span> ${sessionScope.authUser.getUserId()} </a></li>
			<li><a href="${pageContext.request.contextPath}/UserLogout" title="Logout"><span class="glyphicon glyphicon-log-out"></span> logout</li>
        </a>
		</ul>
	</div>
</nav>
<!-- *********** Navbar ends *********** -->

<div class="container-fluid">
    <div class="row">
    <div class="col-sm-3" ></div>
    <div class="col-sm-6">
    <h2>Welcome Admin!</h2>
    <!-- *********** Customer Information *********** -->
    <h4>Enter Customer Information:</h4>
    <br>
    <form action="formAction" method="GET" class="form-horizontal">
    <input type="hidden" name="formName" value="customerInfo">
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">Name:</label>
				<div class="col-sm-4"><input type="text" class="form-control" id="cname" name="cname"></div>
            </div>
            <div class="form-group">
                <label  class="control-label col-sm-2" for="address">Address:</label>
                <div class="col-sm-4"><input type="text" class="form-control" id="address" name="address"></div>
            </div>
            <div class="form-group">
				<label class="control-label col-sm-2" for="userId">User ID:</label>
				<div class="col-sm-4"><input type="text" class="form-control" id="userId" name="userId" required></div>
            </div>
            <button type="submit" class="btn btn-default">Submit</button>
        </form>
        
        <!-- *********** Book Information *********** -->
        <hr>
        <h4>Enter Book Information:</h4>
    <br>
    <form action="formAction" method="GET" class="form-horizontal">
    <input type="hidden" name="formName" value="bookInfo">
			<div class="form-group">
				<label class="control-label col-sm-2" for="isbn">ISBN:</label>
				<div class="col-sm-4"><input type="text" class="form-control" id="isbn" name="isbn" required></div>
            </div>
            <div class="form-group">
                <label  class="control-label col-sm-2" for="title">Title:</label>
                <div class="col-sm-4"><input type="text" class="form-control" id="title" name="title"></div>
            </div>
            <div class="form-group">
				<label class="control-label col-sm-2" for="authors">Author(s):</label>
				<div class="col-sm-4"><input type="text" class="form-control" id="authors" name="authors" ></div>
            </div>
            <div class="form-group">
				<label class="control-label col-sm-2" for="qtyInStock">Quantity:</label>
				<div class="col-sm-4"><input type="text" class="form-control" id="qtyInStock" name="qtyInStock" ></div>
            </div>
            <div class="form-group">
				<label class="control-label col-sm-2" for="price">Price/unit:</label>
				<div class="col-sm-4"><input type="text" class="form-control" id="price" name="price" required></div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="yop">Publish Year:</label>
				<div class="col-sm-4"><input type="text" class="form-control" id="yop" name="yop"></div>
			</div>	
            <button type="submit" class="btn btn-default">Submit</button>
        </form>
		<hr>    
    </div>
    <div class="col-sm-3"></div>
 	</div>
 </div>


</body>
</html>