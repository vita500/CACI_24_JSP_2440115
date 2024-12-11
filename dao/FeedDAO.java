package dao;

import java.sql.*;
import java.util.ArrayList;
import javax.naming.NamingException;
import util.ConnectionPool;
import java.util.Calendar;

public class FeedDAO {
	public boolean insert(String uid, String ucon, String uimages) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			System.out.println(uid + ucon);
			
			String sql = "INSERT INTO m2440115feed(uid, content, image) VALUES(?, ?, ?)";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, uid);
			stmt.setString(2, ucon);
			stmt.setString(3, uimages);
			
			int count = stmt.executeUpdate();
			return (count == 1) ? true : false;
			
		} finally {
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		}
	}
	
	public boolean update(String no, String content, String image) throws NamingException, SQLException {
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    try {
	        // 이미지 수정 여부에 따른 SQL 쿼리 분기
	        String sql = "UPDATE m2440115feed SET content=?";
	        if(image != null) {
	            sql += ", image=?";
	        }
	        sql += " WHERE no=?";
	        
	        conn = ConnectionPool.get();
	        stmt = conn.prepareStatement(sql);
	        
	        // 파라미터 설정
	        stmt.setString(1, content);
	        if(image != null) {
	            stmt.setString(2, image);
	            stmt.setInt(3, Integer.parseInt(no));
	        } else {
	            stmt.setInt(2, Integer.parseInt(no));
	        }
	        
	        int count = stmt.executeUpdate();
	        return (count > 0);
	        
	    } finally {
	        if (stmt != null) stmt.close();
	        if (conn != null) conn.close();
	    }
	}
	
	public ArrayList<FeedObj> getList() throws NamingException, SQLException {
		   Connection conn = null;
		   PreparedStatement stmt = null;
		   ResultSet rs = null;
		   try {
		       String sql = "SELECT * FROM m2440115feed ORDER BY ts DESC";
		       
		       conn = ConnectionPool.get();
		       stmt = conn.prepareStatement(sql);
		       rs = stmt.executeQuery();
		       
		       ArrayList<FeedObj> feeds = new ArrayList<FeedObj>();
		       while(rs.next()) {
		           String no = Integer.toString(rs.getInt("no"));
		           
		           // 날짜 형식 변경
		           Timestamp ts = rs.getTimestamp("ts");
		           Calendar cal = Calendar.getInstance();
		           cal.setTimeInMillis(ts.getTime());
		           
		           String[] days = {"日", "月", "火", "水", "木", "金", "土"};
		           String formattedDate = String.format("%02d月%02d日(%s)", 
		               cal.get(Calendar.MONTH) + 1,
		               cal.get(Calendar.DAY_OF_MONTH),
		               days[cal.get(Calendar.DAY_OF_WEEK) - 1]
		           );
		           
		           feeds.add(new FeedObj(
		               no,
		               rs.getString("uid"),
		               rs.getString("content"),
		               formattedDate,
		               rs.getString("image")
		           ));
		       }
		       return feeds;
		       
		   } finally {
		       if (rs != null) rs.close();
		       if (stmt != null) stmt.close();
		       if (conn != null) conn.close();
		   }
		}
	
	public boolean delete(String no) throws NamingException, SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            String sql = "DELETE FROM m2440115feed WHERE no = ?";
            
            conn = ConnectionPool.get();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(no));
            System.out.println("삭제시도 글 번호: " + no);
            
            int count = stmt.executeUpdate();
            System.out.println("삭제된 행 수: " + count);
            return (count >= 1) ? true : false;
            
        } finally {
            if (stmt != null) stmt.close(); 
            if (conn != null) conn.close();
        }
    }
	
	public FeedObj getFeed(String no) throws NamingException, SQLException {
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    try {
	        String sql = "SELECT * FROM m2440115feed WHERE no = ?";
	        
	        conn = ConnectionPool.get();
	        stmt = conn.prepareStatement(sql);
	        stmt.setInt(1, Integer.parseInt(no));
	        rs = stmt.executeQuery();
	        
	        if(rs.next()) {
	            return new FeedObj(
	                no,
	                rs.getString("uid"),
	                rs.getString("content"),
	                rs.getString("ts"),
	                rs.getString("image")
	            );
	        }
	        return null;
	    } finally {
	        if (rs != null) rs.close();
	        if (stmt != null) stmt.close();
	        if (conn != null) conn.close();
	    }
	}
	
	public boolean isAdmin(String userId) throws NamingException, SQLException {
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    try {
	        String sql = "SELECT admin FROM m2440115 WHERE uid = ?";  // user 테이블에 admin 컬럼 필요
	        
	        conn = ConnectionPool.get();
	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, userId);
	        rs = stmt.executeQuery();
	        
	        return rs.next() && rs.getBoolean("admin");  // admin 컬럼이 true면 관리자
	        
	    } finally {
	        if (rs != null) rs.close();
	        if (stmt != null) stmt.close();
	        if (conn != null) conn.close();
	    }
	}
}