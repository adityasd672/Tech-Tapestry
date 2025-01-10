package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {
	
	Connection con;

	public LikeDao(Connection con) {
		super();
		this.con = con;
	}
	
	public boolean insertLike(int pid, int uid) {
		
		boolean f = false;
		try {
			
			String q = "insert into likes (pid, uid) values (?,?)";
			
			PreparedStatement stmt = this.con.prepareStatement(q);
			stmt.setInt(1, pid);
			stmt.setInt(2, uid);
			
			stmt.executeUpdate();
			f = true;
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return f;
		
	}
	
	
	public int countLikeOnPost(int pid) {
		int count = 0;
		
		String q = "select count(*) as count from likes where pid=?";
		
		try {
			PreparedStatement stmt = this.con.prepareStatement(q);
			stmt.setInt(1, pid);
			
			ResultSet set = stmt.executeQuery();
			
			if(set.next()) {
				count = set.getInt("count");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
		return count;
	}

	
	public boolean isLikedByUser(int pid, int uid) {
		boolean f = false;
		
		
		try {
			PreparedStatement stmt = this.con.prepareStatement("Select * from likes where pid=? and uid=?");
			stmt.setInt(1, pid);
			stmt.setInt(2, uid);
			
			ResultSet set = stmt.executeQuery();
			
			if(set.next()) {
				f = true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
		
		return f;
	}
	
	public boolean deleteLike(int pid, int uid) {
		boolean f = false;
		
		try {
			
			String q = "delete from likes where pid = ? and uid = ?";
			
			PreparedStatement stmt = this.con.prepareStatement(q);
			stmt.setInt(1, pid);
			stmt.setInt(2, uid);
			
			stmt.executeUpdate();
			f = true;
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		return f;
	}



}
