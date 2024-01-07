// Application.cfc

component {

    this.name = "MyCFApp";
    this.applicationTimeout = createTimeSpan(0, 0, 10, 0);
    this.sessionManagement = true;

    // onRequestStart method is called on every request
    function onRequestStart() {

        // Check if the user is not logged in and the requested page is not the login page
        if (!structKeyExists(session, "loggedInUserId") && !listLast(arguments.1, "/") is "login.cfm") {
            // Redirect to the login page
            location(url="/bugtracker/login.cfm", addtoken="false");
            // Abort further processing
            cfabort;
        }
    }

}

