# Live version

The deployed site is available at the following address:

http://5.44.46.70:8500/bugtracker/index.cfm

The credentials are:

Login: oleg_ilinets

Password: 123456

# CI/CD

The site is deployed to the server and checked continuously via GitHub actions. The workflow can be checked here:

https://github.com/ioweh/bugtracker/actions

Once the code is checked that it compiles, the deployment to the production server is started. In parallel, CFLint checks are run.

# Database creation

The db_sript.sql file, which can be found in the root of this repository, creates the database and fills it with the users. Cascading deletes are taken into account. I.e., when the bug is deleted, all the records in the bug history table associated with this bug, are deleted too. Similarly, when the user is deleted, all the records in the bug table associated with this user are deleted and all the records in the bug history table associated with these bugs are deleted too.

# Bug workflow

The bug can be edited by pressing on the Edit button in the table containing the list of bugs. This table can be sorted by clicking on the headers.

The user can change the status of the bug when a comment is provided and can reassign it to another user once the bug is created.

Once the bug is created, it is automatically assigned the New status. In the bug history table, a new record appears with the action Input. It then can be edited and assigned the Open status. In the bug history, the record with the action Assigning is created. Then the bug can be solved. In the bug history, a record with the action Solving is stored. Then the bug can either be reopened or checked with the records with actions Reopening and Checking in the bug history table correspondingly. The Checked bug can be either Open again or Closed with the actions Reopening and Closing created in the bug history table. The Closed bug cannot be further processed, only deleted from the bug list table.

# ColdFusion version

The version of ColdFusion used on the server is Adobe ColdFusion (2023 Release). PostgreSQL was chosen as the database management system. Please note that the user bugtrackeradmin needs to be created before filling in the table from the script.

# Data source

In the Data & Services section, a new data source needs to be added:

http://localhost:8500/CFIDE/administrator/index.cfm

CF Data Source Name: CFBugTracker

Server: 127.0.0.1

User name: bugtrackeradmin

Database: bugtrackerdb

Password: the password of the bugtracker admin user

# Tests

A few fixes were made to the TestBox code in order for it to actually run. Therefore the following fork has been created:

https://github.com/ioweh/TestBox

https://github.com/Ortus-Solutions/TestBox/commit/c87d229cebb50980996b8c8ea62fd2ab4848b862

Download the TestBox from here into the wwwroot folder on the server.

git clone https://github.com/ioweh/TestBox.git

Then rename the wwwroot/TestBox folder to wwwroot/testbox.

The tests can be run individually from this folder:

http://localhost:8500/bugtracker/tests/specs/

Or they can be run via Commandbox. Run the following command in the bugtracker directory:

box

And then:

testbox run

The debian package for CommandBox can be downloaded from here:

https://www.ortussolutions.com/products/commandbox

# Responsive design

The app should be looking good and quite usable on a mobile device, such as phone.

