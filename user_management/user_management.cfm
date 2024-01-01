<!-- user-management.cfm -->

<!DOCTYPE html>
<html>
<head>
    <title>User Management</title>
    <style>
        .container {
            width: 500px;
            height: 450px;
            margin: 20px;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 8px;
        }

        .container input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>

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
            <div class="container">
                <h2>Edit User</h2>
                <form action="user_management.cfm" method="post">
                    <input type="hidden" name="userId" value="<CFOUTPUT>#userDetails.user_id#</CFOUTPUT>">
                    <label for="newLogin">Login:</label>
                    <input type="text" name="newLogin" value="<CFOUTPUT>#userDetails.login#</CFOUTPUT>">
                    <label for="newUsername">Name:</label>
                    <input type="text" name="newUsername" value="<CFOUTPUT>#userDetails.name#</CFOUTPUT>">
                    <label for="newUserSurname">Surname:</label>
                    <input type="text" name="newUserSurname" value="<CFOUTPUT>#userDetails.surname#</CFOUTPUT>">
                    <label for="newPassword">Password:</label>
                    <input type="text" name="newPassword" value="">
                    <button type="submit">Save</button>
                </form>
            </div>
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

</body>
</html>

