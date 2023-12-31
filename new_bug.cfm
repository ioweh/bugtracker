<!-- new_bug.cfm -->

<cfset menu = createObject("component", "menu")>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Bug</title>
    <style>

        .container {
            width: 500px;
            height: 600px;
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

        input,
        textarea,
        select {
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

    <CFOUTPUT>#menu.renderMenu()#</CFOUTPUT>

    <div class="container">
        <h2>Add New Bug</h2>
        <form id="addBugForm" method="post">
            <label for="date">Date:</label>
            <input type="date" id="date" name="date" required>

            <label for="shortDescription">Short Description:</label>
            <input type="text" id="shortDescription" name="shortDescription" required>

            <label for="longDescription">Long Description:</label>
            <textarea id="longDescription" name="longDescription" rows="4" required></textarea>

            <label for="priority">Priority:</label>
            <select id="priority" name="priority" required>
                <option value="very_urgent">Very Urgent</option>
                <option value="urgent">Urgent</option>
                <option value="non_urgent">Non Urgent</option>
                <option value="not_at_all_urgent">Not at All Urgent</option>
            </select>

            <label for="severity">Severity:</label>
            <select id="severity" name="severity" required>
                <option value="disaster">Disaster</option>
                <option value="critical">Critical</option>
                <option value="non_critical">Non Critical</option>
                <option value="request_for_change">Request for Change</option>
            </select>

            <button type="submit">Submit</button>
        </form>
    </div>

    <!-- Include jQuery for easier DOM manipulation -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        $(document).ready(function () {
            // Get today's date in the format "YYYY-MM-DD"
            var today = new Date().toISOString().split('T')[0];

            // Set the value of the date input field to today
            document.getElementById('date').value = today;

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
                        location.href = "/bugtracker/index.cfm";
                    },
                    error: function (error) {
                        // Optionally handle error response
                        console.error("Error adding bug:", error);
                    }
                });
            });
       });
    </script>
</body>
</html>

