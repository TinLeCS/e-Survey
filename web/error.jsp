<%-- 
    Document   : error
    Created on : Apr 20, 2012, 5:05:42 AM
    Author     : Leader
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
        String type = request.getParameter("type");
        if (type == null)
            out.println("<meta http-equiv=refresh content=3.5;URL=index.jsp>");
        else if (type.equals("username"))
            out.println("<meta http-equiv=refresh content=3;URL=newUser.jsp>");
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style type="text/css">
            body{
                background: url('Images/Error Background.jpg') no-repeat center top;
            }
        </style>
        <title>Error!</title>
    </head>
    <body>
        <DIV align="center" style="position: absolute; top:83px; left:670px; width:450px; height:30px">
            <p>
                <span style="font-size: 30px">
                    <font color="red" face="Arial Black, Gadget, sans-serif">
                        <%
                            if (type == null)
                                out.println("Wrong username or password. Please, try again!");
                            else if (type.equals("username"))
                                out.println("This username has existed. Please, try again!");
                        %>
                    </font>
                </span>
            </p>
        </DIV>
    </body>
</html>
