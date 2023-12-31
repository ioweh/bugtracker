<!-- menu.cfc -->

<script>
    function register() {
        window.location.href = "registration/register.cfm";
    }
    function userList() {
        window.location.href = "user_management/user_management.cfm";
    }
    function logout() {
        window.location.href = "logout.cfm";
    }
</script>

<cfcomponent>
    <cfset userService = createObject("component", "user_management/user_management")>
    <cfset currentUser = userService.getUserById(session.loggedInUserId)>

    <cffunction name="renderMenu" output="true">

        <div class="menu">
            <div class="left-section">
                <button class="menu-button" onclick="changeLocation('registration/register')">Register New User</button>
                <button class="menu-button" onclick="changeLocation('user_management/user_management')">Manage Users</button>
                <button class="menu-button" onclick="changeLocation('logout')">Logout</button>
            </div>
            <div class="right-section">
                <div class="welcome-message">Welcome, <CFOUTPUT>#currentUser.name# #currentUser.surname#!</CFOUTPUT></div>
            </div>
        </div>
        <script>
            function changeLocation(page) {
                window.location.href = page + '.cfm';
            }
        </script>
    </cffunction>
</cfcomponent>

