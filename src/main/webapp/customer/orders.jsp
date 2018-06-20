<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="main.java.bookstore.models.bookstore.Login"%>
<%@ page import="main.java.bookstore.databasemanager.bookstore.DBManager"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Book Store</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script>
$.fn.pageMe = function(opts){
    var $this = this,
        defaults = {
            perPage: 7,
            showPrevNext: false,
            numbersPerPage: 5,
            hidePageNumbers: false
        },
        settings = $.extend(defaults, opts);
    
    var listElement = $this;
    var perPage = settings.perPage; 
    var children = listElement.children();
    var pager = $('.pagination');
    
    if (typeof settings.childSelector!="undefined") {
        children = listElement.find(settings.childSelector);
    }
    
    if (typeof settings.pagerSelector!="undefined") {
        pager = $(settings.pagerSelector);
    }
    
    var numItems = children.length;
    var numPages = Math.ceil(numItems/perPage);

    pager.data("curr",0);
    
    if (settings.showPrevNext){
        $('<li><a href="#" class="prev_link">Prev</a></li>').appendTo(pager);
    }
    
    var curr = 0;
    while(numPages > curr && (settings.hidePageNumbers==false)){
        $('<li><a href="#" class="page_link">'+(curr+1)+'</a></li>').appendTo(pager);
        curr++;
    }
  
    if (settings.numbersPerPage>1) {
       $('.page_link').hide();
       $('.page_link').slice(pager.data("curr"), settings.numbersPerPage).show();
    }
    
    if (settings.showPrevNext){
        $('<li><a href="#" class="next_link">Next</a></li>').appendTo(pager);
    }
    
    pager.find('.page_link:first').addClass('active');
    pager.find('.prev_link').hide();
    if (numPages<=1) {
        pager.find('.next_link').hide();
    }
  	pager.children().eq(1).addClass("active");
    
    children.hide();
    children.slice(0, perPage).show();
    
    pager.find('li .page_link').click(function(){
        var clickedPage = $(this).html().valueOf()-1;
        goTo(clickedPage,perPage);
        return false;
    });
    pager.find('li .prev_link').click(function(){
        previous();
        return false;
    });
    pager.find('li .next_link').click(function(){
        next();
        return false;
    });
    
    function previous(){
        var goToPage = parseInt(pager.data("curr")) - 1;
        goTo(goToPage);
    }
     
    function next(){
        goToPage = parseInt(pager.data("curr")) + 1;
        goTo(goToPage);
    }
    
    function goTo(page){
        var startAt = page * perPage,
            endOn = startAt + perPage;
        
        children.css('display','none').slice(startAt, endOn).show();
        
        if (page>=1) {
            pager.find('.prev_link').show();
        }
        else {
            pager.find('.prev_link').hide();
        }
        
        if (page<(numPages-1)) {
            pager.find('.next_link').show();
        }
        else {
            pager.find('.next_link').hide();
        }
        
        pager.data("curr",page);
       
        if (settings.numbersPerPage>1) {
       		$('.page_link').hide();
       		$('.page_link').slice(page, settings.numbersPerPage+page).show();
    	}
      
      	pager.children().removeClass("active");
        pager.children().eq(page+1).addClass("active");
    
    }
};

$(document).ready(function(){
    
  $('#myTable').pageMe({pagerSelector:'#myPager',showPrevNext:true,hidePageNumbers:false,perPage:7});
    
});
</script>

<style>
.table-responsive {
	height: 359px;
}
</style>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/dbs.css">

</head>
<body>
	<!-- *********** Navbar begins *********** -->
	<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand">Book Store</a>
		</div>
		<ul class="nav navbar-nav">
			<li class="active"><a
				href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
			<li><a href="${pageContext.request.contextPath}/contact_us.jsp">Contact
					Us</a></li>
			<li><a href="${pageContext.request.contextPath}/about_us.jsp">About
					Us</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#"><span
					class="glyphicon glyphicon-user"></span> 
					${sessionScope.authUser.getCname()} <span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="${pageContext.request.contextPath}/customer/profile.jsp">Profile</a></li>
				</ul></li>
			<li><a href="${pageContext.request.contextPath}/UserLogout"><span
					class="glyphicon glyphicon-log-out"></span> logout</li>
			</a>
		</ul>
	</div>
	</nav>
	<!-- *********** Navbar ends *********** -->
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-2">

				<div class="tab">
					<button class="tablinks"
						onclick="window.location.href='customer.jsp'">Catalogue</button>
					<button class="tablinks" onclick="')">Search</button>
					<button class="tablinks"
						onclick="window.location.href='history.jsp'">History</button>
				</div>

			</div>
			<div class="col-sm-8">
				
				<!-- *********** Order Information *********** -->
				<h4>Review your Order!</h4>
				<br>
				<form action="formAction" method="GET" class="form-horizontal">
					<input type="hidden" name="formName" value="bookOrder">
					<div class="table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>ISBN</th>
									<th>Title</th>
									<th>Author(s)</th>
									<th>Year</th>
									<th>Price</th>
									<th>Qty</th>
								</tr>
							</thead>
							<tbody id="myTable">
								<c:forEach var="book" items="${sessionScope.catalogue}">
									<tr>
										<td>1${book.getIsbn()}</td>
										<td>${book.getTitle()}</td>
										<td>${book.getAuthors()}</td>
										<td>${book.getYop()}</td>
										<td>$${book.getPrice()}</td>
										<td><input type="number" size="2" min="0"
											max="${book.getQtyInStock()}" name="${book.getIsbn()}"></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="row">
						<div class="col-sm-5 text-center">
							<ul class="pagination" id="myPager"></ul>
						</div>
						<div class="col-sm-3 text-center">
							<button type="submit" class="btn btn-default" id="order">Order!</button>
						</div>
					</div>
				</form>
			</div>
			<div class="col-sm-2"></div>
		</div>
	</div>
</body>
</html>