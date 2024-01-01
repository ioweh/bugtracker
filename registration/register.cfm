
<cfset menu = createObject("component", "bugtracker.menu")>

<html>
<head>
    <title>User Registration</title>
    <link rel="stylesheet" href="/bugtracker/styles.css">
    <style>
        .container {
            height: 450px;
        }
    </style>
</head>
<body>
    <CFOUTPUT>#menu.renderMenu()#</CFOUTPUT>
    <div class="container">
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
        
            <button type="submit">Register</button>
        </form>
    </div>
</body>
</html>

