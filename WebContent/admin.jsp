<!DOCTYPE HTML>
<html>
<head>
  <title>BookMyMaid</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <link rel="stylesheet" type="text/css" href="css/style.css" />
  <script type="text/javascript" src="js/modernizr-1.5.min.js"></script></head>

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
        <form method="POST" name="maid_type" action="adminHome.jsp">
        <br><br>
        <p>Admin ID : <input type=text name=admin id=admin></p>
          <p>Password : <input type=password name=pwd id=pwd></p>
          <br>
          <input type=submit value=" SignIn " >
        </form>
      </div>
    </div>
    <footer>
      <p><a href="index.html">home</a> |<a href="admin.jsp">admin</a>      
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