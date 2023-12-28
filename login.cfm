
<cfif isDefined("form.loginButton")>
    <!-- Check login credentials -->
    <cfset login = form.login>
    <cfset password = form.password>

    <cfset userService = createObject("component", "user_management/user_management")>
    <cfset currentUser = userService.getUserIdByCredentials(login, password)>

    <!-- Perform authentication logic (replace this with your authentication logic) -->
    <cfif currentUser.recordCount>
        <!-- Store user information in session upon successful login -->
        <cfset session.loggedInUserId = currentUser.user_id>
        <!-- Redirect to a secured page (e.g., index.cfm) -->
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
        <label for="login">Login:</label>
        <input type="text" name="login" required><br>
        
        <label for="password">Password:</label>
        <input type="password" name="password" required><br>
        
        <input type="submit" name="loginButton" value="Login">
    </form>
</body>
</html>

