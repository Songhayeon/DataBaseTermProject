package bean;
import java.sql.*;
public class LoginDao {

	public static boolean validate(LoginBean bean){
		boolean status=false;
		try{
			Connection con=ConnectionProvider.getCon();
			
			if(bean.getRadioValue() == 1)
			{
				//직원 아이디 입력.
				PreparedStatement ps=con.prepareStatement("select * from ROUNDSMAN where id=? and passwd=?");
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
