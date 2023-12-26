<!-- process_registration.cfm -->

<cfparam name="form.login" default="">
<cfparam name="form.name" default="">
<cfparam name="form.surname" default="">
<cfparam name="form.password" default="">

<cfquery name="insertUser" datasource="CFBugTracker">
    INSERT INTO user_account (login, name, surname, password)
    VALUES (
        <cfqueryparam value="#form.login#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#form.name#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#form.surname#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#form.password#" cfsqltype="cf_sql_varchar">
    )
</cfquery>

<script>
    function main() {
        window.location.href = "index.cfm";
    }
</script>


<h2>Registration Successful</h2>
<p>Thank you for registering, <CFOUTPUT>#form.name#</CFOUTPUT>!</p>
<button onclick="main()">Go to main page</button>

