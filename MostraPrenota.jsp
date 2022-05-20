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

<h2>Lista dei film noleggiati:</h2>


 
        <%@ page import="java.io.*" %>
        <%@ page import="java.sql.*" %>
        <%
            
            try {
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            } catch (ClassNotFoundException e) {
                System.out.println("Errore: Impossibile caricare il Driver Ucanaccess1");
            }
            try {
                Connection connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Vuoto.accdb");
                HttpSession s = request.getSession();
                String nome = (String) s.getAttribute("username");
                String query= "SELECT * FROM Prenota WHERE Username='"+nome+"';";
                Statement statement=connection.createStatement();
                ResultSet resultset=statement.executeQuery(query);
                String id=null;
                
                if(nome!=null){
                   
                    out.println("<table>");
                    out.println("<tr>");
                    out.println("<th>IDFilm</th>");
                    out.println("<th>Username</th>");
                    out.println("<th>Data</th>");
                    out.println("<th>Annulla</th></tr>");
                    while(resultset.next()){
                        id=resultset.getString(1);
                        out.println("<td>"+resultset.getString(3)+"</td>");
                        out.println("<td>"+resultset.getString(1)+"</td>");
                        out.println("<td>"+resultset.getString(2).substring(0,10)+"</td>"); 
                        out.println("<td><a href='Annulla.jsp?id="+resultset.getString(1)+"'><input type=\"submit\" value=\"Annulla\"></a></td></tr>");
                                       
                        }
                        out.println("</table><br>");
                    if(id==null){
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
    <a href="MostraPrenota.jsp"><input type="submit" value="Mostra Prenotazioni" /> <br></a>
    </body>
</html>