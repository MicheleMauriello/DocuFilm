<!DOCTYPE HTML>
<%@ page import="java.sql.Connection" %>
    <%@ page import="java.io.*" %>
        <%@ page import="java.sql.DriverManager" %>
            <%@ page import="java.sql.Statement" %>
                <%@ page import="java.sql.SQLException" %>
                    <%@ page import="java.sql.ResultSet" %>
                        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Login</title>
  </head>
  <body>
  <h1>Login:</h1>
    <form action="login" method="post">
      <input type="text" name="username" placeholder="username"><br>
      <input type="text" name="password" placeholder="password"><br>
      <input type="submit" value="Login">
    </form>
    <%
    try {
                                        Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                                    } catch (ClassNotFoundException e) {
                                        System.out.println("Errore: Impossibile caricare il Driver Ucanaccess1");
                                    }
                                    try {
                                        Connection connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Vuoto.accdb");
                                        String us=request.getParameter("username");
                                        String pas=request.getParameter("password");
                                        String query= "SELECT Nome FROM Utenti WHERE Username= '" + us + "' AND Password= '"+ pas +"';";
                                        Statement statement=connection.createStatement();
                                        ResultSet resultset=statement.executeQuery(query);
                                        String n=null;
                                        while(resultset.next())
                                        {
                                            n=resultset.getString(1);
                                               
                                        }
                                        if(n==null)
                                        {
                                             response.getOutputStream().println("Utente o Password sbagliati");
                                        }
                                        else
                                        {
                                             response.sendRedirect("acquista.html");
                                        }
                                    }
                                    catch (Exception er) {
                                        System.out.println(er);
                                    }
    %>
  </body>
</html>