<?php
interface IUserRepository{
public function GetPassword($userName);
public function SetPassword($userName, $password);
public function GetUsers($userName, $students, $administrators);
public function UpdateUser($userName, $isStudent, $isAdministrator);
public function CreateUser($userName, $isStudent, $isAdministrator);
public function DeleteUser($userName);
public function GetUser($userName);
public function CreateSession($userName, $sessionId);
public function GetCurrentSession($userName);
public function InvalidateSessions($userName);
}

class UserRepository implements IUserRepository{
    public function __concstruct(){
        //putenv("ORACLE_HOME=/home/oracle/OraHome1");
        //putenv("ORACLE_SID=orcl");
    }

    public function GetPassword($userName) {
        $sql = "select Password from myUser where UserName = :userName";
        $connection = $this->GenerateConnection();
        $parameters = array(':userName' => $userName);
        
        $query = $this->GenerateQuery($connection, $sql, $parameters);
        $result = $this->ExecuteQuery($query);
        
        if($result["flag"]){
            $password = oci_fetch_row($result["cursor"]);

            return $password[0];
        }
        
        die("Password retrieval failed");
    }
    
    public function UpdateUser($userName, $isStudent, $isAdministrator){
        $sql = "update myUser"
            ." set isStudent = :isStudent, isAdministrator = :isAdministrator"
            ." where username = :userName";
        $connection = $this->GenerateConnection();
        $parameters = array(':userName' => $userName, 
                            ':isStudent' => $isStudent,
                            ':isAdministrator' => $isAdministrator);
        
        $query = $this->GenerateQuery($connection, $sql, $parameters);
        $result = $this->ExecuteQuery($query);
        
        if(!$result["flag"]){
            die("User Update Failed");
        }
    }
    
    public function CreateUser($userName, $isStudent, $isAdministrator){
        $sql = "insert into myUser"
            ." values(:userName, 'password', :isStudent, :isAdministrator)";
        $connection = $this->GenerateConnection();
        $parameters = array(':userName' => $userName, 
                            ':isStudent' => $isStudent,
                            ':isAdministrator' => $isAdministrator);
        
        $query = $this->GenerateQuery($connection, $sql, $parameters);
        $result = $this->ExecuteQuery($query);
        
        if(!$result["flag"]){
            die("User Create Failed");
        }
    }
    
    public function DeleteUser($userName){
        $sql = "delete from myUser"
            ." where username = :userName";
        $connection = $this->GenerateConnection();
        $parameters = array(':userName' => $userName);
        
        $query = $this->GenerateQuery($connection, $sql, $parameters);
        $result = $this->ExecuteQuery($query);
        
        if(!$result["flag"]){
            die("User Create Failed");
        }
    }
    
    public function GetUser($userName) {
        $sql = "select IsStudent, IsAdministrator from myUser where UserName = :userName";
        $connection = $this->GenerateConnection();
        $parameters = array(':userName' => $userName);
        
        $query = $this->GenerateQuery($connection, $sql, $parameters);
        $result = $this->ExecuteQuery($query);
        
        if($result["flag"]){
            $user = oci_fetch_row($result["cursor"]);

            return $user;
        }
        
        die("User retrieval failed");
    }
    
    public function GetAllUsers(){
        $sql = "select UserName, case when IsStudent = 1 then 'true' else 'false' end as IsStudent, case when IsAdministrator = 1 then 'true' else 'false' end as IsAdministrator from myUser";
        $connection = $this->GenerateConnection();
        
        $query = $this->GenerateQuery($connection, $sql, null);
        $result = $this->ExecuteQuery($query);
        
        if($result["flag"]){
            $users = null;
            oci_fetch_all($result["cursor"], $users, 0, -1, OCI_FETCHSTATEMENT_BY_ROW + OCI_ASSOC);

            return $users;
        }
        
        die("User retrieval failed");
    }
    
