<%-- 
    Document   : vote
    Created on : Apr 23, 2012, 10:13:31 AM
    Author     : Leader
--%>
<%@page import="java.sql.*, DatabaseController.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <LINK REL=STYLESHEET HREF="CSS/Style.css" TYPE="text/css">
        <jsp:useBean id="currentUser" class="Beans.UserBean" scope="session"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
            Connection con = Database.getConnection();
            Statement stat = con.createStatement();
            String ID = request.getParameter("ID");
            String sql = String.format("SELECT question, answer, numVotes, totalVotes FROM "
                    + "poll NATURAL JOIN choice WHERE pollID ='%s'",
                    ID);
            ResultSet rs = stat.executeQuery(sql);
            rs.first();
            String question = rs.getString(1);
            rs.beforeFirst();
         %>       
        <title><%= question%></title>
    </head>
    <body>
        <div id="top">
            <img src="Images/Bar.png">                    
        </div>
        <div id="body">
            <a href="<%= currentUser.getType().equals("staff") ? "managePoll.jsp" : "poll.jsp"%>">
                <img src="Images/Back.png" title="Back"></a>
            <table align="center" width="70%">
                <tr>
                    <td colspan="2" align="center"><h2><%= question%></h2></td>
                </tr>
                <tr>
                    <th width="65%">Answer</th>
                    <th colspan="2" style="text-indent: 5em;">Number of Votes</th>
                </tr>
                <%
                    while(rs.next()){
                        int numVotes = rs.getInt(3);
                %>
                        <tr>
                            <td><%= rs.getString(2)%></td>
                            <td align="center"><meter max="<%= rs.getInt(4)%>" value="<%= numVotes%>" high="<%= rs.getInt(4)/2%>"></meter>
                            </td>
                            <td align="left">
                                <%= numVotes%>
                            </td>
                        </tr>
                <%
                }
                %>
            </table>
        </div>   
    </body>
</html>
