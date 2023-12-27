<!-- process_registration.cfm -->

<cfparam name="form.login" default="">
<cfparam name="form.name" default="">
<cfparam name="form.surname" default="">
<cfparam name="form.password" default="">

<cfset userManagement = createObject("component", "user_management")>

<cfset userManagement.addUser(form.login, form.name, form.surname, form.password)>

<script>
    function main() {
        window.location.href = "index.cfm";
    }
</script>


<h2>Registration Successful</h2>
<p>Thank you for registering, <CFOUTPUT>#form.name#</CFOUTPUT>!</p>
<button onclick="main()">Go to main page</button>

