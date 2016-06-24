<%-- 
    Document   : managePoll
    Created on : Apr 23, 2012, 9:30:29 AM
    Author     : Leader
--%>
<%@page import="java.sql.*, DatabaseController.Database, Beans.UserBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <LINK REL=STYLESHEET HREF="CSS/Style.css" TYPE="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Poll Management Page</title>
    </head>
    <body>
        <div id="top">
            <img src="Images/Bar.png">                    
        </div>
        <div id="body">
            <table align="center" width="100%">
                <tr>
                    <td>
                        <a href="staffMain.jsp"><img src="Images/Back.png" title="Back"></a>
                    </td>
                    <td align="right">
                        <a href="newPoll.jsp"><img src="Images/Create Poll.png" title="Create new poll"></a>
                    </td>
                </tr>
            </table>    
            <table align="center" width="60%">
                <tr>
                    <td colspan="2"><h2>Already-voted Poll List</h2></td>
                </tr> 
                <tr>
                    <th>Question</th>
                    <th>Total Votes</th>
                    <th>Action</th>
                </tr>
                <%
                    Connection con = Database.getConnection();
                    Statement stat = con.createStatement();
                    UserBean currentUser = (UserBean)session.getAttribute("currentUser");
                    String username = currentUser.getUsername();
                    String sql = String.format("SELECT pollID, question, totalVotes FROM poll NATURAL JOIN vote WHERE username ='%s'",
                            username);
                    ResultSet rs = stat.executeQuery(sql);
                    while(rs.next()){
                        String ID = rs.getString(1);
                %>
                        <tr>
                            <td><a href="view.jsp?ID=<%= ID%>"><b><%= rs.getString(2)%></b></a></td>
                            <td align="center"><%=rs.getInt(3)%></td>
                            <td align="center">
                                <a href="Controller?action=DeletePoll&ID=<%= ID%>" onclick="return confirm('Do you really want to delete? You cannot undelete after having deleted!');">
                                    <img src="Images/Delete.png" title="Delete"></a>
                            </td>
                        </tr>

                <%
                    }
                %>
                <tr>
                    <td colspan="3"><br/><hr/></td>
                </tr>
                <tr>
                    <td colspan="2"><h2>Poll List</h2></td>
                </tr> 
                <tr>
                    <th>Question</th>
                    <th align="right" colspan="2">Action</th>
                </tr>
                <%
                    sql = String.format("SELECT pollID, question FROM poll where pollID NOT IN (SELECT pollID FROM poll NATURAL JOIN vote WHERE username ='%s')",
                            username);
                    rs = stat.executeQuery(sql);
                    while(rs.next()){
                        String ID = rs.getString(1);
                %>
                        <tr>
                            <td><a href="vote.jsp?ID=<%= ID%>"><b><%= rs.getString(2)%></b></a></td>
                            <td align="right" colspan="2">
                                <a href="Controller?action=DeletePoll&ID=<%= ID%>" onclick="return confirm('Do you really want to delete? You cannot undelete after having deleted!');">
                                    <img src="Images/Delete.png" title="Delete"></a>
                                </a>
                            </td>
                        </tr>
                <%
                    }
                %>
            </table>
        </div>
    </body>
</html>
