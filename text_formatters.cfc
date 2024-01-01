<!-- text_formatters.cfc -->
<cfcomponent>

    <cffunction name="getHumanReadableSeverity" access="public" returntype="string">
        <cfargument name="severityFromDatabase" type="string" required="true">
        
        <!-- Severity mapping -->
        <cfset var severityMapping = "">
        <cfset severityMapping = {
            "blocker": "Blocker",
            "critical": "Critical",
            "non_critical": "Non-Critical",
            "request_for_change": "Request for Change"
        }>

        <!-- Get human-readable severity using the severity mapping -->
        <cfset var humanReadableSeverity = severityMapping[arguments.severityFromDatabase] ?: "Unknown">

        <!-- Return the human-readable severity -->
        <cfreturn humanReadableSeverity>
    </cffunction>

    <cffunction name="getHumanReadableUrgency" access="public" returntype="string">
        <cfargument name="urgencyFromDatabase" type="string" required="true">

        <!-- Urgency mapping -->
        <cfset var urgencyMapping = "">
        <cfset urgencyMapping = {
            "very_urgent": "Very Urgent",
            "urgent": "Urgent",
            "non_urgent": "Non-Urgent",
            "not_at_all_urgent": "Not at All Urgent"
        }>

        <!-- Get human-readable urgency using the urgency mapping -->
        <cfset var humanReadableUrgency = urgencyMapping[arguments.urgencyFromDatabase] ?: "Unknown">

        <!-- Return the human-readable urgency -->
        <cfreturn humanReadableUrgency>
    </cffunction>

    <cffunction name="capitalizeFirstLetter" access="public" returntype="string">
        <cfargument name="value" type="string" required="true">
        
        <!-- Capitalize the first letter of the value -->
        <cfset var capitalizedValue = UCase(Left(arguments.value, 1)) & Right(arguments.value, Len(arguments.value) - 1)>

        <!-- Return the capitalized value -->
        <cfreturn capitalizedValue>
    </cffunction>

</cfcomponent>

