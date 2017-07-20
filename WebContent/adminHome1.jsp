<!DOCTYPE HTML>
<html>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<head>
  <title>BookMyMaid</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <link rel="stylesheet" type="text/css" href="css/style.css" />
  <script type="text/javascript" src="js/modernizr-1.5.min.js"></script>
</head>
<body>
  <div id="main">
    <header>
      <div id="logo"><h1><a href="#">BOOK</a>MYMAID</h1></div>
      <nav>
        <ul class="lavaLampWithImage" id="lava_menu">
          <li class="current"><a href="adminHome.jsp">Admin Home</a></li>
          <li class="current"><a href="admin.jsp">logout</a></li>
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
        <h1>Hi Admin !</h1>
        <p> Maid registered successfully.. Add Maid :</p>
        <form method="POST" name="maid_type" action="addMaid.jsp">
        <p>Maid Name : <input type="text" name=maidname></p>
        <p>Maid Type : <select name="maidtype">
          <option>--select--</option>
          <option>Cleaning</option>
          <option>Cooking</option>
          </select>
         <p> Maid Contact : <input type="text" name="phone">
        <p>Locations : 
        <%
        Statement statement = null;
     	ResultSet rs = null;
		String connectionURL = "jdbc:mysql://localhost:3306/maiddatabase"; 
		Connection connection = null; 
		Class.forName("com.mysql.jdbc.Driver").newInstance(); 
		connection = DriverManager.getConnection(connectionURL, "root", "root");
		statement = connection.createStatement();
		String QueryString = "SELECT * from locations";
		rs = statement.executeQuery(QueryString);
		while(rs.next())
		{
		%>		
		<p><input type="radio" name="check" value="<%= rs.getString(2) %>"> <%=rs.getString(2)%></p>
		<%} %>
		          &nbsp;  &nbsp;  &nbsp; &nbsp;&nbsp; &nbsp;  &nbsp;  &nbsp;<input type=submit value="  Add Maid  " >
        </form>
      </div>      
    </div>
  </div>
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
<%
rs.close();
statement.close();
connection.close();
 %>
</html>