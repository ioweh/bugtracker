
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

<cfparam name="url.logout" default="">
<cfset loginMessage = "Logging in">

<cfif len(url.logout)>
    <cfset structClear(session)>
    <cfset loginMessage = "Logged out. Log in again.">
</cfif>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
        <style>

        .container {
            width: 500px;
            height: 300px;
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

        input {
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

