<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>BrainBattle — Dashboard</title>
  <style>
    body {
      background:url("images/bg.png") no-repeat center center fixed;
      background-size:cover;
      font-family:"Segoe UI",Arial,sans-serif;
      color:#fff;
    }
    .dash-container{
      display:flex;flex-direction:column;align-items:center;justify-content:flex-start;
      min-height:100vh;padding:40px;
    }
    .welcome{font-size:28px;font-weight:bold;margin-bottom:20px;text-align:center}
    .btn-bar{display:flex;gap:18px;margin-bottom:30px}
    .dash-btn{
      padding:12px 22px;border:none;border-radius:10px;font-size:16px;font-weight:600;
      cursor:pointer;transition:.2s;
      background:linear-gradient(90deg,#4f8ef7,#18c6a0);color:#fff;
    }   
  .dash-btn:hover{transform:scale(1.05)}

    /* categories */
    .categories{max-width:900px;width:100%;margin-top:20px}
    .cat-group{background:rgba(0,0,0,0.55);border-radius:12px;padding:20px;margin-bottom:20px}
    .cat-title{font-size:20px;font-weight:700;margin-bottom:12px;color:#ffd47a}
    .sub-list{display:flex;flex-wrap:wrap;gap:12px}
    .sub-item{
      text-decoration:none;
      color:#fff;
      background:rgba(255,255,255,0.08);
      border:1px solid rgba(255,255,255,0.15);
      padding:8px 14px;border-radius:8px;
      cursor:pointer;transition:.2s;
    }
    .sub-item:hover{background:rgba(79,142,247,0.3)}
  </style>
</head>
<body>
  <div class="dash-container">
    <div class="welcome">Welcome to BrainBattle!</div>

    <div class="btn-bar">
      <button class="dash-btn" onclick="location.href='quiz.jsp?cat=MixAll'">General Quiz</button>
      <button class="dash-btn" onclick="location.href='leaderboard.jsp'">Leaderboard</button>
      <button class="dash-btn" onclick="location.href='login.jsp'">Logout</button>
    </div>

    <div class="categories">
      <!-- 1. Academics -->
      <div class="cat-group">
        <div class="cat-title">Academics (School Subjects)</div>
        <div class="sub-list">
          <a class="sub-item" href="quiz.jsp?cat=Math">Mathematics</a>
          <a class="sub-item" href="quiz.jsp?cat=Science">Science</a>
          <a class="sub-item" href="quiz.jsp?cat=Physics">Physics</a>
          <a class="sub-item" href="quiz.jsp?cat=Chemistry">Chemistry</a>
          <a class="sub-item" href="quiz.jsp?cat=Biology">Biology</a>
          <a class="sub-item" href="quiz.jsp?cat=History">History</a>
          <a class="sub-item" href="quiz.jsp?cat=English">English / Literature</a>
        </div>
      </div>

      <!-- 2. Competitive Exams -->
      <div class="cat-group">
        <div class="cat-title">Competitive Exams</div>
        <div class="sub-list">
          <a class="sub-item" href="quiz.jsp?cat=JEE">JEE (Engineering)</a>
          <a class="sub-item" href="quiz.jsp?cat=NEET">NEET (Medical)</a>
        </div>
      </div>

      <!-- 3. Special Categories -->
      <div class="cat-group">
        <div class="cat-title">Special Categories / Fun</div>
        <div class="sub-list">
          <a class="sub-item" href="quiz.jsp?cat=Image Identification">Image Identification</a>
          <a class="sub-item" href="quiz.jsp?cat=Puzzles">Puzzles & Riddles</a>
          <a class="sub-item" href="quiz.jsp?cat=MixAll">General Quiz</a> <!--  Added here -->
        </div>
      </div>
    </div>
  </div>
</body>
</html>
