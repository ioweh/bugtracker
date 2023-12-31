<!-- user-management.cfm -->

<cfset menu = createObject("component", "bugtracker.menu")>

<CFOUTPUT>#menu.renderMenu()#</CFOUTPUT>

<cfset userManagement = createObject("component", "user_management")>

<!-- Check if a form is submitted for editing -->
<cfif structKeyExists(form, "editUser")>
    <!-- Get user details for editing -->
    <cfset userIdToEdit = form.editUser>
    <cfset userDetails = userManagement.getUserById(userIdToEdit)>

    <!-- Check if the user details are found -->
    <cfif userDetails.recordCount>
        <!-- Display the edit form -->
        <h2>Edit User</h2>
        <form action="user_management.cfm" method="post">
            <input type="hidden" name="userId" value="<CFOUTPUT>#userDetails.user_id#</CFOUTPUT>">
            Login: <input type="text" name="newLogin" value="<CFOUTPUT>#userDetails.login#</CFOUTPUT>">
            Name: <input type="text" name="newUsername" value="<CFOUTPUT>#userDetails.name#</CFOUTPUT>">
            Surname: <input type="text" name="newUserSurname" value="<CFOUTPUT>#userDetails.surname#</CFOUTPUT>">
            Password: <input type="text" name="newPassword" value="">
            <input type="submit" value="Save">
        </form>
        <hr>
    </cfif>
</cfif>

<!-- Check if a form is submitted for updating -->
<cfif structKeyExists(form, "userId") AND structKeyExists(form, "newUsername")>
    <!-- Update user details -->
    <cfset userIdToUpdate = form.userId>
    <cfset newLogin = form.newLogin>
    <cfset newUsername = form.newUsername>
    <cfset newUserSurname = form.newUserSurname>
    <cfset newPassword = form.newPassword>
    <cfset userManagement.updateUser(userIdToUpdate, newLogin, newUsername, newUserSurname, newPassword)>
</cfif>

<!-- Check if a form is submitted for deletion -->
<cfif structKeyExists(form, "deleteUser")>
    <!-- Delete user -->
    <cfset userIdToDelete = form.deleteUser>
    <cfset userManagement.deleteUser(userIdToDelete)>
</cfif>

<!-- Display the list of users -->
<h2>List of Users</h2>
<cfset userList = userManagement.listUsers()>
<cfif userList.recordCount>
    <table border="1">
        <tr>
            <th>User ID</th>
            <th>User Login</th>
            <th>User Name</th>
            <th>User Surname</th>
            <th>Action</th>
        </tr>
        <cfoutput query="userList">
            <tr>
                <td>#userList.user_id#</td>
                <td>#userList.login#</td>
                <td>#userList.name#</td>
                <td>#userList.surname#</td>
                <td>
                    <form action="user_management.cfm" method="post" style="display:inline;">
                        <input type="hidden" name="editUser" value="#userList.user_id#">
                        <input type="submit" value="Edit">
                    </form>
                    <form action="user_management.cfm" method="post" style="display:inline;">
                        <input type="hidden" name="deleteUser" value="#userList.user_id#">
                        <input type="submit" value="Delete">
                    </form>
                </td>
            </tr>
        </cfoutput>
    </table>
</cfif>

