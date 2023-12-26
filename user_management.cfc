<!-- user_management.cfc -->

<cfcomponent>

    <!-- Function to list all users -->
    <cffunction name="listUsers" access="public" returntype="query">
        <cfquery name="userList" datasource="CFBugTracker">
            SELECT user_id, login, name, surname, password
            FROM user_account
            ORDER BY login;
        </cfquery>
        <cfreturn userList>
    </cffunction>

    <!-- Function to get user details by user_id -->
    <cffunction name="getUserById" access="public" returntype="query">
        <cfargument name="userId" type="numeric" required="true">
        <cfquery name="userDetails" datasource="CFBugTracker">
            SELECT user_id, login, name, surname, password
            FROM user_account
            WHERE user_id = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn userDetails>
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
                    <cfset hashedPassword = hash(newPassword, "SHA-256")>
                    ,password = <cfqueryparam value="#hashedPassword#" cfsqltype="cf_sql_varchar">
                </cfif>
            WHERE user_id = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
        </cfquery>
    </cffunction>

    <!-- Function to delete user by user_id -->
    <cffunction name="deleteUser" access="public" returntype="void">
        <cfargument name="userId" type="numeric" required="true">
        
        <cfquery datasource="CFBugTracker">
            DELETE FROM user_account
            WHERE user_id = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
        </cfquery>
    </cffunction>

    <!-- Function to add a new user -->
    <cffunction name="addUser" access="public" returntype="void">
        <cfargument name="newLogin" type="string" required="true">
        <cfargument name="newPassword" type="string" required="true">

        <!-- In a production environment, hash the password before storing it in the database -->
        <cfset hashedPassword = hash(newPassword, "SHA-256")>

        <cfquery datasource="your_datasource">
            INSERT INTO user_account (login, password)
            VALUES (
                <cfqueryparam value="#newUsername#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#hashedPassword#" cfsqltype="cf_sql_varchar">
            )
        </cfquery>
    </cffunction>

</cfcomponent>

