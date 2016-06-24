<%-- 
    Document   : newUser
    Created on : Apr 23, 2012, 2:09:37 PM
    Author     : Leader
--%>
<%@page import="Beans.UserBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <LINK REL=STYLESHEET HREF="CSS/Style.css" TYPE="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
            function checkEmpty(){
                var user = register.user.value;
                var pass = register.pass.value;

                if (user == ""){
                    alert("You can not register a new account without Username!");
                    register.user.focus();
                    return false; 
                }
                else if (pass == ""){
                    alert("You can not register a new account without Password!");
                    register.pass.focus();
                    return false; 
                }
                return true;
            }
        </script>
        <title>User Information</title>
    </head>
    <body>
        <div id="top">
            <img src="Images/Bar.png">                    
        </div>
        <div id="body" style="top:250px;">
            <form action="Controller?action=CreateUser" method="post" name="register" onsubmit="return checkEmpty()">
                <table align="center">
                    <tr>
                        <td><b>Username</b></td>
                        <td><input type="text" name="user"></td>
                    </tr>
                    <tr>
                        <td><b>Password</b></td>
                        <td><input type="password" name="pass"></td>
                    </tr>
                    <% UserBean currentUser = (UserBean)session.getAttribute("currentUser");%>
                    <%
                        if (currentUser != null){
                    %>
                    <tr>
                        <td><b>Type<b/></td>
                        <td align="center">
                            <input type="radio" name="type" value="member" checked>
                            <img src="Images/Member Small.png" title="Member">
                            <input type="radio" name="type" value="staff">
                            <img src="Images/Staff Small.png" title="Staff">
                        </td>
                    </tr>
                    <%
                        }
                        else{
                    %>
                            <input type="hidden" name="type" value="member">
                    <%
                        }
                    %>        
                    <tr align="center">
                        <td><a href="<%= (currentUser != null) ? "staffMain.jsp" : "index.jsp"%>"><input type="button" value="Back"></a></td>
                        <td><input type="submit" value="Create"></td>
                    </tr>
                </table>
            </form>
        </div>
    </body>
</html>
