<%-- 
    Document   : profile
    Created on : Apr 23, 2012, 8:49:54 AM
    Author     : Leader
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <LINK REL=STYLESHEET HREF="CSS/Style.css" TYPE="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
            function checkEmpty(){
                var pass = profile.password.value;

                if (pass == ""){
                    alert("You can not leave Password empty!");
                    login.password.focus();
                    return false; 
                }               
                return true;
            }
        </script>
        <title>Profile Page</title>
    </head>
    <body>
        <jsp:useBean id="currentUser" class="Beans.UserBean" scope="session"/>
        <jsp:setProperty name="currentUser" property="*"/>
        <div id="top">
            <img src="Images/Bar.png">                    
        </div>
        <div id="body" style="top:250px;">
            <form name="profile" onsubmit="return checkEmpty()">
                <table align="center">
                    <tr>
                        <td><b>Username</b></td>
                        <td>
                            <jsp:getProperty name="currentUser" property="username"/>
                        </td>
                    </tr>
                    <tr>
                        <td><b>Password</b></td>
                        <td><input type="password" name="password" value="<jsp:getProperty name="currentUser" property="password"/>"></td>
                    </tr>
                    <tr>
                        <td><a href="<%= currentUser.getType().equals("staff") ? "staffMain.jsp" : "main.jsp"%>"><input type="button" value="Back"></a></td>
                        <td><input type="submit" value="Update"></td>
                    </tr>
                </table>
            </form>
        </div>     
    </body>
</html>
