<%-- 
    Document   : index
    Created on : Mar 28, 2012, 5:43:25 AM
    Author     : Leader
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL=STYLESHEET HREF="CSS/Login.css" TYPE="text/css">
        <title>Login Page</title>
    </head>
    <script type="text/javascript">
        function checkEmpty(){
            var user = login.user.value;
            var pass = login.pass.value;
            
            if (user == ""){
                alert("You can not login without Username!");
                login.user.focus();
                return false; 
            }
            else if (pass == ""){
                alert("You can not login without Password!");
                login.pass.focus();
                return false; 
            }
            return true;
        }
    </script>
    <body align="center">
        <div id="body">
            <h1>Please, enter username and password to login!</h1>
            <hr/>
            <form action="LoginCheck" method="post" name="login" onsubmit="return checkEmpty()">
                <br/>
                <br/>
                <table align="center">
                    <tr>
                        <td>Username
                        <td><input type="text" name="user">                            
                    </tr>
                    <tr>
                        <td>Password
                        <td><input type="password" name="pass">  
                    </tr>
                    <tr>
                        <td><input type="submit" value="Login">
                        <td><a href="newUser.jsp"><input type="button" value="Register"></a>
                    </tr>
                </table>
            </form>
        </div>            
    </body>
</html>
