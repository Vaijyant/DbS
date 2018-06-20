package com.bookstore.databasemanager;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.bookstore.models.*;

public class DBManager {

	private static final String DBDriver = "com.mysql.jdbc.Driver";
	private static final String DBUrl = "jdbc:mysql://localhost/dbs";

	private static final String DBUser = "root";
	private static final String DBPass = "admin";

	static {
		try {
			Class.forName(DBDriver);
		} catch (Exception ex) {
			System.out.println("DBManager says Driver Not Avaialble." + ex);
		}
	}

	public static Login authenticateUser(Login l) {
		Login authUser = null;
		try {
			Connection con = DriverManager.getConnection(DBUrl, DBUser, DBPass);
			PreparedStatement pst = con
					.prepareStatement("Select user_id, password, cid, role from login where user_id=? and password=?");

			pst.setString(1, l.getUserId());
			pst.setString(2, l.getPassword());
			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				authUser = new Login();
				authUser.setUserId(l.getUserId());
				authUser.setPassword(l.getPassword());
				authUser.setRole(rs.getString("role"));
				authUser.setCid(rs.getInt("cid"));
			}
			rs.close();
			pst.close();
			con.close();
		} catch (Exception ex) {
			System.out.println(ex);
		}
		if (authUser.getRole().equals("cus")) {
			try {
				Connection con = DriverManager.getConnection(DBUrl, DBUser, DBPass);
				PreparedStatement pst = con.prepareStatement("Select cid, cname, address from customers where cid=?");
				pst.setInt(1, authUser.getCid());

				ResultSet rs = pst.executeQuery();
				if (rs.next()) {
					authUser.setCid(rs.getInt("cid"));
					authUser.setCname(rs.getString("cname"));
					authUser.setAddress(rs.getString("address"));
				}

			} catch (Exception ex) {
				System.out.println(ex);
			}
		}
		return authUser;
	}

	public static void insertCustomerInfo(String cname, String address, String userId) {
		try {
			Connection con = DriverManager.getConnection(DBUrl, DBUser, DBPass);

			PreparedStatement pst = con.prepareStatement("SELECT MAX(cid) as max FROM customers");
			ResultSet rs = pst.executeQuery();

			rs.next();

			int cid = rs.getInt("max") + 1;

			PreparedStatement pst1 = con
					.prepareStatement("INSERT INTO customers (cid, cname, address) VALUES (?, ?, ?)");
			pst1.setInt(1, cid);
			pst1.setString(2, cname);
			pst1.setString(3, address);
			pst1.executeUpdate();

			PreparedStatement pst2 = con.prepareStatement(
					"INSERT INTO login (user_id, password, cid, role) VALUES (?, 'password', ?, 'cus')");
			pst2.setString(1, userId);
			pst2.setInt(2, cid);
			pst2.executeUpdate();

		} catch (Exception ex) {
			System.out.println(ex);
		}
	}

	public static void insertBookInfo(Books b) {
		try {
			Connection con = DriverManager.getConnection(DBUrl, DBUser, DBPass);

			PreparedStatement pst = con.prepareStatement(
					"INSERT INTO books (isbn, title, authors, qty_in_stock, price, year_publish) VALUES (?, ?, ?, ?, ?, ?)");

			pst.setString(1, b.getIsbn());
			pst.setString(2, b.getTitle());
			pst.setString(3, b.getAuthors());
			pst.setInt(4, b.getQtyInStock());
			pst.setFloat(5, b.getPrice());
			pst.setInt(6, b.getYop());
			pst.executeUpdate();

		} catch (Exception ex) {
			System.out.println(ex);
		}
	}

	public static ArrayList<Books> getBooksInfo() {
		ArrayList<Books> catalogue = new ArrayList<Books>();
		try {
			Connection con = DriverManager.getConnection(DBUrl, DBUser, DBPass);
			PreparedStatement pst = con.prepareStatement(
					"SELECT isbn, title, authors, qty_in_stock, price, year_publish FROM books");
			pst.executeQuery();

			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				Books book = new Books();
				book.setIsbn(rs.getString("isbn"));
				book.setTitle(rs.getString("title"));
				book.setAuthors(rs.getString("authors"));
				book.setQtyInStock(rs.getInt("qty_in_stock"));
				book.setPrice(rs.getFloat("price"));
				book.setYop(rs.getInt("year_publish"));
				catalogue.add(book);
			}
		} catch (Exception ex) {
			System.out.println(ex);
		}
		return catalogue;
	}
	public static void updatePassword(String userId, String password){
		try {
			Connection con = DriverManager.getConnection(DBUrl, DBUser, DBPass);
			PreparedStatement pst = con.prepareStatement("UPDATE login SET password=? WHERE user_id=?");
			pst.setString(1, password);
			pst.setString(2, userId);
			pst.executeUpdate();
		} catch (Exception ex) {
			System.out.println(ex);
		}		
	}
}
