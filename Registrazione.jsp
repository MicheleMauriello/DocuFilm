<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="net.ucanaccess.jdbc.UcanaccessSQLException" %>

<html>
    <body>
        <%
            String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
			String user=null;
			String pass=null;
			Connection connection=null;
            try{
                Class.forName(DRIVER);
            }
            catch (ClassNotFoundException e) {
                out.println("Errore");
            }
            try{
				user = request.getParameter("user");
				psw = request.getParameter("pass");
                connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Vuoto.accdb");
                
                String verifica = "SELECT username from Utenti WHERE username = '"+user+"';";
                Statement s = connection.createStatement();
                ResultSet r = s.executeQuery(verifica);
                if(r.next()){
                    out.println("Username già in uso, riprovare");
                    
                }
                else{
                    String query = "INSERT INTO Utenti(username,password) VALUES('"+user+"','"+pass+"')";    
                    s.executeUpdate(query);
                    String url = "login.jsp";
                    response.sendRedirect(url);
                }              
            }
			catch(UcanaccessSQLException ex){
				out.println("Errore");
				out.println(ex);
			}
            catch(Exception e){
                out.println(e);
            }   
        %>
    </body>
</html>