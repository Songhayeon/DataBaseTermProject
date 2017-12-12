package bean;
import java.sql.*;
public class LoginDao {

	public static boolean validate(LoginBean bean){
		boolean status=false;
		try{
			Connection con=ConnectionProvider.getCon();
			System.out.println(con);
			if(bean.getRadioValue() == 1)
			{
				PreparedStatement ps=con.prepareStatement("select * from roundsman where id=? and passwd=?");
				ps.setString(1,bean.getEmail());
				ps.setString(2, bean.getPass());
				ResultSet rs=ps.executeQuery();
				status=rs.next();
			}
			else
			{
				PreparedStatement ps=con.prepareStatement("select * from customer where id=? and passwd=?");
				ps.setString(1,bean.getEmail());
				ps.setString(2, bean.getPass());
				ResultSet rs=ps.executeQuery();
				status=rs.next();
			}			
			
		}catch(Exception e){}
		return status;
	}
}
