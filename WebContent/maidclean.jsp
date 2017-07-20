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
        <h2>Maid required for :</h2>
        <script type="text/javascript">
			function yesnoCheck() {
			    if (document.getElementById('noCheck').checked) {
			        document.getElementById('ifNo').style.display = 'block';
			        document.getElementById('ifYes').style.display = 'none';
			    }
			    else {
			    	document.getElementById('ifYes').style.display = 'block';
			    	document.getElementById('ifNo').style.display = 'none';
			    }
			}
		</script>
<form name=book_maid method=post action="BookForCleaning.jsp">
<p>Address : <textarea rows="4" cols="50" name=address></textarea></p>
<h2><input type="radio" onclick="javascript:yesnoCheck();" name="yesno" id="yesCheck" value="aDay"> A day</h2>
<h2><input type="radio" onclick="javascript:yesnoCheck();" name="yesno" id="noCheck" value="MoreDays"> More than a day</h2><br>
    <div id="ifYes" style="display:none">
        <p>Location : </p>
        <%
        Statement statement = null;
     	ResultSet rs = null;
		String connectionURL = "jdbc:mysql://localhost:3306/maiddatabase"; 
		Connection connection = null; 
		Class.forName("com.mysql.jdbc.Driver").newInstance(); 
		connection = DriverManager.getConnection(connectionURL, "root", "root");
		statement = connection.createStatement();
		String QueryString = "Select DISTINCT Location1 from locations";
		rs = statement.executeQuery(QueryString);
		while(rs.next())
		{
		%>		
		<p><input type="radio" name="check" value="<%= rs.getString(1) %>"> <%=rs.getString(1)%></p>
		<%} %>
		<p>Enter date : <input type="date" name="date1"></p>
		<p>Period of time you want the maid to arrive :
		<select name=acleaninghrs1>
		<option value="0">time</option>
		<option value="6">6</option>
		<option value="7">7</option>
		<option value="8">8</option>
		<option value="9">9</option>
		<option value="10">10</option>
		</select>   
		<select name=lcleaninghrs1>
		<option value="0">time</option>
		<option value="7">7</option>
		<option value="8">8</option>
		<option value="9">9</option>
		<option value="10">10</option>
		<option value="11">11</option></select>
		</p>
    </div>
    <%//Cleaning for more than a day %>
    <div id="ifNo" style="display:none">
        <p>Location : </p>
		<% 
		Statement statement1 = null;
     	ResultSet rs1 = null;
		statement1 = connection.createStatement();
		String QueryString1 = "Select DISTINCT Location1 from locations";
		rs1 = statement1.executeQuery(QueryString1);
		while(rs1.next())
		{
		%>		
		<p><input type="radio" name="check" value="<%= rs1.getString(1) %>"> <%=rs1.getString(1)%></p>
		<%} %>
		<p>From date :  <input type="date" name="fromDt">
		</p>
		<p>Till date : <input type="date" name="TillDt"></p>
		<p>Time you want the maid to arrive :
		<select name=a1cleaninghrs1>
		<option value="0">time</option>
		<option value="6">6</option>
		<option value="7">7</option>
		<option value="8">8</option>
		<option value="9">9</option>
		<option value="10">10</option>
		</select>   
		<select name=l1cleaninghrs1>
		<option value="0">time</option>
		<option value="7">7</option>
		<option value="8">8</option>
		<option value="9">9</option>
		<option value="10">10</option>
		<option value="11">11</option></select></p>
		<br>
    </div>
    	<center><p><input type=submit value="  Book Maid  "></p></center>
        </form>
      </div>
    </div>
    </div>
    <footer>
      <p><a href="index.html">home</a> | <a href="adminHome.jsp">Admin Home</a>
    </footer>
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