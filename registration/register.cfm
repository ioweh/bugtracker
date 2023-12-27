
<html>
<head>
    <title>User Registration</title>
</head>
<body>
    <h2>User Registration</h2>
    <form action="process_registration.cfm" method="post">
        <label for="username">Login:</label>
        <input type="text" name="login" required><br>

        <label for="username">Name:</label>
        <input type="text" name="name" required><br>

        <label for="username">Surname:</label>
        <input type="text" name="surname" required><br>
        
        <label for="password">Password:</label>
        <input type="password" name="password" required><br>
        
        <input type="submit" value="Register">
    </form>
</body>
</html>

