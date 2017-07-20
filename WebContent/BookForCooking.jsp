<!DOCTYPE HTML>
<html>
<head>
  <title>BookMyMaid</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <link rel="stylesheet" type="text/css" href="css/style.css" />
  <script type="text/javascript" src="js/modernizr-1.5.min.js"></script>
</head><body>
  <div id="main">
    <header>
      <div id="logo"><h1><a href="#">BOOK</a>MYMAID</h1></div>
      <nav>
        <ul class="lavaLampWithImage" id="lava_menu">
          <li class="current"><a href="index.html">home</a></li>
          <li> &nbsp;    &nbsp;   &nbsp;   &nbsp;&nbsp;    &nbsp;   &nbsp;   &nbsp;&nbsp;    &nbsp;   &nbsp;   &nbsp;&nbsp;    &nbsp;   &nbsp;   &nbsp;&nbsp;    &nbsp;   &nbsp;   &nbsp;&nbsp;    &nbsp;   &nbsp;   &nbsp;&nbsp;    &nbsp;   &nbsp;   &nbsp;&nbsp;    &nbsp;   &nbsp;   &nbsp;&nbsp;    &nbsp;   &nbsp;   &nbsp;  &nbsp;    &nbsp;   &nbsp;   &nbsp;    &nbsp;     &nbsp;  &nbsp;  &nbsp;   &nbsp;  &nbsp;     &nbsp;  &nbsp;  &nbsp;   </li>
          </ul>
      </nav>
    </header>
    <div id="site_content">
      <div id="sidebar_container">
        <div class="gallery">
          <ul class="images">
            <li class="show"><img width="450" height="450" src="images/1.png" alt="photo_one" /></li>
            <li><img width="450" height="450" src="images/2.jpeg" alt="photo_two" /></li>
            <li><img width="450" height="450" src="images/3.jpg" alt="photo_three" /></li>
          </ul>
        </div>
      </div>
      <div id="content">
        <h1>Welcome to BookMyMaid</h1>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Random"%>
