
<cfif isDefined("form.loginButton")>
    <!-- Check login credentials (this is a basic example, implement your own logic) -->
    <cfset username = form.username>
    <cfset password = form.password>
    
    <cfdump var="#session#"></cfdump>
    <!-- Perform authentication logic (replace this with your authentication logic) -->
    <cfif username eq "your_username" and password eq "your_password">
        <!-- Store user information in session upon successful login -->
        <cfset session.loggedInUser = username>
        <!-- Redirect to a secured page (e.g., home.cfm) -->
        <cflocation url="index.cfm" addtoken="false">
    <cfelse>
        <p>Invalid username or password. Please try again.</p>
    </cfif>
</cfif>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>
    <form method="post" action="#cgi.script_name#">
        <label for="username">Username:</label>
        <input type="text" name="username" required><br>
        
        <label for="password">Password:</label>
        <input type="password" name="password" required><br>
        
        <input type="submit" name="loginButton" value="Login">
    </form>
</body>
</html>

