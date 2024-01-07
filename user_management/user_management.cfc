<!-- user_management.cfc -->

<cfcomponent>

    <!-- Function to list all users -->
    <cffunction name="listUsers" access="public" returntype="query">
        <cfset var userList = "">
        <cfquery name="userList" datasource="CFBugTracker">
            SELECT id, login, name, surname, password
            FROM user_account
            ORDER BY login;
        </cfquery>
        <cfreturn userList>
    </cffunction>

    <!-- Function to get user details by id -->
    <cffunction name="getUserById" access="public" returntype="query">
        <cfargument name="userId" type="numeric" required="true">
        <cfset var userDetails = "">
        <cfquery name="userDetails" datasource="CFBugTracker">
            SELECT id, login, name, surname, password
            FROM user_account
            WHERE id = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn userDetails>
    </cffunction>

    <!-- Function to get user id by login and password -->
    <cffunction name="getUserIdByCredentials" access="public" returntype="query">
        <cfargument name="login" type="string" required="true">
        <cfargument name="password" type="string" required="true">
        <cfset var hashedPassword=hash(password, "SHA-256")>
        <cfset var getUser = "">
        <cfquery name="getUser" datasource="CFBugTracker">
            SELECT id
            FROM user_account
            WHERE login = <cfqueryparam value="#login#" cfsqltype="cf_sql_varchar">
            AND password = <cfqueryparam value="#hashedPassword#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn getUser>
    </cffunction>

    <!-- Function to update user details -->
    <cffunction name="updateUser" access="public" returntype="void">
        <cfargument name="userId" type="numeric" required="true">
        <cfargument name="newLogin" type="string" required="true">
        <cfargument name="newUsername" type="string" required="true">
        <cfargument name="newUserSurname" type="string" required="true">
        <cfargument name="newPassword" type="string" required="true">

        <cfquery datasource="CFBugTracker">
            UPDATE user_account
            SET login = <cfqueryparam value="#arguments.newLogin#" cfsqltype="cf_sql_varchar">,
                name = <cfqueryparam value="#arguments.newUsername#" cfsqltype="cf_sql_varchar">,
                surname = <cfqueryparam value="#arguments.newUserSurname#" cfsqltype="cf_sql_varchar">
                <cfif len(arguments.newPassword) neq 0>
                    <cfset var hashedPassword = hash(newPassword, "SHA-256")>
                    ,password = <cfqueryparam value="#hashedPassword#" cfsqltype="cf_sql_varchar">
                </cfif>
            WHERE id = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
        </cfquery>
    </cffunction>

    <!-- Function to delete user by id -->
    <cffunction name="deleteUser" access="public" returntype="void">
        <cfargument name="userId" type="numeric" required="true">
        
        <cfquery datasource="CFBugTracker">
            DELETE FROM user_account
            WHERE id = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
        </cfquery>
    </cffunction>

    <!-- Function to add a new user -->
    <cffunction name="addUser" access="public" returntype="numeric">
        <cfargument name="newLogin" type="string" required="true">
        <cfargument name="newName" type="string" required="true">
        <cfargument name="newSurname" type="string" required="true">
        <cfargument name="newPassword" type="string" required="true">

        <!-- In a production environment, hash the password before storing it in the database -->
        <cfset var hashedPassword = hash(newPassword, "SHA-256")>

        <cfset var insertResult = "">

        <cfquery name="insertResult" datasource="CFBugTracker">
            INSERT INTO user_account (login, name, surname, password)
            VALUES (
                <cfqueryparam value="#newLogin#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#newName#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#newSurname#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#hashedPassword#" cfsqltype="cf_sql_varchar">
            )
            RETURNING id;
        </cfquery>

        <!-- Retrieve the generated ID from the result object -->
        <cfset var userId = insertResult.id[1]>

        <!-- Return the generated ID -->
        <cfreturn userId>
    </cffunction>

</cfcomponent>

