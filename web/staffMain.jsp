<%-- 
    Document   : admin
    Created on : Apr 22, 2012, 9:35:17 PM
    Author     : Leader
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <LINK REL=STYLESHEET HREF="CSS/Main.css" TYPE="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:useBean id="currentUser" class="Beans.UserBean" scope="session"/>
        <title>Staff Page</title>
    </head>
    <body>
        <div id="top">
            <img src="Images/Bar.png">                    
        </div>
        <div class="icon" style="left:300px;">
                <a href="profile.jsp"><img src="Images/Profile.png" title="Profile"></a>
        </div>
        <div class="icon" style="left:525px;">
            <a href="manageUser.jsp"><img src="Images/User Management.png" title="User Management"></a>
        </div>
        <div class="icon" style="left:750px;">
            <a href="managePoll.jsp"><img src="Images/Poll.png" title="Poll Management"></a>
        </div>
        <div class="icon" style="left:950px;">
            <a href="Controller?action=Logout"><img src="Images/Logout.png" title="Logout"></a>
        </div>
        <div align="center" id="body">           
            <h1>Welcome, Staff <jsp:getProperty name="currentUser" property="username"/>!</h1>
        </div>   
    </body>
</html>
