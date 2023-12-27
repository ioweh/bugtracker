
<script>
    function register() {
        window.location.href = "registration/register.cfm";
    }
    function userList() {
        window.location.href = "user_management/user_management.cfm";
    }
    function logout() {
        window.location.href = "logout.cfm";
    }
</script>

<!DOCTYPE html>
<html>
<head>
    <title>Bug Tracker Page</title>
</head>
<body>
    <h1>Hello, Bug Tracker!</h1>
    <p>Welcome, <CFOUTPUT>#session.loggedInUser#!</CFOUTPUT></p>

    <button onclick="register()">Register New User</button>
    <button onclick="userList()">Manage Users</button>
    <button onclick="logout()">Logout</button>
</body>
</html>

