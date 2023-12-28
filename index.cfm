
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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bug List</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>Hello, Bug Tracker!</h1>

    <cfset userService = createObject("component", "user_management/user_management")>
    <cfset currentUser = userService.getUserById(session.loggedInUserId)>

    <p>Welcome, <CFOUTPUT>#currentUser.name# #currentUser.surname#!</CFOUTPUT></p>

    <button onclick="register()">Register New User</button>
    <button onclick="userList()">Manage Users</button>
    <button onclick="logout()">Logout</button>

    <h1>Bug List</h1>

    <!-- Include jQuery for easier DOM manipulation -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <!-- Include JavaScript for client-side sorting -->
    <script>
        $(document).ready(function () {
            // Function to sort the table by a specific column
            function sortTable(columnIndex) {
                var table, rows, switching, i, x, y, shouldSwitch;
                table = document.getElementById("bugTable");
                switching = true;
                while (switching) {
                    switching = false;
                    rows = table.rows;
                    for (i = 1; i < rows.length - 1; i++) {
                        shouldSwitch = false;
                        x = rows[i].getElementsByTagName("TD")[columnIndex];
                        y = rows[i + 1].getElementsByTagName("TD")[columnIndex];
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                    if (shouldSwitch) {
                        rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                        switching = true;
                    }
                }
            }

            // Attach click event listeners to table headers for sorting
            $("th").click(function () {
                var columnIndex = $(this).index();
                sortTable(columnIndex);
            });

            $(document).ready(function () {
                // Get today's date in the format "YYYY-MM-DD"
                var today = new Date().toISOString().split('T')[0];

                // Set the value of the date input field to today
                document.getElementById('date').value = today;

                $("#addBugButton").click(function () {
                    $("#addBugForm").toggle();
                });
            });

            // Handle form submission
            $("#addBugForm").submit(function (event) {
                event.preventDefault();

                // Collect form data
                var formData = {
                    date: $("#date").val(),
                    shortDescription: $("#shortDescription").val(),
                    longDescription: $("#longDescription").val(),
                    user_id: "<CFOUTPUT>#session.loggedInUserId#</CFOUTPUT>",
                    urgency: $("#priority").val(),
                    severity: $("#severity").val(),
                };

                // Call addBug method of BugManagement.cfc
                $.ajax({
                    url: "bug_management.cfc?method=addBug",
                    type: "POST",
                    data: { bugData: JSON.stringify(formData) },
                    success: function (response) {
                        // Optionally handle success response
                        console.log("Bug added successfully");
                        // Reload the page to update the bug list
                        location.reload();
                    },
                    error: function (error) {
                        // Optionally handle error response
                        console.error("Error adding bug:", error);
                    }
                });
            });

        });
    </script>

    <cfset bugService = createObject("component", "bug_management")>
    <cfset bugList = bugService.getBugList()>

    <table id="bugTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Date</th>
                <th>Short Description</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <cfloop query="#bugList#">
                <tr>
                    <td><CFOUTPUT>#bug_id#</CFOUTPUT></td>
                    <td><CFOUTPUT>#dateFormat(date, 'yyyy-mm-dd')#</CFOUTPUT></td>
                    <td><CFOUTPUT>#short_description#</CFOUTPUT></td>
                    <td><CFOUTPUT>#status#</CFOUTPUT></td>
                    <td>
                        <a href="editBug.cfm?bugId=#id#">Edit</a>
                        <!-- Add link to details page -->
                    </td>
                </tr>
            </cfloop>
        </tbody>
    </table>

    <!-- Button and Form for Adding New Bugs -->
    <button id="addBugButton">Add New Bug</button>

    <form id="addBugForm" style="display: none;">
        <label for="date">Date:</label>
        <input type="date" id="date" name="date" required>

        <label for="shortDescription">Short Description:</label>
        <input type="text" id="shortDescription" name="shortDescription" required>

        <label for="longDescription">Long Description:</label>
        <input type="text" id="longDescription" name="longDescription" required>

        <label for="priority">Select Priority:</label>
        <select id="priority" name="priority">
            <option value="very_urgent">Very Urgent</option>
            <option value="urgent">Urgent</option>
            <option value="non_urgent">Non Urgent</option>
            <option value="not_at_all_urgent">Not at All Urgent</option>
        </select>

        <label for="severity">Select Severity:</label>
        <select id="severity" name="severity">
            <option value="disaster">Disaster</option>
            <option value="critical">Critical</option>
            <option value="non_critical">Non Critical</option>
            <option value="request_for_change">Request for Change</option>
        </select>

        <button type="submit">Submit</button>
    </form>

</body>
</html>

