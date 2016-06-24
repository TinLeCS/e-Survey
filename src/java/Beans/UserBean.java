/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

/**
 *
 * @author Leader
 */
public class UserBean {
    private String username;
    private String password;
    private String type;
    
    public void setUsername(String username){
        this.username = username;
    }
    public String getUsername(){
        return username;
    }
    
    public void setPassword(String password){
        this.password = password;
    }
    public String getPassword(){
        return password;
    }
    
    public void setType(String type){
        this.type = type;
    }
    public String getType(){
        return type;
    }
}
