<%-- 
    Document   : view
    Created on : Apr 23, 2012, 10:13:25 AM
    Author     : Leader
--%>
<%@page import="java.sql.*, DatabaseController.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <LINK REL=STYLESHEET HREF="CSS/Style.css" TYPE="text/css">
        <jsp:useBean id="currentUser" class="Beans.UserBean" scope="session"/>
        <script type="text/javascript">
            function checkNull(){
                for (var i = 0; i < document.submitVote.vote.length; i++)
                    if (document.submitVote.vote[i].checked)
                        return true;
                alert("Please, choose your choice!")
                return false;
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
            Connection con = Database.getConnection();
            Statement stat = con.createStatement();
            String ID = request.getParameter("ID");
            String sql = String.format("SELECT question, answer, choiceID FROM poll NATURAL JOIN choice WHERE pollID ='%s'",
                    ID);
            ResultSet rs = stat.executeQuery(sql);
            rs.first();
            String question = rs.getString(1);
            rs.beforeFirst();
         %>     
        <title>Vote for <%= question%></title>
    </head>
    <body>
        <div id="top">
            <img src="Images/Bar.png">                    
        </div>
        <div id="body">
            <a href="<%= currentUser.getType().equals("staff") ? "managePoll.jsp" : "poll.jsp"%>">
                <img src="Images/Back.png" title="Back"></a>
            <form name="submitVote" action="Controller?action=Vote" method="post" onsubmit="return checkNull()">
                <input type="hidden" name="pollID" value="<%= ID%>">
                <input type="hidden" name="username" value="<%= currentUser.getUsername()%>">
                <table align="center" width="70%">
                    <tr>
                        <td colspan="2" align="center"><h2><%= question%></h2></td>
                    </tr>
                    <tr>
                        <th width="80%">Answer</th>
                        <th>Select</th>
                    </tr>
                    <%
                        while(rs.next()){
                    %>
                            <tr>
                                <td><%= rs.getString(2)%></td>
                                <td align="center"><input type="radio" name="vote" value="<%= rs.getInt(3)%>"></td>
                            </tr>
                    <%
                        }
                    %>
                    <tr>
                        <td colspan="2" align="center"><input type="submit" value="Vote" onclick="return confirm('Is it really your choice?');">
                        </td>
                    </tr>
                </table>
            </form>
        </div>   
    </body>
</html>
