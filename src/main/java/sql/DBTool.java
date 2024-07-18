package sql;

import com.qst.util.JDBCUtil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.rowset.RowSetProvider;
import javax.sql.rowset.WebRowSet;

public class DBTool {

    //获取数据库连接

    public static Connection getConn() throws SQLException {

        Connection conn = JDBCUtil.getConnection();
        return conn;
    }

    //执行查询 rs<=sql

    public static ResultSet query(String sql) {
        System.out.println("DBTool.query sql=" + sql);
        ResultSet rs=null;
        try {
            Connection conn=getConn();
            Statement stmt=conn.createStatement();
            rs=stmt.executeQuery(sql);
            stmt.close();
            conn.close();
        }catch(SQLException e){
            System.err.println(e.toString());
        }
        return rs;
    }

    public static WebRowSet getRS(String sql) {
        System.out.println("DBTool.getRS sql=" + sql);
        WebRowSet wrs=null;
        try {
            Connection conn=getConn();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            //rs --> wrs
            wrs = RowSetProvider.newFactory().createWebRowSet();
            wrs.populate(rs);

            rs.close();
            stmt.close();
            conn.close();
        }catch(SQLException e) {
            System.err.println(e.toString());
        }
        return wrs;
    }

    public static int update(String sql) {
        System.out.println("DBTool.update sql=" + sql);
        int retVal=0;
        try {
            Connection conn = getConn();
            Statement stmt = conn.createStatement();
            retVal = stmt.executeUpdate(sql);
            stmt.close();
            conn.close();
        }catch(SQLException e){
            System.err.println(e.toString());
        }
        return retVal;
    }

}