    public function GetUsers($userName, $students, $administrators){
        $sql = "select UserName, case when IsStudent = 1 then 'true' else 'false' end as IsStudent, case when IsAdministrator = 1 then 'true' else 'false' end as IsAdministrator from myUser"
                ." where UserName = case when :userName is not null and :userName != '' then :userName else UserName end"
                ." and IsStudent = case when :isStudent is null then IsStudent else 1 end"//case when :isStudent = 1 then :isStudent else IsStudent end)"
                ." and IsAdministrator = case when :isAdministrator is null then IsAdministrator else 1 end"//case when :isAdministrator is not null and :isAdministrator = 1 then :isAdministrator else IsAdministrator end"
                ;
        $connection = $this->GenerateConnection();
        $parameters = array(':userName' => $userName
                            , ':isStudent' => $students
                            , ':isAdministrator' => $administrators
                            );
        
        $query = $this->GenerateQuery($connection, $sql, $parameters);
        $result = $this->ExecuteQuery($query);
        
        if($result["flag"]){
            $users = null;
            oci_fetch_all($result["cursor"], $users, 0, -1, OCI_FETCHSTATEMENT_BY_ROW + OCI_ASSOC);

            return $users;
        }
        
        die("User retrieval failed");
    }

    public function SetPassword($userName, $password) {
        $sql = "update myUser set Password = :password where UserName = :userName";
        $connection = $this->GenerateConnection();
        $parameters = array(':userName' => $userName, ':password' => $password);
        
        $query = $this->GenerateQuery($connection, $sql, $parameters);
        $result = $this->ExecuteQuery($query);
        
        if(!$result["flag"]){
            die("Password Set Failed");
        }
    }
    
    public function CreateSession($userName, $sessionId){
        $sql = "insert into mySession values(:sessionId,:userName,sysdate, 1)";
        $connection = $this->GenerateConnection();
        $parameters = array(':userName' => $userName
                            , ':sessionId' => $sessionId);
        
        $query = $this->GenerateQuery($connection, $sql, $parameters);
        $result = $this->ExecuteQuery($query);
        
        if(!$result["flag"]){
            die("Session Creation Failed");
        }
    }
    
    public function GetCurrentSession($userName){
        $sql = "select SessionId"
            ." from mySession"
            ." where UserName = :userName"
            ."      and SessionValid = 1"
            ."      and SessionDate >= (select max(SessionDate) from mySession where UserName = :userName and SessionValid = 1)"
            ." order by SessionDate desc";
        
        $connection = $this->GenerateConnection();
        $parameters = array(':userName' => $userName);
        
        $query = $this->GenerateQuery($connection, $sql, $parameters);
        $result = $this->ExecuteQuery($query);
        
        if($result["flag"]){
            $sessionId = oci_fetch_row($result["cursor"]);

            return $sessionId[0];
        }
        
        die("Session Retrieval Failed");
    }
    
    public function InvalidateSessions($userName){
        $sql = "update mySession"
            ." set SessionValid = 0"
            ." where UserName = :userName";
        
        $connection = $this->GenerateConnection();
        $parameters = array(':userName' => $userName);
        
        $query = $this->GenerateQuery($connection, $sql, $parameters);
        $result = $this->ExecuteQuery($query);
        
        if(!$result["flag"]){
            die("Session Creation Failed");
        }
    }
    
    private function GenerateConnection(){
        $connection = oci_connect("gq011", "hodzos", "gqian:1521/orcl");
        
        if($connection == false){
            die("Database connection failed.");
        }
        
        return $connection;
    }
    
    private function GenerateQuery($connection, $sql, $parameters){
        $cursor = oci_parse($connection, $sql);

        if($parameters != null){
            foreach ($parameters as $k => $v) {
                oci_bind_by_name($cursor, $k, $parameters[$k]);
            }
        }
        
        return $cursor;
    }
    
    private function ExecuteQuery($cursor){
        if($cursor == false){
            die("Cursor error");
        }
        
        $queryResult = oci_execute($cursor);
        
        $result["flag"] = $queryResult;
        $result["cursor"] = $cursor;
        
//        oci_free_statement($cursor);
        
        return $result;
    }
}
?>
