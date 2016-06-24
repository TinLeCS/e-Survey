<%-- 
    Document   : newPoll
    Created on : Apr 23, 2012, 2:09:57 PM
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
                var question = poll.question.value;

                if (question == ""){
                    alert("You can not create a poll without Question!");
                    poll.question.focus();
                    return false; 
                }
                return true;
            }
        </script>
        <title>Poll Details</title>
    </head>
    <body>
        <div id="top">
            <img src="Images/Bar.png">                    
        </div>
        <div id="body" style="top:250px;">
            <form name="poll" action="Controller?action=CreatePoll" method="post" onsubmit="return checkEmpty()">
                <table align="center">
                    <tr>
                        <td><b>Question</b></td>
                        <td><textarea name="question" cols="25" rows="5"></textarea></td>
                    </tr>
                    <tr>
                        <td>Type</td>
                        <td>
                            <input type="radio" name="type" value="member" checked>For Member 
                            <input type="radio" name="type" value="staff">For Staff
                        </td>
                    </tr>
                    <tr>
                        <td>Number of Choices</td>
                        <td><input style="width: 35px;" type="number" max="20" min="2" value="2" name="num"></td>
                    </tr>
                    <tr align="center">
                        <td><a href="managePoll.jsp"><input type="button" value="Back"></a></td>
                        <td><input type="submit" value="Create"></td>
                    </tr>
                </table>                
            </form>
        </div>
    </body>
</html>
