
<cfset loginMessage = "Logging in">

<cfparam name="url.logout" default="">

<cfif len(url.logout)>
    <cfset structClear(session)>
    <cfset loginMessage = "Logged out. Log in again.">
</cfif>

<cfif isDefined("form.loginButton")>
    <!-- Check login credentials -->
    <cfset login = form.login>
    <cfset password = form.password>

    <cfset userService = createObject("component", "user_management/user_management")>
    <cfset currentUser = userService.getUserIdByCredentials(login, password)>

    <!-- Perform authentication logic (replace this with your authentication logic) -->
    <cfif currentUser.recordCount>
        <!-- Store user information in session upon successful login -->
        <cfset session.loggedInUserId = currentUser.id>
        <!-- Redirect to a secured page (e.g., index.cfm) -->
        <cflocation url="index.cfm" addtoken="false">
    <cfelse>
        <cfset loginMessage = "Invalid username or password.">
    </cfif>
</cfif>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
        <link rel="stylesheet" href="/bugtracker/styles.css">
        <style>
            .container {
                height: 300px;
            }
    </style>
</head>
<body>
    <div class="container">
        <h2><CFOUTPUT>#loginMessage#</CFOUTPUT></h2>
        <form method="post" action="#cgi.script_name#">
            <label for="login">Login:</label>
            <input type="text" name="login" required><br>
        
            <label for="password">Password:</label>
            <input type="password" name="password" required><br>
        
            <button type="submit" name="loginButton">Login</button>
        </form>
    </div>
</body>
</html>

