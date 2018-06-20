package com.bookstore.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bookstore.databasemanager.DBManager;
import com.bookstore.models.*;

/**
 * Servlet implementation class UserLogin
 */

public class UserLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserLogin() {
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
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        Login l = new Login();
        l.setUserId(userId);
        l.setPassword(password);
        Login authUser = DBManager.authenticateUser(l);
        if (authUser != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("authUser", authUser);
            if (authUser.getRole().equals("adm"))
                getServletContext().getRequestDispatcher("/admin/admin.jsp").forward(request, response);
            else if (authUser.getRole().equals("cus")) {
                session.setAttribute("catalogue", DBManager.getBooksInfo());
                getServletContext().getRequestDispatcher("/customer/customer.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("error.jsp");
        }
    }

}
