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
            HttpSession s = request.getSession(); //viene attivata la sessione
            String n = (String) s.getAttribute("username"); //viene richiesto il valore dell'attributo di sessione (username)
            int id = Integer.parseInt(request.getParameter("id")); // id del film che si vuole noleggiare
            

            if(n!=null){
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    long miliseconds = System.currentTimeMillis();
		            Date d = new Date(miliseconds);        
		            data = dateFormat.format(d);
                  
                    String queryVerifica = "SELECT ID FROM DocuFilm WHERE ID="+id+" AND Quantita=0"; //seleziono ID del film se la quantità è 0
            
                    st = connection.createStatement();
                   
                    resultset=st.executeQuery(queryVerifica);
               

                     if(resultset.next()){

                         out.println("Il film non è più disponibile!");
                     }
                     else{
                         
                        query = "INSERT INTO Prenota (IDFilm,Username,Data) values ("+id+", '"+n+"',#"+data+"#);";
                        st.executeUpdate(query);
                        out.println("Noleggio eseguito con successo");
                        String query2 = "SELECT Quantita FROM DocuFilm WHERE ID="+id; //seleziono la quantità del film per poter decrementarne il valore 
                        resultset=st.executeQuery(query2);
                        int q=0; //quantità
                        
                        if(resultset.next()){
                            
                         q=Integer.parseInt(resultset.getString(1));

                        }
                        else{
                            out.println("Errore nel database!!");
                        }
                        q--;
                        query2="UPDATE DocuFilm SET Quantita="+q+" WHERE ID=" +id;// questa query serve ad aggiornare la quantità del dvd
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
    <a href="acquista.jsp"><input type="submit" value="Torna indietro" /> <br></a>
</body>
</html>

        