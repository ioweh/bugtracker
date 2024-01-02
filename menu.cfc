<!-- menu.cfc -->

<cfcomponent>
    <cfset userService = createObject("component", "/bugtracker/user_management/user_management")>
    <cfset currentUser = userService.getUserById(session.loggedInUserId)>

    <cffunction name="renderMenu" output="true">

        <div class="menu">
            <div class="left-section">
                <button class="menu-button" onclick="changeLocation('/bugtracker/new_bug')">New Bug</button>
                <button class="menu-button" onclick="changeLocation('/bugtracker/index')">Bug List</button>
                <button class="menu-button" onclick="changeLocation('/bugtracker/registration/register')">Register New User</button>
                <button class="menu-button" onclick="changeLocation('/bugtracker/user_management/user_management')">Manage Users</button>
                <button class="menu-button" onclick="logout('/bugtracker/login')">Logout</button>
            </div>
            <div class="right-section">
                <div class="welcome-message">Welcome, <CFOUTPUT>#currentUser.name# #currentUser.surname#!</CFOUTPUT></div>
            </div>
        </div>
        <script>
            function changeLocation(page) {
                window.location.href = page + '.cfm';
            }
            function logout(page) {
                window.location.href = page + '.cfm?logout=true';
            }
        </script>
        <style>
            .menu {
                display: flex;
                justify-content: space-between;
                background-color: ##333;
                padding: 10px;
                align-items: center;
            }

            .left-section {
                display: flex;
            }

            .menu-button {
                background-color: ##4CAF50;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin-right: 5px;
                font-size: 16px;
            }

            .right-section {
                text-align: right;
            }

            .welcome-message {
                color: white;
                font-size: 16px;
            }

            @media only screen and (hover: none) and (orientation: portrait), (pointer: coarse) or (pointer: none) {
                .menu {
                    flex-direction: column-reverse;
                    align-items: stretch;
                }
                .left-section {
                    flex-direction: column;
                }
                .right-section {
                    text-align: center;
                }
                .menu-button {
                    margin: 0.3rem;
                }
}
        </style>
    </cffunction>
</cfcomponent>

