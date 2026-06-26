import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class QuizServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        response.setContentType("text/html");

        String category = request.getParameter("category");
        String username = (String) request.getSession().getAttribute("username");
        int score = Integer.parseInt(request.getParameter("score"));
        int total = Integer.parseInt(request.getParameter("total"));

        try {
            // DB connection
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = System.getenv("DB_URL");
            String user = System.getenv("DB_USER");
            String pass = System.getenv("DB_PASS");

            Connection con = DriverManager.getConnection(url, user, pass);

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO leaderboard(username, category, score) VALUES (?,?,?)"
            );
            ps.setString(1, username != null ? username : "Guest");
            ps.setString(2, category);
            ps.setInt(3, score);
            ps.executeUpdate();

            con.close();

            response.sendRedirect("result.jsp?score=" + score + "&total=" + total + "&cat=" + category);

        } catch (Exception e) {
            e.printStackTrace();
            PrintWriter out = response.getWriter();
            out.println("<h3 style='color:red'>Error: " + e.getMessage() + "</h3>");
        }
    }
}