package dao;

import java.sql.*;
import javax.naming.NamingException;
import java.util.*;

import util.ConnectionPool;

public class UserDAO {
	public boolean insert(String uid, String upw, String name, String phone) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			String sql = "INSERT INTO m2440115(name, uid, upw, phone) VALUES(?, ?, ?, ?)";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, name);
			stmt.setString(2, uid);
			stmt.setString(3, upw);
			stmt.setString(4, phone);
			
			int count = stmt.executeUpdate();
			return (count > 0) ? true : false;
			
		} finally {
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		}
	}
	
	public boolean exists(String uid) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT uid FROM m2440115 WHERE uid = ?";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1,  uid);
			
			rs = stmt.executeQuery();
			return rs.next();
			
		} finally {
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		}
	}
	
	public boolean update(String uid, String upw, String name, String phone) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			String sql = "UPDATE m2440115 set name=?, upw=?, phone=? WHERE uid=?";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, name);
			stmt.setString(2, upw);
			stmt.setString(3, phone);
			stmt.setString(4, uid);
			
			int count = stmt.executeUpdate();
			return (count >= 1) ? true : false;
		
		} finally {
			if (stmt != null) stmt.close();
			if(conn != null) conn.close();
		}
	}

	public boolean delete (String uid) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			String sql = "DELETE FROM m2440115 WHERE uid = ?";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1,  uid);
			
			int count = stmt.executeUpdate();
			return (count > 0) ? true : false;
			
		} finally {
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		}
	}

	public int login(String uid, String upass) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT uid, upw FROM m2440115 WHERE uid = ?";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, uid);
			
			rs = stmt.executeQuery();
			if (!rs.next()) return 1;
			if (!upass.equals(rs.getString("upw"))) return 2;
			
			return 0;
			
		} finally {
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		}
	}
	
	public ArrayList<UserDO> selectAll() throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT * FROM m2440115";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			ArrayList<UserDO> users = new ArrayList<UserDO>();
			
			while(rs.next()) {
				users.add(new UserDO(rs.getString("uid"), rs.getString("name"), rs.getString("phone")));
			}
		
			return users;
		
		} finally {
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		}
	}
	
	public UserDO getUser(String uid) throws NamingException, SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT * FROM m2440115 WHERE uid = ?";
            
            conn = ConnectionPool.get();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, uid);
            
            rs = stmt.executeQuery();
            if (rs.next()) {
            	return new UserDO(
            		    rs.getString("uid"),
            		    rs.getString("name"),
            		    rs.getString("phone"),
            		    rs.getString("upw")
            	);
            }
            return null;
            
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }
}