<!-- user-management.cfm -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <link rel="stylesheet" href="/bugtracker/styles.css">
</head>
<body>
    <!-- Include jQuery for easier DOM manipulation -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

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
                    <input type="hidden" name="userId" value="<CFOUTPUT>#userDetails.id#</CFOUTPUT>">
                    <label for="newLogin">Login:</label>
                    <input type="text" id="newLogin" name="newLogin" value="<CFOUTPUT>#userDetails.login#</CFOUTPUT>">
                    <label for="newUsername">Name:</label>
                    <input type="text" id="newUsername" name="newUsername" value="<CFOUTPUT>#userDetails.name#</CFOUTPUT>">
                    <label for="newUserSurname">Surname:</label>
                    <input type="text" id="newUserSurname" name="newUserSurname" value="<CFOUTPUT>#userDetails.surname#</CFOUTPUT>">
                    <label for="newPassword">Password:</label>
                    <input type="text" id="newPassword" name="newPassword" value="">
                    <button type="submit">Save</button>
                </form>
            </div>
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
    <h2 style="text-align: center">List of Users</h2>
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
                    <td>#userList.id#</td>
                    <td>#userList.login#</td>
                    <td>#userList.name#</td>
                    <td>#userList.surname#</td>
                    <td>
                        <form action="user_management.cfm" method="post" style="display:inline;">
                            <input type="hidden" name="editUser" value="#userList.id#">
                            <button type="submit" class="action-button">Edit</button>
                        </form>
                        <button class="action-button delete-button" onclick="confirmDeleteUser(#userList.id#)">Delete</button>
                    </td>
                </tr>
            </cfoutput>
        </table>
    </cfif>



    <!-- Include jQuery script for handling delete button click -->
    <script>
        function deleteUser(userId) {
            // Use AJAX to call the CFC method
            $.ajax({
                url: 'user_management.cfc',
                data: {
                    method: 'deleteUser',
                    userId,
                },
                type: 'POST',
                dataType: 'text',
                success: function(response) {
                    // reload the page
                    location.reload();
                },
                error: function(xhr, status, error) {
                    alert('Error calling CFC method');
                }
            });
        }

        function confirmDeleteUser(userId) {
            // Display a confirmation dialog
            var userConfirmed = confirm("Are you sure you want to delete this user?");

            // Check user's choice
            if (userConfirmed) {
                // User clicked "OK", proceed with the action
                deleteUser(userId);
            }
        }
    </script>
</body>
</html>

