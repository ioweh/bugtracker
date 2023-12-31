<!-- EditBug.cfm -->
<cfset menu = createObject("component", "menu")>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Bug</title>
    <link rel="stylesheet" href="/bugtracker/styles.css">
</head>
<body>

    <CFOUTPUT>#menu.renderMenu()#</CFOUTPUT>

    <!-- Assuming you have a URL parameter for the bug ID, e.g., editBug.cfm?bugId=123 -->
    <cfparam name="url.bugId" type="numeric">

    <cfset bugService = createObject("component", "bug_management")>

    <cfset bugDetails = bugService.getBugDetails("#url.bugId#")>
    <cfset editMessage = "Edit Bug (current status is #bugDetails.status#)">

    <!-- Check if the form is submitted -->
    <cfif structKeyExists(form, "submit")>
        <cfset trimmedComment = len(trim(form.comments))>

        <cfif len(trim(form.comments)) NEQ 0>
            <cfparam name="form.bugId" type="numeric">
            <cfparam name="form.status" type="string">
            <cfparam name="form.previousStatus" type="string">
            <cfparam name="form.comments" type="string">
            <cfparam name="form.userId" type="numeric">
            <cfparam name="form.shortDescription" type="string">
            <cfparam name="form.longDescription" type="string">
            <cfparam name="form.priority" type="string">
            <cfparam name="form.severity" type="string">
            <cfset bugId = (isNumeric(form.bugId) ? int(form.bugId) : 0)>
            <cfset userId = (isNumeric(form.userId) ? int(form.userId) : 0)>

            <!-- Call the BugService.cfc to update the bug -->
            <cfset bugService.updateBug(bugId, form.status, form.previousStatus, form.comments, userId, shortDescription, longDescription, priority, severity)>

            <cfset bugDetails = bugService.getBugDetails("#url.bugId#")>
            <cfset editMessage = "Edit Bug (current status is #bugDetails.status#)">
        <cfelse>
            <cfset editMessage = "Please fill the comment field">
        </cfif>

    </cfif>

    <!-- Check if the bug exists -->
    <cfif bugDetails.recordCount EQ 0>
        <h2 style="text-align: center">Bug not found.</h2>
    <cfelse>
    
        <div class="container">
        <h2><CFOUTPUT>#editMessage#</CFOUTPUT></h2>
        <!-- Bug edit form -->
            <form action="" method="post">
                <input type="hidden" name="bugId" value="<CFOUTPUT>#bugDetails.id#</CFOUTPUT>">
                <input type="hidden" name="previousStatus" value="<CFOUTPUT>#bugDetails.status#</CFOUTPUT>">

                <!-- Status field -->
                <label for="status">Status:</label>
                <cfswitch expression="#bugDetails.status#">
                    <cfcase value="new">
                        <select id="status" name="status">
                            <option value="open">Open</option>
                        </select>
                    </cfcase>
                    <cfcase value="open">
                        <select id="status" name="status">
                            <option value="solved">Solved</option>
                        </select>
                    </cfcase>
                    <cfcase value="solved">
                        <select id="status" name="status">
                            <option value="open">Open</option>
                            <option value="checked">Checked</option>
                        </select>
                    </cfcase>
                    <cfcase value="checked">
                        <select id="status" name="status">
                            <option value="open">Open</option>
                            <option value="closed">Closed</option>
                        </select>
                    </cfcase>
                    <cfcase value="closed">
                        Closed
                    </cfcase>
                    <cfdefaultcase>
                        <!-- Default dropdown with all possible values -->
                        <select id="status" name="status">
                            <option value="new">New</option>
                            <option value="open">Open</option>
                            <option value="solved">Solved</option>
                            <option value="checked">Checked</option>
                        </select>
                    </cfdefaultcase>
                </cfswitch>

                <!-- Comment field -->
                <label for="comments">Comments:</label>
                <textarea id="comments" name="comments" rows="4" cols="50" required></textarea>

                <label for="shortDescription">Short Description:</label>
                <input type="text" id="shortDescription" name="shortDescription" value="<CFOUTPUT>#bugDetails.short_description#</CFOUTPUT>" required autocomplete="off">

                <label for="longDescription">Long Description:</label>
                <textarea id="longDescription" name="longDescription" rows="4" required><CFOUTPUT>#bugDetails.long_description#</CFOUTPUT></textarea>

                <label for="priority">Priority:</label>
                <select id="priority" id="priority" name="priority" required>
                    <option value="very_urgent" <cfif "very_urgent" EQ bugDetails.urgency>selected</cfif>>Very Urgent</option>
                    <option value="urgent" <cfif "urgent" EQ bugDetails.urgency>selected</cfif>>Urgent</option>
                    <option value="non_urgent" <cfif "non_urgent" EQ bugDetails.urgency>selected</cfif>>Non Urgent</option>
                    <option value="not_at_all_urgent" <cfif "not_at_all_urgent" EQ bugDetails.urgency>selected</cfif>>Not at All Urgent</option>
                </select>

                <label for="severity">Severity:</label>
                <select id="severity" name="severity" required>
                    <option value="blocker" <cfif "blocker" EQ bugDetails.severity>selected</cfif>>Blocker</option>
                    <option value="critical" <cfif "critical" EQ bugDetails.severity>selected</cfif>>Critical</option>
                    <option value="non_critical" <cfif "non_critical" EQ bugDetails.severity>selected</cfif>>Non Critical</option>
                    <option value="request_for_change" <cfif "request_for_change" EQ bugDetails.severity>selected</cfif>>Request for Change</option>
                </select>


                <!-- List of users from user_account table -->
                <label for="userId">Assign to User:</label>
                <select id="userId" name="userId">
                    <!-- Fetch user list from the user_account table -->
                    <cfquery name="userList" datasource="CFBugTracker">
                        SELECT id, name
                        FROM user_account
                        ORDER BY name;
                    </cfquery>

                    <!-- Loop through the user list and populate the dropdown -->
                    <cfoutput query="userList">
                        <option value="#userList.id#" 
                            <cfif userList.id EQ bugDetails.user_id>selected</cfif>>
                            #userList.name#
                        </option>
                    </cfoutput>
                </select>

                <!-- Submit button -->
                <button type="submit" name="submit" <cfif bugDetails.status EQ "closed">disabled</cfif>>Update Bug</button>
            </form>
        </div>

        <cfset bugHistory = bugService.getBugHistory("#url.bugId#")>

        <cfif bugHistory.recordCount NEQ 0>
            <h2 style="text-align: center">Bug history</h2>

            <!-- Output the data in an HTML table -->
            <table border="1">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Date/Time</th>
                        <th>Action</th>
                        <th>Comment</th>
                    </tr>
                </thead>
                <tbody>
                    <cfoutput query="bugHistory">
                        <tr>
                            <td>#bugHistory.id#</td>
                            <td>#dateFormat(bugHistory.date_time, 'yyyy-mm-dd HH:mm:ss')#</td>
                            <td>#bugHistory.action#</td>
                            <td>#bugHistory.comment#</td>
                        </tr>
                    </cfoutput>
                </tbody>
            </table>
        </cfif>

    </cfif>

</body>
</html>

