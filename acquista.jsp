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

table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid red;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: red;
}
</style>
</head>
<body>

<h2>Lista di film da noleggiare:</h2>

<form action="acquista.jsp" method="POST">
                   Cerca per titolo del film: <input type="text" id="cerca" name="cerca" placeholder="Nome film" required>

       

        <input type="submit" id="btn" name="btn" value="Cerca">
    </form>
 
        <%@ page import="java.io.*" %>
        <%@ page import="java.sql.*" %>
        <%
            
            try {
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            } catch (ClassNotFoundException e) {
                System.out.println("Errore: Impossibile caricare il Driver Ucanaccess1");
            }
            try {
                
                String cerca = request.getParameter("cerca");


                
                Connection connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Vuoto.accdb");
                HttpSession s = request.getSession(); // attivo la sessione
                String nome = (String) s.getAttribute("username"); //viene richiesto il valore dell'attributo di sessione (username)
                String query;
                Statement statement;
                ResultSet resultset;
                String id=null;
                
                if(nome!=null){ //controlla se ti sei loggato
                        if(cerca==null){ //serve a controllare che l'utente non stia effettuando la ricerca
                           
                           query= "SELECT * FROM DocuFilm;"; //seleziona tutti i film
                        }
                        else{

                          query = "SELECT * FROM DocuFilm WHERE Film LIKE '%"+cerca+"%';"; //seleziona il film con un determinato titolo


                        }
                           statement=connection.createStatement();
                           resultset=statement.executeQuery(query);
                      
                        out.println("<table>");
                        out.println("<tr>");
                        out.println("<th>ID</th>");
                        out.println("<th>Film</th>");
                        out.println("<th>Anno</th>");
                        out.println("<th>Prezzi</th>");
                        out.println("<th>Quantit&agrave;</th>");
                        out.println("<th>Noleggio</th></tr>");
                        while(resultset.next()){
                            id=resultset.getString(1); //viene utilizzato per controllare che ci siano dei risultati
                            out.println("<tr><td>"+resultset.getString(1)+"</td>");
                            out.println("<td>"+resultset.getString(2)+"</td>");
                            out.println("<td>"+resultset.getString(4)+"</td>");
                            out.println("<td>"+resultset.getString(5)+" &euro;</td>");
                            out.println("<td>"+resultset.getString(3)+"</td>"); 
                            out.println("<td><a href='prenota.jsp?id="+resultset.getString(1)+"'><input type=\"submit\" value=\"Noleggia\"></a></td></tr>");
                                          
                            }
                            out.println("</table><br>");
                            if(cerca!=null){

                                 out.println("<a href='acquista.jsp'><input type='submit' value='Visualizza i film' /> <br></a>");
                              

                            }
                        if(id==null){ // se non trova nessun risultato stampa nessun dvd disponibile
                            out.println("Nessun dvd disponibile");
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
    <a href="logout.jsp"><input type="submit" value="Logout" /> <br></a>
    <a href="MostraPrenota.jsp"><input type="submit" value="Mostra Noleggi" /> <br></a>
    </body>
</html>