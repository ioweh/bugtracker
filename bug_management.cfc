<!-- bug_management.cfc -->

<cfcomponent>

    <!-- Function to get a list of bugs -->
    <cffunction name="getBugList" access="public" returntype="query">
        <cfset var bugList = "">
        <cfquery name="bugList" datasource="CFBugTracker">
            SELECT * FROM bug;
        </cfquery>
        <cfreturn bugList>
    </cffunction>

    <!-- Function to get details of a specific bug -->
    <cffunction name="getBugDetails" access="remote" returntype="query">
        <cfargument name="bugId" type="numeric" required="true">
        <cfset var bugDetails = "">
        <cfquery name="bugDetails" datasource="CFBugTracker">
            SELECT * FROM bug WHERE bug_id = <cfqueryparam value="#arguments.bugId#" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfreturn bugDetails>
    </cffunction>

    <!-- Function to add a new bug -->
    <cffunction name="addBug" access="remote" returntype="void">
        <cfargument name="bugData" type="struct" required="true">
        <cfquery datasource="CFBugTracker">
            INSERT INTO bug (date, short_description, long_description, user_id, status, urgency, severity)
            VALUES (
                <cfqueryparam value="#bugData.date#" cfsqltype="cf_sql_date">,
                <cfqueryparam value="#bugData.shortDescription#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#bugData.longDescription#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#bugData.user_id#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="new" cfsqltype="cf_sql_varchar">::bug_status,
                <cfqueryparam value="#bugData.urgency#" cfsqltype="cf_sql_varchar">::bug_urgency,
                <cfqueryparam value="#bugData.severity#" cfsqltype="cf_sql_varchar">::bug_severity
            );
        </cfquery>
    </cffunction>

    <!-- Function to update an existing bug -->
    <cffunction name="updateBug" access="remote" returntype="void">
        <cfargument name="bugData" type="struct" required="true">
        <cfquery datasource="CFBugTracker">
            UPDATE bug
            SET
                date = <cfqueryparam value="#bugData.date#" cfsqltype="cf_sql_date">,
                short_description = <cfqueryparam value="#bugData.short_description#" cfsqltype="cf_sql_varchar">,
                long_description = <cfqueryparam value="#bugData.long_description#" cfsqltype="cf_sql_text">,
                user_id = <cfqueryparam value="#bugData.user_id#" cfsqltype="cf_sql_integer">,
                status = <cfqueryparam value="#bugData.status#" cfsqltype="cf_sql_varchar">,
                urgency = <cfqueryparam value="#bugData.urgency#" cfsqltype="cf_sql_varchar">,
                severity = <cfqueryparam value="#bugData.severity#" cfsqltype="cf_sql_varchar">
            WHERE bug_id = <cfqueryparam value="#bugData.id#" cfsqltype="cf_sql_integer">;
        </cfquery>
    </cffunction>

    <!-- Function to delete a bug -->
    <cffunction name="deleteBug" access="remote" returntype="void">
        <cfargument name="bugId" type="numeric" required="true">
        <cfquery datasource="CFBugTracker">
            DELETE FROM bug WHERE bug_id = <cfqueryparam value="#arguments.bugId#" cfsqltype="cf_sql_integer">;
        </cfquery>
    </cffunction>

</cfcomponent>