<%@page import="javaPrograms.DateCompare"%>
<%
		String maidtype = "Cooking";
		String maidname = "";
		String maidphone = "";
		String days = request.getParameter("yesno");
		String location =request.getParameter("check");
		String address = request.getParameter("address");
		if(days.equals("aDay"))
		{
			String date = request.getParameter("date");
			String time1 = request.getParameter("time1");
			String time2 = time1+1;
			try
			{
				String connectionURL = "jdbc:mysql://localhost:3306/maiddatabase"; 
				Connection connection = null; 
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				connection = DriverManager.getConnection(connectionURL, "root", "root");
				Statement st = connection.createStatement();
			    ResultSet rs;
			    ArrayList<String> jobIds = new ArrayList<String>();
			    ArrayList<String> ids = new ArrayList<String>();
			    rs = st.executeQuery("select * from maid_details where MaidType='" + maidtype + "' and Location='" + location + "'");
			    while(rs.next())
				{
				ids.add(rs.getString(1));
				}
				int nMaids = ids.size();
				String in = "(";
				for(int i = 0; i < nMaids; i++)
				{
					in+="'M"+ids.get(i)+"',";
				}
				String in1 = in.substring(0,in.length()-1);
				in1+=")";
				try
				{
					Statement st1 = connection.createStatement();
				    ResultSet rs1;
				    rs1 = st1.executeQuery("select * from cleaning_maids where MID in " + in1);
					while(rs1.next())
					{
						maidname = rs1.getString(3);
						maidphone = rs1.getString(8);
						String onDschedule = rs1.getString(6);
						String[] myStr = onDschedule.split(":");
						int j;
						ArrayList<String> timeForDate = new ArrayList<String>();
						for(j=0;j<myStr.length;j=j+3)
						{
						    
							DateCompare dc = new DateCompare();
							int ret = dc.datecheckcmp(date, myStr[j]);
							if(ret==0 || ret==1 || ret==2)//dates are equal
							{
								timeForDate.add(myStr[j+1]);
								timeForDate.add(myStr[j+2]);
							}
						}
						int count=0;
						for(int l=0;l<timeForDate.size();l++)
						{
							if(time1.equals(timeForDate.get(l)))
							{
								count+=1;
							}
						}
						if(count==1)
						{
							for(int l=0;l<timeForDate.size();l++)
							{
								if((time1.equals(timeForDate.get(l)))&& (l%2!=0 || l!=0))
								{
									jobIds.add(rs1.getString(5));
								}
							}
						}
						else
						{
							%> <p>1.No maid found for your requirements...</p>
					        <p>Please go back and try once again..</p>
					      
					    <%
						}
					}
				int jsize = jobIds.size();
				if(jsize>0)
				{
					Random random = new Random();
					String randomInt = ids.get(random.nextInt(ids.size()));
					String mid = 'M'+randomInt;
					//2017-02-06
					String schedule = date+":"+time1+":"+time2+":";
					Statement st3 = connection.createStatement();
					int i = st3.executeUpdate("insert into job_details values(null,'Cooking','" + location + "','" + address + "','" + mid + "','" + schedule + "')");
					if (i > 0) 
					{
						Statement st4 = connection.createStatement();
					    ResultSet rs3;
					    rs3 = st4.executeQuery("select OneDayJobSchedule from cooking_maids where MID='" +mid+"'");
						if(rs3.next())
						{
							String new_schedule = rs3.getString(1);
							new_schedule+=schedule;
							String query="UPDATE cooking_maids SET OneDayJobSchedule='"+new_schedule+"' WHERE MID='"+mid+"'";
							PreparedStatement statement = null;
							statement=connection.prepareStatement(query);
							int count = statement.executeUpdate();
							if(count>0)
							{
								%>
						        <p>Maid booked successfully for <%out.println(maidtype); %>..</p>
						        <p>Maid id : <%out.println(mid); %></p>
						        <p>Maid name : <%out.println(maidname); %></p>
						        <p>Maid contact number : <%out.println(maidphone); %></p>
						      	<% 
							}
							else
							{
								%> <p>2.No maid found for your requirements...</p>
							        <p>Please go back and try once again..</p>
							      
							    <%
							}
					}
						else{
							%>
							<p>3.No maid found for your requirements...</p>
					        <p>Please go back and try once again..</p>
					        <%
						}
				}
					else{
						%> 
						<p>4.No maid found for your requirements...</p>
				        <p>Please go back and try once again..</p>
				        <%
					}
				}
				else
				{
					%> 
					<p>5.No maid found for your requirements...</p>
			        <p>Please go back and try once again..</p>
			        <%
				}
			}
			catch(Exception ex){
				//out.println("Unable to connect to database cleaning_maids.");
			}
			connection.close();
		}
		catch(Exception ex){
			//out.println("Unable to connect to database.");
		}
}							
else if(days.equals("MoreDays"))
{
			String fdate = request.getParameter("fromDt");
			String tdate = request.getParameter("TillDt");
			String time1 = request.getParameter("a1cleaninghrs1");
			String time2 = request.getParameter("l1cleaninghrs1");
			try
			{
				String connectionURL = "jdbc:mysql://localhost:3306/maiddatabase"; 
				Connection connection = null; 
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				connection = DriverManager.getConnection(connectionURL, "root", "root");
				Statement st = connection.createStatement();
			    ResultSet rs;
			    ArrayList<String> jobIds = new ArrayList<String>();
			    ArrayList<String> ids = new ArrayList<String>();
			    
			    rs = st.executeQuery("select * from maid_details where MaidType='" + maidtype + "' and Location='" + location + "'");
			    while(rs.next())
				{
				ids.add(rs.getString(1));
				}
				int nMaids = ids.size();
				String in = "(";
				for(int i = 0; i < nMaids; i++)
				{
					in+="'M"+ids.get(i)+"',";
				}
				String in1 = in.substring(0,in.length()-1);
				in1+=")";
				try
				{
					boolean maidAssigned = false;
					Statement st1 = connection.createStatement();
				    ResultSet rs1;
				    rs1 = st1.executeQuery("select * from cleaning_maids where MID in " + in1);
					while(rs1.next())
					{
						maidname = rs1.getString(3);
						String onMDschedule = rs1.getString(7);
						String[] myStr = onMDschedule.split(":");
						maidphone = rs1.getString(8);
						int j;
						ArrayList<String> timeForDate = new ArrayList<String>();
						for(j=0;j<myStr.length;j=j+3)
						{
						    
							DateCompare dc1 = new DateCompare();
							int fd = dc1.datecheckcmp(fdate, myStr[j]);
							int td = dc1.datecheckcmp(tdate, myStr[j+1]);
							if(fd==0 || fd==1 || fd==2 || td==0 || td==1 || td==2)//dates are equal
							{
								timeForDate.add(myStr[j+3]);
								timeForDate.add(myStr[j+4]);
							}
						}
						int count=0;
						for(int l=0;l<timeForDate.size();l++)
						{
							if(time1.equals(timeForDate.get(l)))
							{
								count+=1;
							}
						}
						if(count==1)
						{
							for(int l=0;l<timeForDate.size();l++)
							{
								if((time1.equals(timeForDate.get(l)))&& (l%2!=0 || l!=0))
								{
									jobIds.add(rs1.getString(5));
								}
							}
						}
						else{
							%> <p>1.No maid found for your requirements...</p>
					        <p>Please go back and try once again..</p>
					      
					    <%
						}
					}
				int jsize = jobIds.size();
				if(jsize>0)
				{
					Random random = new Random();
					String randomInt = ids.get(random.nextInt(ids.size()));
					String mid = 'M'+randomInt;
					//2017-02-06
					String schedule = fdate+":"+tdate+":"+time1+":"+time2+":";
					Statement st3 = connection.createStatement();
					int i = st3.executeUpdate("insert into job_details values(null,'Cleaning','" + location + "','" + address + "','" + mid + "','" + schedule + "')");
					if (i > 0) 
					{
						Statement st4 = connection.createStatement();
					    ResultSet rs3;
					    rs3 = st4.executeQuery("select JobSchedule from cleaning_maids where MID='" +mid+"'");
						if(rs3.next())
						{
							String new_schedule = rs3.getString(1);
							new_schedule+=schedule;
							String query="UPDATE cleaning_maids SET JobSchedule='"+new_schedule+"' WHERE MID='"+mid+"'";
							PreparedStatement statement = null;
							statement=connection.prepareStatement(query);
							int count = statement.executeUpdate();
							if(count>0)
							{
								%>
								<p>Maid booked successfully for <%out.println(maidtype); %>..</p>
								        <p>Maid id : <%out.println(mid); %></p>
								        <p>Maid name : <%out.println(maidname); %></p>
								        <p>Maid contact number : <%out.println(maidphone); %></p>
								     
								<%
							}
							else
							{
								%> <p>2.No maid found for your requirements...</p>
						        <p>Please go back and try once again..</p>
						      
						    <%
							}
					}else{
						%> <p>3.No maid found for your requirements...</p>
				        <p>Please go back and try once again..</p>
				      
				    <%
					}
				}else{
					%> <p>4.No maid found for your requirements...</p>
			        <p>Please go back and try once again..</p>
			      
			    <%
				}
				}else{
					%> <p>5.No maid found for your requirements...</p>
			        <p>Please go back and try once again..</p>
			      
			    <%
				}
				connection.close();
				}
			catch(Exception ex){
				//out.println("Unable to connect to database cleaning_maids.");
			}
				}
			
			catch(Exception ex){

			//out.println("Unable to connect to database.");
			}
		}
		else
		{
			//out.println("failed");
		}
%>
</div>
    </div>
    <footer>
      <p><a href="index.html">home</a> | <a href="adminHome.jsp">Admin Home</a> 
      
    </footer>
  </div>
  <!-- javascript at the bottom for fast page loading -->
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="js/jquery.easing.min.js"></script>
  <script type="text/javascript" src="js/jquery.lavalamp.min.js"></script>
  <script type="text/javascript" src="js/image_fade.js"></script>
  <script type="text/javascript">
    $(function() {
      $("#lava_menu").lavaLamp({
        fx: "backout",
        speed: 700
      });
    });
  </script>
</body> 
</html>