
<script>
    function logout() {
        window.location.href = "logout.cfm";
    }
</script>

<!DOCTYPE html>
<html>
<head>
    <title>My ColdFusion Page</title>
</head>
<body>
    <h1>Hello, ColdFusion!</h1>
    <p>Welcome, <CFOUTPUT>#session.loggedInUser#!</CFOUTPUT></p>

    <button onclick="logout()">Logout</button>
</body>
</html>

