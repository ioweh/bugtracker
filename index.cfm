
<cfset menu = createObject("component", "menu")>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bug List</title>
    <style>
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }

        tr:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>

    <CFOUTPUT>#menu.renderMenu()#</CFOUTPUT>
    <h1 style="text-align: center">Bug List</h1>

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
                <th>Urgency</th>
                <th>Severity</th>
                <th>Assignee</th>
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
                    <td><CFOUTPUT>#urgency#</CFOUTPUT></td>
                    <td><CFOUTPUT>#severity#</CFOUTPUT></td>
                    <td><CFOUTPUT>#login#</CFOUTPUT></td>
                    <td>
                        <a href="edit_bug.cfm?bugId=<CFOUTPUT>#bug_id#</CFOUTPUT>">Edit</a>
                        <a href="view_bug.cfm?bugId=<CFOUTPUT>#bug_id#</CFOUTPUT>">View</a>
                    </td>
                </tr>
            </cfloop>
        </tbody>
    </table>

</body>
</html>

