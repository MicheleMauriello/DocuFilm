<%@ page import="java.sql.Connection" %>
    <%@ page import="java.io.*" %>
        <%@ page import="java.sql.DriverManager" %>
            <%@ page import="java.sql.Statement" %>
                <%@ page import="java.sql.SQLException" %>
                   <%@ page import="java.util.*" %> 
                        <%@ page import="java.text.*" %>
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
        String data  = null;
        Statement st = null;
        ResultSet resultset;
        Connection connection=null;
        try{
            Class.forName(DRIVER);
        }
        catch (ClassNotFoundException e) {
            out.println("Errore: Impossibile caricare il Driver Ucanaccess");
        }

        try{
            connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Vuoto.accdb");
            HttpSession s = request.getSession();
            String n = (String) s.getAttribute("username"); //nome
            int id = Integer.parseInt(request.getParameter("id"));
            

            if(n!=null){
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    long miliseconds = System.currentTimeMillis();
		            Date d = new Date(miliseconds);        
		            data = dateFormat.format(d);
                  
                    String queryVerifica = "SELECT Quantita FROM DocuFilm WHERE ID="+id+" AND Quantita=0";
            
                    st = connection.createStatement();
                   
                    resultset=st.executeQuery(queryVerifica);
               

                     if(resultset.next()){

                         out.println("Il film non è più disponibile!");
                     }
                     else{
                         
                        query = "INSERT INTO Prenota (IDFilm,Username,Data) values ("+id+", '"+n+"',#"+data+"#);";
                        st.executeUpdate(query);
                        out.println("Prenotazione eseguita con successo");
                        String query2 = "SELECT Quantita FROM DocuFilm WHERE ID="+id;
                        resultset=st.executeQuery(query2);
                        int q=0; //quantità
                        
                        if(resultset.next()){
                            
                         q=Integer.parseInt(resultset.getString(1));

                        }
                        else{
                            out.println("Errore nel database!!");
                        }
                        q--;
                        query2="UPDATE DocuFilm SET Quantita="+q+" WHERE ID=" +id;
                        st.executeUpdate(query2);
                        
                      }  
                   

                }
                else{
                    out.println("<a href=\"index.html\"><input type=\"submit\" value=\"Non ti sei ancora loggato\" /> <br></a>");
                }
            }
            catch (Exception er) {
                System.out.println(er);
            }    
    %>
</body>
</html>

        