<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>
        <body>
            <h1>Sign-up Cliente</h1>
                <form action="Registrazione.jsp" method="POST">
                     Nome: <input type="text" id="nome" name="nome" placeholder="nome" required> Cognome: <input type="text" id="cognome" name="cognome" placeholder="cognome" required>

        <br> <br> Username: <input type="text" id="username" name="username" placeholder="username" required> Password: <input type="password" id="password" name="password" placeholder="password" required>

        <input type="submit" id="btn" name="btn" value="Registrazione">
    </form>

    <a href="index.html">
        <input type="button" value="Indietro" /> <br>
    </a>
</body>


        <%
        String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
        
        String username=null;
        String password=null;
        String nome = null;
        String cognome = null;
        
        Connection connection=null;
        try{
            Class.forName(DRIVER);
        }
        catch (ClassNotFoundException e) {
            out.println("Errore: Impossibile caricare il Driver Ucanaccess");
        }
        try{
            
            nome = request.getParameter("nome");
            cognome = request.getParameter("cognome");
            username = request.getParameter("username");
            password = request.getParameter("password");
            
            connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Vuoto.accdb");
            String verifica = "SELECT Username from Utenti WHERE Username = '"+username+"';";
            Statement st = connection.createStatement();          
            ResultSet result = st.executeQuery(verifica);
            if(result.next()){
                out.println("<p>Questo account è già esistente</p>");
            }else{
                String query = "INSERT INTO Utenti (Username, Password, Nome, Cognome) values ('"+username+"', '"+password+"', '"+nome+"', '"+cognome+"');";
                st.executeUpdate(query);
                response.sendRedirect("index.html");
            }
            
        }
        catch(Exception e){
            out.println(e);
        }
        finally{
            if(connection != null){
                try{
                    connection.close();
                }
                catch(Exception e){out.println("Errore");}
            }
        }
        %>
    
        </body>
    </html>