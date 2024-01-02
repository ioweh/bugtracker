<!-- process_registration.cfm -->

<cfparam name="form.login" default="">
<cfparam name="form.name" default="">
<cfparam name="form.surname" default="">
<cfparam name="form.password" default="">

<cfset userManagement = createObject("component", "bugtracker.user_management.user_management")>
<cfset userManagement.addUser(form.login, form.name, form.surname, form.password)>

<cfset menu = createObject("component", "bugtracker.menu")>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration successful</title>
    <link rel="stylesheet" href="/bugtracker/styles.css">
</head>
<body>
    <CFOUTPUT>#menu.renderMenu()#</CFOUTPUT>

    <h2 style="text-align: center">Registration Successful</h2>
    <p style="text-align: center">Thank you for registering, <CFOUTPUT>#form.name#</CFOUTPUT>!</p>
</body>
</html>

