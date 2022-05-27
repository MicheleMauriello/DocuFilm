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

    <style>
    body {
  background-color: lightblue;
}

h1 {
  color: red;
  text-align: center;
}

p {
  font-family: verdana;
  font-size: 20px;
}
img {
  border-radius: 8px;
}

ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: #333;
}

li {
    float: left;
}

li a {
    display: block;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

li a:hover {
    background-color: #111;
}
</style>
  </head>

  <body>
   <%
        String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
        
       
      
        String query = null;
        Statement st = null;
        ResultSet resultset;
        ResultSet resultset2;
        Connection connection=null;
        try{
            Class.forName(DRIVER);
        }
        catch (ClassNotFoundException e) {
            out.println("Errore: Impossibile caricare il Driver Ucanaccess");
        }

        try{
            connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Vuoto.accdb");
            HttpSession s = request.getSession(); //attivo la sessione
            String n = (String) s.getAttribute("username"); //viene richiesto il valore dell'attributo di sessione (username)
            int id = Integer.parseInt(request.getParameter("id")); //viene richiesto l'id del film
            

            if(n!=null){
                    String queryVerifica = "SELECT ID FROM Prenota WHERE ID="+id+";"; //controlla l'esistenza del noleggio
            
                    st = connection.createStatement();
                   
                    resultset=st.executeQuery(queryVerifica);
               

                     if(resultset.next()){
                        
                        String queryparz = "SELECT IDFilm FROM Prenota WHERE ID="+id+" AND Username='"+n+"';"; //query parziale che seleziona id del film
                        resultset2=st.executeQuery(queryparz);
                        String IDFilm=null;
                        
                        if(resultset2.next()){ 
                            
                            IDFilm=resultset2.getString(1);

                        }
                        else{
                            out.println("Errore nel database!!");
                        }


                        String query2 = "SELECT Quantita FROM DocuFilm WHERE ID = "+IDFilm+" ;";
                        resultset2=st.executeQuery(query2);
                        int q=0; //quantità
                        
                        if(resultset2.next()){
                            
                            q=Integer.parseInt(resultset2.getString(1));
                            q++;
                            query2="UPDATE DocuFilm SET Quantita="+q+" WHERE ID = "+IDFilm+" ;";// aggiorna la quantità
                            st.executeUpdate(query2);

                        }
                        else{
                            out.println("Errore nel database!!");
                        }

                        query = "DELETE FROM Prenota WHERE ID="+id+" AND Username='"+n+"';"; // cancella il noleggio
                        st.executeUpdate(query);
                        out.println("Restituzione eseguita con successo");
                        
                     }
                     else{
                        out.println("Errore: il noleggio non è più presente nel database ");
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
    <a href="MostraPrenota.jsp"><input type="submit" value="Mostra Noleggi" /> <br></a>
</body>
</html>