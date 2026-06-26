<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String category = request.getParameter("cat");
    if(category == null) category = "General";

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        System.getenv("DBUR"),
        System.getenv("DBUSER"),
        System.getenv("DBPAS")
    );   

    String sql;
    PreparedStatement ps;

    
    if("MixAll".equalsIgnoreCase(category)) {
        category = "General Quiz"; 
        sql = "SELECT * FROM questions ORDER BY RAND() LIMIT 10";
        ps = con.prepareStatement(sql);

   
    } else if("NEET".equalsIgnoreCase(category)) {
        sql = "SELECT * FROM questions WHERE category IN ('Physics','Chemistry','Biology') ORDER BY RAND() LIMIT 10";
        ps = con.prepareStatement(sql);

   
    } else if("JEE".equalsIgnoreCase(category)) {
        sql = "SELECT * FROM questions WHERE category IN ('Physics','Chemistry','Mathematics') ORDER BY RAND() LIMIT 10";
        ps = con.prepareStatement(sql);

   
    } else {
        sql = "SELECT * FROM questions WHERE category=? ORDER BY RAND() LIMIT 10";
        ps = con.prepareStatement(sql);
        ps.setString(1, category);
    }

    ResultSet rs = ps.executeQuery();

    StringBuilder qjson = new StringBuilder("[");
    while(rs.next()){
        qjson.append("{");
        qjson.append("\"q\":\"").append(rs.getString("question")).append("\",");
        qjson.append("\"opts\":[\"").append(rs.getString("option1")).append("\",\"")
             .append(rs.getString("option2")).append("\",\"")
             .append(rs.getString("option3")).append("\",\"")
             .append(rs.getString("option4")).append("\"],");
        qjson.append("\"ans\":\"").append(rs.getString("answer")).append("\",");
        qjson.append("\"img\":\"").append(rs.getString("image_path") == null ? "" : rs.getString("image_path")).append("\"");
        qjson.append("},");
    }
    if(qjson.charAt(qjson.length()-1) == ',')
        qjson.deleteCharAt(qjson.length()-1);
    qjson.append("]");
    con.close();
%>

<!doctype html>
<html>
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  <title>BrainBattle — Quiz</title>
  <style>
    body{
      background:url("images/bg.png") no-repeat center center fixed;
      background-size:cover;
      font-family:"Segoe UI",Arial,sans-serif;
      color:#fff;
    }
    .quiz-box{
      max-width:700px;margin:40px auto;padding:30px;
      background:rgba(0,0,0,0.65);
      border-radius:12px;
      box-shadow:0 8px 30px rgba(0,0,0,0.6);
    }
    .quiz-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:20px}
    .timer{font-size:18px;font-weight:600;color:#ffd47a}
    .question{font-size:20px;font-weight:600;margin-bottom:12px}
    .option {
      display:block;
      margin:10px 0;
      padding:10px;
      background:rgba(255,255,255,0.1);
      border-radius:8px;
      cursor:pointer;
      font-size:18px;
      font-weight:600;
      color:#ffffff !important;
    }
    .option input {
      margin-right:10px;
      transform:scale(1.2);
      accent-color:orange;
    }
    .btns{display:flex;justify-content:space-between;margin-top:20px}
    .btns button{
      padding:10px 18px;border:none;border-radius:10px;cursor:pointer;
      font-size:15px;font-weight:600;color:#fff;
      background:linear-gradient(90deg,#ff6600,#ff9900);
    }
    img.qimg {
      margin-top:10px;
      border:2px solid #fff;
      border-radius:8px;
      max-width:250px;
      max-height:200px;
    }
  </style>
</head>
<body>
  <div class="quiz-box">
    <div class="quiz-header">
      <h2>BrainBattle Quiz — <%= category %></h2>
      <div class="timer">Time Left: <span id="time">5:00</span></div>
    </div>

    <div class="question" id="question"></div>
    <div id="options"></div>

    <div class="btns">
      <button onclick="nextQuestion()">Next</button>
      <button onclick="submitQuiz()">Submit</button>
    </div>
  </div>

  <form id="quizForm" method="post" action="QuizServlet" style="display:none;">
    <input type="hidden" name="category" value="<%= category %>">
    <input type="hidden" name="score" id="scoreInput">
    <input type="hidden" name="total" id="totalInput">
  </form>

  <script>
    const questions = <%= qjson.toString() %>;
    let current = 0;
    let score = 0;

    function loadQuestion(){
      let q = questions[current];
      let htmlQ = "Q" + (current+1) + ". " + q.q;
      if(q.img && q.img.trim() !== ""){
        htmlQ += '<br><img src="' + q.img + '" class="qimg">';
      }
      document.getElementById("question").innerHTML = htmlQ;

      let html = "";
      q.opts.forEach(opt=>{
        html += '<label class="option"><input type="radio" name="answer" value="'+opt+'"> '+opt+'</label>';
      });
      document.getElementById("options").innerHTML = html;
    }

    function nextQuestion(){
      let selected = document.querySelector("input[name='answer']:checked");
      if(selected && selected.value === questions[current].ans){ score++; }
      current++;
      if(current < questions.length){
        loadQuestion();
      } else {
        submitQuiz();
      }
    }

    function submitQuiz(){
      let selected = document.querySelector("input[name='answer']:checked");
      if(selected && selected.value === questions[current].ans){ score++; }

      document.getElementById("scoreInput").value = score;
      document.getElementById("totalInput").value = questions.length;
      document.getElementById("quizForm").submit();
    }

    let timeLeft = 300;
    const timerEl = document.getElementById('time');

    function updateTimer() {
      let minutes = Math.floor(timeLeft / 60);
      let seconds = timeLeft % 60;
      timerEl.textContent = minutes + ":" + (seconds < 10 ? "0" : "") + seconds;
    }

    updateTimer();
    const interval = setInterval(() => {
      timeLeft--;
      updateTimer();
      if(timeLeft <= 0){
        clearInterval(interval);
        submitQuiz();
      }
    }, 1000);

    window.onload = loadQuestion;
  </script>
</body>
</html>