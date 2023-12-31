<!-- EditBug.cfm -->

<!DOCTYPE html>
<html>
<head>
    <title>Edit Bug</title>
</head>
<body>

    <h1>Edit Bug</h1>
    <cffunction name="getBugHistory" returntype="query">
        <cfquery name="bugHistory" datasource="CFBugTracker">
            SELECT id, date_time, action, comment, user_id, bug_id
            FROM bug_history
            ORDER BY date_time ASC;
        </cfquery>
        <cfreturn bugHistory>
    </cffunction>

    <!-- Call the getBugHistory function to retrieve data -->
    <cfset bugHistory = getBugHistory()>

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

    <!-- Check if the form is submitted -->
    <cfif structKeyExists(form, "submit")>
        <cfset trimmedComment = len(trim(form.comments))>
        <cfif len(trim(form.comments)) NEQ 0>
            <cfparam name="form.bugId" type="numeric">
            <cfparam name="form.status" type="string">
            <cfparam name="form.previousStatus" type="string">
            <cfparam name="form.comments" type="string">
            <cfparam name="form.userId" type="numeric">
            <cfset bugId = (isNumeric(form.bugId) ? int(form.bugId) : 0)>
            <cfset userId = (isNumeric(form.userId) ? int(form.userId) : 0)>

            <!-- Call the BugService.cfc to update the bug -->
            <cfset bugService = createObject("component", "bug_management")>
            <cfset bugService.updateBug(bugId, form.status, form.previousStatus, form.comments, userId)>

            <p>Bug updated successfully!</p>

        <cfelse>
            <p>Please fill the comment field</p>
        </cfif>

    </cfif>

    <!-- Assuming you have a URL parameter for the bug ID, e.g., editBug.cfm?bugId=123 -->
    <cfparam name="url.bugId" type="numeric">

    <!-- Fetch bug details from the database based on the bugId -->
    <cfquery name="bugDetails" datasource="CFBugTracker">
        SELECT bug_id, short_description, status, user_id
        FROM bug
        WHERE bug_id = <cfqueryparam value="#url.bugId#" cfsqltype="cf_sql_integer">
    </cfquery>

    <!-- Check if the bug exists -->
    <cfif bugDetails.recordCount EQ 0>
        <p>Bug not found.</p>
    <cfelse>
    
        <h2>Bug status is: <CFOUTPUT>#bugDetails.status#</CFOUTPUT></h2>

        <!-- Bug edit form -->
        <form action="" method="post">
            <input type="hidden" name="bugId" value="<CFOUTPUT>#bugDetails.bug_id#</CFOUTPUT>">
            <input type="hidden" name="previousStatus" value="<CFOUTPUT>#bugDetails.status#</CFOUTPUT>">

            <!-- Status field -->
            <label for="status">Status:</label>
            <cfswitch expression="#bugDetails.status#">
                <cfcase value="new">
                    <select name="status">
                        <option value="open">Open</option>
                    </select>
                </cfcase>
                <cfcase value="open">
                    <select name="status">
                        <option value="solved">Solved</option>
                    </select>
                </cfcase>
                <cfcase value="solved">
                    <select name="status">
                        <option value="open">Open</option>
                        <option value="checked">Checked</option>
                    </select>
                </cfcase>
                <cfcase value="checked">
                    <select name="status">
                        <option value="open">Open</option>
                        <option value="closed">Closed</option>
                    </select>
                </cfcase>
                <cfcase value="closed">
                    Closed
                </cfcase>
                <cfdefaultcase>
                    <!-- Default dropdown with all possible values -->
                    <select name="status">
                        <option value="new">New</option>
                        <option value="open">Open</option>
                        <option value="solved">Solved</option>
                        <option value="checked">Checked</option>
                    </select>
                </cfdefaultcase>
            </cfswitch>
            <br>

            <!-- Comment field -->
            <label for="comments">Comments:</label>
            <textarea name="comments" rows="4" cols="50"><CFOUTPUT></CFOUTPUT></textarea>
            <br>

            <!-- List of users from user_account table -->
            <label for="userId">Assign to User:</label>
            <select name="userId">
                <!-- Fetch user list from the user_account table -->
                <cfquery name="userList" datasource="CFBugTracker">
                    SELECT user_id, name
                    FROM user_account
                    ORDER BY name;
                </cfquery>

                <!-- Loop through the user list and populate the dropdown -->
                <cfoutput query="userList">
                    <option value="#userList.user_id#" 
                        <cfif userList.user_id EQ bugDetails.user_id>selected</cfif>>
                        #userList.name#
                    </option>
                </cfoutput>
            </select>
            <br>

            <!-- Submit button -->
            <input type="submit" name="submit" value="Update Bug">
        </form>

    </cfif>

</body>
</html>

