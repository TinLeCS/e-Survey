<%-- 
    Document   : manageStudent
    Created on : Apr 23, 2012, 9:14:30 AM
    Author     : Leader
--%>
<%@page import="java.sql.*, DatabaseController.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL=STYLESHEET HREF="CSS/Style.css" TYPE="text/css">
        <title>User Management Page</title>
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
                        <a href="newUser.jsp"><img src="Images/Add User.png" title="Add new user"></a>
                    </td>
                </tr>
            </table>
            <table width="100%">
                <tr>
                    <td width="40%">
                        <h2><img src="Images/Staff.png">Staff List</h2>
                        <br/>
                        <ul style="font-size: 20px">
                            <%
                                Connection con = Database.getConnection();
                                String sql = "SELECT username FROM user WHERE type = 'staff'";
                                Statement stat = con.createStatement();
                                ResultSet rs = stat.executeQuery(sql);
                                while(rs.next()){
                            %>
                            <li type="disc"><i><%= rs.getString(1)%></i></li><br/>
                            <%
                                }
                            %>    
                        </ul>
                    </td>            
                    <td>
                        <div style="border: solid 0 black; border-left-width:2px; padding-left:5.5ex">
                        <h2><img src="Images/Member.png">Member List</h2>
                            <table width="100%">
                                <tr>
                                    <th>Username</th>
                                    <th>Action</th>
                                </tr>
                                <%

                                    sql = "SELECT username FROM user WHERE type = 'member'";
                                    stat = con.createStatement();
                                    rs = stat.executeQuery(sql);
                                    while(rs.next()){
                                        String name = rs.getString(1);
                                %>
                                        <tr>
                                            <td><%= name%></td>
                                            <td align="center">
                                                <a href="Controller?action=DeleteUser&user=<%= name%>" 
                                                onclick="return confirm('Do you really want to delete? You cannot undelete after having deleted!');">
                                                    <img src="Images/Delete.png" title="Delete"></a>
                                            </td>
                                        </tr>
                                <%
                                    }
                                %>        
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>
