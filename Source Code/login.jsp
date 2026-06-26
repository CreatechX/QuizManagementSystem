<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>BrainBattle — Login</title>
  <link rel="stylesheet" href="css/style.css" />
</head>
<body>
  <main class="center">
    <div class="card">
      <h1 class="brand">BrainBattle</h1>
      <p class="subtitle">Sign in to start the battle</p>

      <form id="loginForm" action="LoginServlet" method="post" autocomplete="off">
        <div class="input-wrap">
          <input id="username" name="username" type="text" placeholder="Username" required />
        </div>

        <div class="input-wrap">
          <input id="password" name="password" type="password" placeholder="Password" required />
        </div>

        <div class="actions">
          <button type="submit" class="btn">Sign In</button>
          <a class="link" href="signup.jsp">Create account</a>
        </div>

        
        <%
          String error = request.getParameter("error");
          if (error != null && error.equals("1")) {
        %>
          <p style="color:red; font-size:14px; margin-top:10px;">
             Invalid username or password
          </p>
        <%
          }
        %>

        <div id="msg" class="msg"></div>
      </form>
    </div>
  </main>

  <script src="js/login.js"></script>
</body>
</html>
