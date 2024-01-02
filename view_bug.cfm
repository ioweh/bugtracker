<!-- view_bug.cfm -->

<cfset menu = createObject("component", "menu")>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bug</title>
    <link rel="stylesheet" href="/bugtracker/styles.css">
    <style>
        .bug-details {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            max-width: 400px;
            width: 100%;
            margin: 20px;
        }

        .bug-details h2 {
            color: #333;
        }

        .bug-details-item {
            margin-bottom: 15px;
        }

        .bug-details-label {
            font-weight: bold;
            color: #555;
            margin-bottom: 5px;
        }

        .bug-details-value {
            color: #333;
        }

        @media only screen and (max-width: 767px) {
            .bug-details {
                width: auto;
            }
        }
    </style>
</head>
<body>
    <CFOUTPUT>#menu.renderMenu()#</CFOUTPUT>
    <!-- Assuming you have a URL parameter for the bug ID, e.g., editBug.cfm?bugId=123 -->
    <cfparam name="url.bugId" type="numeric">

    <cfset bugService = createObject("component", "bug_management")>
    <cfset bugDetails = bugService.getBugDetails("#url.bugId#")>

    <!-- Check if the bug exists -->
    <cfif bugDetails.recordCount EQ 0>
        <p>Bug not found.</p>
    <cfelse>
        
        <cfset textFormatters = createObject("component", "text_formatters")>
    
        <div class="bug-details">
            <h2>View Bug Details</h2>

            <div class="bug-details-item">
                <div class="bug-details-label">ID:</div>
                <div class="bug-details-value"><CFOUTPUT>#bugDetails.id#</CFOUTPUT></div>
            </div>

            <div class="bug-details-item">
                <div class="bug-details-label">Short Description:</div>
                <div class="bug-details-value"><CFOUTPUT>#bugDetails.short_description#</CFOUTPUT></div>
            </div>

            <div class="bug-details-item">
                <div class="bug-details-label">Long Description:</div>
                <div class="bug-details-value"><CFOUTPUT>#bugDetails.long_description#</CFOUTPUT></div>
            </div>

            <div class="bug-details-item">
                <div class="bug-details-label">Severity:</div>
                <div class="bug-details-value"><CFOUTPUT>#textFormatters.getHumanReadableSeverity(bugDetails.severity)#</CFOUTPUT></div>
            </div>

            <div class="bug-details-item">
                <div class="bug-details-label">Urgency:</div>
                <div class="bug-details-value"><CFOUTPUT>#textFormatters.getHumanReadableUrgency(bugDetails.urgency)#</CFOUTPUT></div>
            </div>

            <div class="bug-details-item">
                <div class="bug-details-label">Status:</div>
                <div class="bug-details-value"><CFOUTPUT>#textFormatters.capitalizeFirstLetter(bugDetails.status)#</CFOUTPUT></div>
            </div>

            <div class="bug-details-item">
                <div class="bug-details-label">Assigned User:</div>
                <div class="bug-details-value"><CFOUTPUT>#bugDetails.login#</CFOUTPUT></div>
            </div>

            <div class="bug-details-item">
                <div class="bug-details-label">Created Date:</div>
                <div class="bug-details-value"><CFOUTPUT>#dateFormat(bugDetails.date, 'yyyy-mm-dd')#</CFOUTPUT></div>
            </div>
        </div>

        <!-- Call the getBugHistory function to retrieve data -->
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

