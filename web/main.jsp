<%-- 
    Document   : main
    Created on : Apr 22, 2012, 9:35:41 PM
    Author     : Leader
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL=STYLESHEET HREF="CSS/Main.css" TYPE="text/css">
        <jsp:useBean id="currentUser" class="Beans.UserBean" scope="session"/>
        <title>Member Page</title>
    </head>
    <body>
        <div id="top">
            <img src="Images/Bar.png">                    
        </div>
        <div class="icon" style="position: absolute; left:300px;">
                <a href="profile.jsp"><img src="Images/Profile.png" title="Profile"></a>
        </div>
        <div class="icon" style="left:625px;">
                <a href="poll.jsp"><img src="Images/Poll.png" title="Poll List"></a>
        </div>
        <div class="icon" style="left:950px;">
                <a href="Controller?action=Logout"><img src="Images/Logout.png" title="Logout"></a> 
        </div>
        <div align="center" id="body">
            <h1>Welcome, Member <jsp:getProperty name="currentUser" property="username"/>!</h1>
        </div>   
    </body>
</html>
