<!-- bug_management.cfc -->

<cfcomponent>

    <!-- Function to get a list of bugs -->
    <cffunction name="getBugList" access="public" returntype="query">
        <cfset var bugList = "">
        <cfquery name="bugList" datasource="CFBugTracker">
            SELECT * FROM bug
            JOIN user_account on bug.user_id = user_account.id;
        </cfquery>
        <cfreturn bugList>
    </cffunction>

    <!-- Function to get details of a specific bug -->
    <cffunction name="getBugDetails" access="remote" returntype="query">
        <cfargument name="bugId" type="numeric" required="true">
        <cfset var bugDetails = "">
        <cfquery name="bugDetails" datasource="CFBugTracker">
            SELECT bug.id, short_description, long_description, status, date, urgency, severity, login, bug.user_id
            FROM bug
            JOIN user_account on bug.user_id = user_account.id
            WHERE bug.id = <cfqueryparam value="#arguments.bugId#" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfreturn bugDetails>
    </cffunction>

    <!-- Function to add a new bug -->
    <cffunction name="addBug" access="remote" returntype="numeric">
        <cfargument name="bugData" type="struct" required="true">
        <cfset var insertResult = "">
        <cfquery name="insertResult" datasource="CFBugTracker">
            INSERT INTO bug (date, short_description, long_description, user_id, status, urgency, severity)
            VALUES (
                <cfqueryparam value="#bugData.date#" cfsqltype="cf_sql_date">,
                <cfqueryparam value="#bugData.shortDescription#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#bugData.longDescription#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#bugData.user_id#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="new" cfsqltype="cf_sql_varchar">::bug_status,
                <cfqueryparam value="#bugData.urgency#" cfsqltype="cf_sql_varchar">::bug_urgency,
                <cfqueryparam value="#bugData.severity#" cfsqltype="cf_sql_varchar">::bug_severity
            )
            RETURNING id;
        </cfquery>

        <!-- Retrieve the generated ID from the result object -->
        <cfset result = insertResult.id[1]>

        <cfquery datasource="CFBugTracker">
            INSERT INTO bug_history (date_time, action, comment, user_id, bug_id)
            VALUES (
                CURRENT_TIMESTAMP,
                <cfqueryparam value="input" cfsqltype="cf_sql_varchar">::bug_action,
                <cfqueryparam value="new bug created" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#bugData.user_id#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="#insertResult.id#" cfsqltype="cf_sql_integer">
            );
        </cfquery>
        <cfreturn result>
    </cffunction>

    <!-- Function to update an existing bug -->
    <cffunction name="updateBug" access="remote" returntype="void">
        <cfargument name="bugId" type="numeric" required="true">
        <cfargument name="status" type="string" required="true">
        <cfargument name="previousStatus" type="string" required="true">
        <cfargument name="comments" type="string" required="true">
        <cfargument name="userId" type="numeric" required="true">
        <cfargument name="shortDescription" type="string" required="true">
        <cfargument name="longDescription" type="string" required="true">
        <cfargument name="priority" type="string" required="true">
        <cfargument name="severity" type="string" required="true">

        <cfset var action = "">

        <cfif previousStatus EQ "new" AND status EQ "open">
            <cfset action="assigning">
        <cfelseif status EQ "solved">
            <cfset action="solving">
        <cfelseif previousStatus EQ "solved" AND status EQ "open">
            <cfset action="reopening">
        <cfelseif previousStatus EQ "solved" AND status EQ "checked">
            <cfset action="checking">
        <cfelseif previousStatus EQ "checked" AND status EQ "open">
            <cfset action="reopening">
        <cfelseif status EQ "closed">
            <cfset action="closing">
        </cfif>

        <cfquery datasource="CFBugTracker">
            UPDATE bug
            SET
                user_id = <cfqueryparam value="#userId#" cfsqltype="cf_sql_integer">,
                status = <cfqueryparam value="#status#" cfsqltype="cf_sql_varchar">::bug_status,
                short_description = <cfqueryparam value="#shortDescription#" cfsqltype="cf_sql_varchar">,
                long_description = <cfqueryparam value="#longDescription#" cfsqltype="cf_sql_varchar">,
                urgency = <cfqueryparam value="#priority#" cfsqltype="cf_sql_varchar">::bug_urgency,
                severity = <cfqueryparam value="#severity#" cfsqltype="cf_sql_varchar">::bug_severity
            WHERE id = <cfqueryparam value="#bugId#" cfsqltype="cf_sql_integer">;
            INSERT INTO bug_history (date_time, action, comment, user_id, bug_id)
            VALUES (
                CURRENT_TIMESTAMP,
                <cfqueryparam value="#action#" cfsqltype="cf_sql_varchar">::bug_action,
                <cfqueryparam value="#comments#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#userId#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="#bugId#" cfsqltype="cf_sql_integer">
            );
        </cfquery>
    </cffunction>

    <!-- Function to delete a bug -->
    <cffunction name="deleteBug" access="remote" returntype="void">
        <cfargument name="bugId" type="numeric" required="true">
        <cfquery datasource="CFBugTracker">
            DELETE FROM bug WHERE id = <cfqueryparam value="#arguments.bugId#" cfsqltype="cf_sql_integer">;
        </cfquery>
    </cffunction>

    <!-- Function to get history of the bug -->
    <cffunction name="getBugHistory" access="remote" returntype="query">
        <cfargument name="bugId" type="numeric" required="true">
        <cfset var bugHistory = "">
        <cfquery name="bugHistory" datasource="CFBugTracker">
            SELECT id, date_time, action, comment, user_id, bug_id
            FROM bug_history
            WHERE bug_id = <cfqueryparam value="#bugId#" cfsqltype="cf_sql_integer">
            ORDER BY date_time ASC;
        </cfquery>
        <cfreturn bugHistory>
    </cffunction>

</cfcomponent>

