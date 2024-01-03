
<cfset menu = createObject("component", "bugtracker.menu")>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <link rel="stylesheet" href="/bugtracker/styles.css">
</head>
<body>
    <CFOUTPUT>#menu.renderMenu()#</CFOUTPUT>
    <div class="container">
        <h2>User Registration</h2>
        <form action="process_registration.cfm" method="post">
            <label for="login">Login:</label>
            <input type="text" id="login" name="login" required autocomplete="off"><br>

            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required autocomplete="off"><br>

            <label for="surname">Surname:</label>
            <input type="text" id="surname" name="surname" required autocomplete="off"><br>
        
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required autocomplete="off"><br>
        
            <button type="submit">Register</button>
        </form>
    </div>
</body>
</html>

