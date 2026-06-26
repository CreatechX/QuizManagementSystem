<%@ page import="javax.servlet.http.*" %>
<%
  String user = (String) session.getAttribute("username");
  String scoreStr = request.getParameter("score");
  String cat = request.getParameter("cat");
  String percentStr = request.getParameter("percent");

  if(user == null) user = "Guest";
  if(cat == null) cat = "General";
  if(scoreStr == null) scoreStr = "0";
  if(percentStr == null) percentStr = "0";
%>
<!DOCTYPE html>
<html>
<head>
  <title>Certificate</title>
  
  <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&display=swap" rel="stylesheet">

  <style>
    body {
      text-align: center;
      font-family: 'Times New Roman', serif;
      background: #f1f1f1;
    }
    .certificate {
      border: 12px solid #333; 
      padding: 40px;
      margin: 40px auto;
      width: 80%;
      
      background: linear-gradient(135deg, #FFD700, #FFEC8B, #FFD700);
      box-shadow: 0 8px 25px rgba(0,0,0,0.3);
      position: relative;
    }
    
    .certificate::before {
      content: "";
      position: absolute;
      top: 15px; left: 15px; right: 15px; bottom: 15px;
      border: 6px solid #fff;
      pointer-events: none;
    }
    .title {
      font-size: 52px;
      font-family: 'Great Vibes', cursive;
      margin-bottom: 20px;
      color: #8B0000; /* dark royal red for contrast */
      text-shadow: 2px 2px 6px rgba(0,0,0,0.3);
    }
    .subtitle {
      font-size: 22px;
      margin-bottom: 40px;
      color: #222;
    }
    .username {
      font-size: 38px;
      font-weight: bold;
      margin: 20px 0;
      color: #000;
    }
    .details {
      font-size: 20px;
      margin: 15px 0;
      color: #111;
    }
  </style>
</head>
<body>
  <div class="certificate">
    <div class="title">Certificate of Achievement</div>
    <div class="subtitle">This is to proudly certify that</div>

    <div class="username"><%= user %></div>

    <div class="details">
      has successfully completed the <b><%= cat %></b> quiz.<br/>
      Score: <b><%= scoreStr %></b><br/>
      Percentage: <b><%= percentStr %>%</b>
    </div>
  </div>
</body>
</html>
