<%-- 
    Document   : addChoice
    Created on : Apr 23, 2012, 2:10:08 PM
    Author     : Leader
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL=STYLESHEET HREF="CSS/Style.css" TYPE="text/css">
        <title>Add Detail's Choices</title>
    </head>
    <body>
        <%
            int num = Integer.parseInt(request.getParameter("num"));
        %>
        <div id="top">
            <img src="Images/Bar.png">                    
        </div>
        <div id="body" style="top:250px;">
            <form action="Controller?action=AddChoices&num=<%= num%>" method="post">
                <table>
                    <h2>Please, enter choice descriptions for your poll!</h2>
                    <tr>
                        <th>No</th>
                        <th>Choice Description</th>
                    </tr>
                    <%
                        for (int i = 1; i <= num; i++){
                    %>
                            <tr>
                                <td align="center" width="5%"><%= i%></td>
                                <td><input type="text" name="<%=i%>" size="100" required></td>
                            </tr>
                    <%
                    }
                    %>
                    <tr>
                        <td></td>
                        <td align="center"><input type="submit" value="Submit"></td>
                    </tr>
                    <input type="hidden" name="pollID" value="<%= request.getParameter("pollID")%>">
                </table>           
            </form>
        </div>
    </body>
</html>
