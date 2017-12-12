package bean;

public class convert {

	public int[] getDay(int day) {
		
		int i;
		int[] week = new int[7];
		
		for(i = 0 ; i < 7 ; i++)
			week[i] = 0;
		
		if(day/1000000 == 1 )
		{
			week[6] = 1;
		}
		if(day/100000 >= 1 && (day/100000)%10 == 1)
		{
			week[5] = 1;
		}
		if(day/10000 >= 1 && (day/10000)%10 == 1)
		{
			week[4] = 1;
		}
		if(day/1000 >= 1 && (day/1000)%10 == 1)
		{
			week[3] = 1;
		}
		if(day/100 >= 1 && (day/100)%10 == 1)
		{
			week[2] = 1;
		}
		if(day/10 >= 1 && (day/10)%10 == 1)
		{
			week[1] = 1;
		}
		if (day%10 == 1)
		{
			week[0] = 1;
		}
		return week;
		
		
	}
	
	public String getDayString(int[] i_week)
	{
		String s_week="";
		String d_week = "월화수목금토일";
		int i;
		
		for(i = 0 ; i < 7 ; i++)
		{
			if(i_week[i] == 1)
			{
				s_week += d_week.charAt(i);
			}
		}
		return s_week;
	}
	
	public int searchDay(String week)
	{
		String d_week = "월화수목금토일";
		int i,k=1;
		
		for(i = 0 ; i < 7 ; i++)
		{
			if(!week.equals(d_week.charAt(i)))
			{
				k *= 10;
			}
			else
				break;
		}
		
		return k;
	}
}
