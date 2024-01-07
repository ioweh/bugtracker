// BugServiceTest.cfc (TestBox test)
component extends="testbox.system.BaseSpec" {

    function beforeAll() {
        // Instantiate the BugService component
        <!--- // NOVAR --->
        bugService = createObject("component", "bugtracker.bug_management");
    }

    function run() {
        describe("BugService Tests", function() {
            it("should add a new bug", function() {
                // Arrange
                // Mock bugData
                var formData = {
                    date: createDate(2022, 1, 1),
                    shortDescription: "Test Bug",
                    longDescription: "This is a test bug",
                    user_id: 1,
                    urgency: "urgent",
                    severity: "critical"
                };

                // Act
                var addResult = bugService.addBug(formData);

                // Assert
                expect(addResult).toBeTypeOf("integer"); // Assuming a successful adding
                bugService.deleteBug(addResult);
            });

            it("should get bug list", function() {
                // Arrange
                // Mock bugData
                var formData = {
                    date: createDate(2022, 1, 1),
                    shortDescription: "Test Bug",
                    longDescription: "This is a test bug",
                    user_id: 1,
                    urgency: "urgent",
                    severity: "critical"
                };

                var addResult1 = bugService.addBug(formData);
                var addResult2 = bugService.addBug(formData);

                // Act
                var bugList = bugService.getBugList();

                // Assert
                expect(bugList.recordCount).toBe(2);
                bugService.deleteBug(addResult1);
                bugService.deleteBug(addResult2);
            });

            it("should update the bug, get bug details and log the correct action", function() {
                // Arrange: Set up the necessary data for the test
                // Mock bugData
                var formData = {
                    date: createDate(2022, 1, 1),
                    shortDescription: "Test Bug",
                    longDescription: "This is a test bug",
                    user_id: 1,
                    urgency: "urgent",
                    severity: "critical"
                };

                var addResult = bugService.addBug(formData);

                var bugId = addResult;
                var status = "open";
                var previousStatus = "new";
                var comments = "Test comment";
                var userId = 2;
                var shortDescription = "Updated Short Description";
                var longDescription = "Updated Long Description";
                var priority = "non_urgent";
                var severity = "non_critical";

                // Act: Call the updateBug function
                bugService.updateBug(
                    bugId,
                    status,
                    previousStatus,
                    comments,
                    userId,
                    shortDescription,
                    longDescription,
                    priority,
                    severity
                );

                // Assert: Check if the bug was updated and the correct action was logged
                var updatedBug = bugService.getBugDetails(bugId);
                var bugHistory = bugService.getBugHistory(bugId);

                expect(updatedBug.status).toBe(status);
                expect(updatedBug.short_description).toBe(shortDescription);
                expect(updatedBug.long_description).toBe(longDescription);
                expect(updatedBug.urgency).toBe(priority);
                expect(updatedBug.severity).toBe(severity);

                // Check if the correct action was logged in the bug history
                expect(bugHistory.action[2]).toBe("assigning");
                bugService.deleteBug(addResult);
            });
        });
    }
}

