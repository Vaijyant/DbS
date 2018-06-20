package com.bookstore.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bookstore.databasemanager.*;
import com.bookstore.models.*;
/**
 * Servlet implementation class Action
 */
@WebServlet("/Action")
public class Action extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Action() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String formName = request.getParameter("formName");
		
		if (formName.equals("customerInfo")){
			DBManager.insertCustomerInfo(request.getParameter("cname"), request.getParameter("address"), request.getParameter("userId"));
			getServletContext().getRequestDispatcher("/admin/admin.jsp").forward(request, response);
		}
		
		if (formName.equals("bookInfo")){
			Books book = new Books();
			book.setIsbn(request.getParameter("isbn"));
			book.setTitle(request.getParameter("title"));
			book.setAuthors(request.getParameter("authors"));
			book.setQtyInStock(Integer.parseInt(request.getParameter("qtyInStock")));
			book.setPrice(Float.parseFloat(request.getParameter("price")));
			book.setYop(Integer.parseInt(request.getParameter("yop")));
			
			DBManager.insertBookInfo(book);
			
			getServletContext().getRequestDispatcher("/admin/admin.jsp").forward(request, response);
		}
		if (formName.equals("updatePass")){
			HttpSession session = request.getSession(true);
			Login l = new Login();
			l=(Login)session.getAttribute("authUser");
			DBManager.updatePassword(l.getUserId(), request.getParameter("confPass"));
			
			getServletContext().getRequestDispatcher("/customer/profile.jsp").forward(request, response);
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
