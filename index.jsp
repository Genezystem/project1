<%-- 
    Document   : index
    Created on : 20 oct 2024, 9:48:45 p.m.
    Author     : jensh
--%>

<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Esta referencia es para poder usar bootstrap.css -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <title>App Para Dieta</title>
        <style>
            body {
                background-image: url('images/login.jpg');
                background-size: cover; /* Para cubrir toda la pantalla */
                background-position: center; /* Centrar la imagen */
                background-repeat: no-repeat; /* No repetir la imagen */
                margin-top: 10px;
                display: flex;
                justify-content: center; /* Centra horizontalmente */
                align-items: center; /* Centra verticalmente */
                min-height: 100vh; /* Asegura que el body ocupe toda la altura de la ventana */
                margin: 0; /* Elimina el margen predeterminado del body */
                font-size: 1rem; /* Ajusta el tamaño de la fuente aquí */
            }
            
        </style>
    </head>
    <body>
          <!-- Aqui empieza la configuración de la interfaz de LOGIN -->
     <div class="container d-flex justify-content-center align-items-center vh-100">
         <div class="card p-4 shadow-lg text-bg-dark border-primary" style="width: 22rem;">
                <h3 class="text-center mb-4">Iniciar Sesion</h3>
                <!-- Aqui empieza a usarse parametros de bootstrap para la interfaz de inicio de sesion -->
                <form method="post" action="index.jsp">
                    <div class="form-group mb-3">
                        <label for="user">Ingresa tu usuario:</label>
                        <input type="text" class="form-control" id="user" name="user" placeholder="Ingresa tu usuario" >
                    </div>
                    <div class="form-group mb-3">
                        <label for="password">Constraseña:</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Ingresa tu contraseña" >
                    </div>
                <button type="submit" class="btn btn-primary w-100 mb-3" name="index">Iniciar Sesion</button>
                <button type="submit" class="btn btn-secondary w-100" formaction="registro.jsp">Registrar Usuario</button>
                
                </form>
        <%
            if (request.getParameter("index") != null) {
                String user = request.getParameter("user");
                String password = request.getParameter("password");
                HttpSession sesion = request.getSession();
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/appproject", "root", "");
                    
                    //usuario de administrador
                    if (user.equals("admin") && password.equals("admin123")) {
                    sesion.setAttribute("logueado", "1");
                    sesion.setAttribute("user", user);
                    response.sendRedirect("administrador.jsp");
                    } else {
                    // Consulta SQL para verificar el usuario y la contraseña
                    String query = "SELECT * FROM users WHERE user = ? AND password = ?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, user);
                    ps.setString(2, password);
                    rs = ps.executeQuery();

                        // Si se encuentra un resultado, el usuario es válido
                        if (rs.next()) {
                        sesion.setAttribute("logueado", "1");
                        sesion.setAttribute("user", rs.getString("user"));
                        response.sendRedirect("usuario.jsp");
                        } else {                            
                        out.print("<p class='text-danger text-center'>Usuario o contraseña no válidos</p>");
                    }
                }                    
                } catch (Exception e) {
                    out.print("Error en MySQL: " + e.getMessage());
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) {}
                    if (ps != null) try { ps.close(); } catch (SQLException e) {}
                    if (con != null) try { con.close(); } catch (SQLException e) {}
                }
            }
        %>
    </div>
    
                <!-- codigo para el formulario de registro
                <div class="modal fade" id="registerModal" tabindex="-1" aria-lebelledy="registerModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="registerModalLabel">Registrar Usuario</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form method="post" action="register.jsp">
                                    <div class="mb-3">
                                        <label for="newUser" class="form-label">Usuario:</label>
                                        <input type="text" class="form-control" id="newUser" name="newUser" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="newPassword" class="form-label">Contraseña:</label>
                                        <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Registrar</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            -->
     </body> 
</html>
