<%@ page import="java.sql.Connection" %>
    <%@ page import="java.io.*" %>
        <%@ page import="java.sql.DriverManager" %>
            <%@ page import="java.sql.Statement" %>
                <%@ page import="java.sql.SQLException" %>
                    <%@ page import="java.sql.ResultSet" %>
                        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
                            <%@ page import="java.sql.Date" %>



<html>

  <head>
    <title>Prenota</title>
  </head>

  <body>

   <%
        String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
        
       
        
        String query = null;
        Statement st;
        ResultSet resultset;
        Connection connection=null;
        try{
            Class.forName(DRIVER);
        }
        catch (ClassNotFoundException e) {
            out.println("Errore: Impossibile caricare il Driver Ucanaccess");
        }
        try{
            HttpSession s = request.getSession();
            n = (String) s.getAttribute("username");
            String id = request.getParameter("id");

            if(n!=null){
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    long miliseconds = System.currentTimeMillis();
		            Date d = new Date(miliseconds);        
		            data = dateFormat.format(d);
                   
                    
                    
                
                        query1 = "INSERT INTO Prenota (IDFilm,Username,Data) values ('"+id+"', '"+n+"',#"+data+"#);";
                        st.executeUpdate(query1);
                        response.getOutputStream().println("Prenotazione eseguita con successo");
                        
                    }
                   
                
                }
                else{
                    response.getOutputStream().println("<a href=\"index.html\"><input type=\"submit\" value=\"Non ti sei ancora loggato\" /> <br></a>");
                }
            }
            catch (Exception er) {
                System.out.println(er);
            }    
    %>
</body>
</html>

        