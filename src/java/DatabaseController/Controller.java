/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DatabaseController;

import java.sql.*;
import Beans.UserBean;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Leader
 */
@WebServlet(name = "Controller", urlPatterns = {"/Controller"})
public class Controller extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Connection con = Database.getConnection();
        Statement stat = con.createStatement();
        ResultSet rs = null;
        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute("currentUser");
                
        try {
            String action = request.getParameter("action");
            
            if (action.equals("Logout")){           
                String sql = String.format("UPDATE user SET password = '%s' WHERE username='%s'",
                        user.getPassword(), user.getUsername());
                
                stat.executeUpdate(sql);             
                session.invalidate();
                goToPage(request, response, "index.jsp");
            }
            else if (action.equals("CreateUser")){
                CreateUser(request, stat);
                if (user == null)
                    goToPage(request, response, "index.jsp");
                else
                    goToPage(request, response, "staffMain.jsp");
            }
            else if (action.equals("DeleteUser")){
                DeleteUser(request, stat);
                goToPage(request, response, "manageUser.jsp");
            }
            else if (action.equals("CreatePoll")){
                String num = request.getParameter("num");
                int pollID = CreatePoll(request, stat, rs);
                goToPage(request, response, String.format("addChoices.jsp?num=%s&pollID=%s", num, pollID));
            }
            else if (action.equals("DeletePoll")){
                DeletePoll(request, stat);
                goToPage(request, response, "managePoll.jsp");
            }
            else if (action.equals("AddChoices")){
                AddChoices(request, stat);
                goToPage(request, response, "managePoll.jsp");
            }
            else if(action.equals("Vote")){
                Vote(request, stat, rs);
                if (user.getType().equals("staff"))
                    goToPage(request, response, "managePoll.jsp");
                else
                    goToPage(request, response, "poll.jsp");
            }
                
                
        }catch(Exception e)
        {
            out.println("<html><head><title></title><body>" + e.getMessage() + "</body></html>");
//            goToPage(request, response, "error.jsp?type=username");
        } finally {
            stat.close();
            con.close();
            out.close();
        }
    }
    
    private void CreateUser(HttpServletRequest request, Statement stat) throws SQLException{
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        String type = request.getParameter("type");
        String sql = String.format("INSERT INTO user VALUES('%s', '%s', '%s')", user, pass, type);
        stat.executeUpdate(sql);
    }
    
    private void DeleteUser(HttpServletRequest request, Statement stat) throws SQLException{
        String user = request.getParameter("user");
        String sql = String.format("DELETE FROM vote WHERE username = '%s'", user);
        
        stat.executeUpdate(sql);
        sql = String.format("DELETE FROM user WHERE username = '%s'", user);
        stat.executeUpdate(sql);
    }
    
    private int CreatePoll(HttpServletRequest request, Statement stat, ResultSet rs) throws SQLException{
        String question = request.getParameter("question");
        String type = request.getParameter("type");
        String sql = String.format("INSERT INTO poll (question, type)VALUES('%s','%s')", question, type);
        stat.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
        rs = stat.getGeneratedKeys();
        rs.first();
        return rs.getInt(1);
    }
    
    private void DeletePoll(HttpServletRequest request, Statement stat) throws SQLException{
        int pollID = Integer.parseInt(request.getParameter("ID"));
        String sql = String.format("DELETE FROM vote WHERE pollID = %d", pollID);
        
        stat.executeUpdate(sql);
        sql = String.format("DELETE FROM choice WHERE pollID = %d", pollID);
        stat.executeUpdate(sql);
        sql = String.format("DELETE FROM poll WHERE pollID = %d", pollID);
//                out.println("<html><head><title></title><body>" + sql + "</body></html>");
        stat.executeUpdate(sql);
    }
    
    private void AddChoices(HttpServletRequest request, Statement stat) throws SQLException{
        int num = Integer.parseInt(request.getParameter("num"));
        String pollID = request.getParameter("pollID");
         
        for (int i = 1; i <= num; i++ ){
            String choice = request.getParameter(String.format("%s",i));
            String sql = String.format("INSERT INTO choice VALUES('%s', '%s', '%s', default)", i, pollID, choice);
            stat.execute(sql);
        }
    }
    
    private void Vote(HttpServletRequest request, Statement stat, ResultSet rs) throws SQLException{
        int choiceID = Integer.parseInt(request.getParameter("vote"));
        String username = request.getParameter("username");
        int pollID = Integer.parseInt(request.getParameter("pollID"));
        String sql = String.format("INSERT INTO vote VALUES('%s', %d, %d)",username, pollID, choiceID);
        
        stat.executeUpdate(sql);
        
        sql = String.format("SELECT COUNT(username) FROM vote WHERE choiceID = '%d' AND pollID = %d", 
                choiceID, pollID);
        rs = stat.executeQuery(sql);
        rs.first();
        int numVotes = rs.getInt(1);
        
        sql = String.format("SELECT COUNT(username) FROM vote WHERE pollID = %d", pollID);
        rs = stat.executeQuery(sql);
        rs.first();
        int totalVotes = rs.getInt(1);
        
        sql = String.format("Update choice SET numVotes = %d WHERE pollID = %d AND choiceID = %d", 
                numVotes ,pollID, choiceID);
        stat.executeUpdate(sql);
        
        sql = String.format("Update poll SET totalVotes = %d WHERE pollID = %d", 
                totalVotes ,pollID);
        stat.executeUpdate(sql);
    }
    
    private void goToPage(HttpServletRequest request, HttpServletResponse response, String URL) throws ServletException, IOException{
        RequestDispatcher dispatcher = request.getRequestDispatcher(URL);
        
        dispatcher.forward(request, response); 
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
