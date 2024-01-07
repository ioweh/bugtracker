// BugServiceTest.cfc (TestBox test)
component extends="testbox.system.BaseSpec" {

    function beforeAll() {
        // Instantiate the UserService component here after fixing CFLint
        //userService = createObject("component", "bugtracker.user_management.user_management");
    }

    function run() {
        describe("UserService Tests", function() {
            it("should add a new user and get the added user by id", function() {
                // Arrange: Set up the necessary data for the test
                var userService = createObject("component", "bugtracker.user_management.user_management");

                var newLogin = "testuser";
                var newName = "Test";
                var newSurname = "User";
                var newPassword = "testpassword";
                var hashedNewPassword = "9F735E0DF9A1DDC702BF0A1A7B83033F9F7153A00C29DE82CEDADC9957289B05";

                // Act: Call the addUser function
                var addResult = userService.addUser(
                    newLogin,
                    newName,
                    newSurname,
                    newPassword
                );

                // Assert: Check if the user was added to the database
                var newUser = userService.getUserById(addResult);

                expect(newUser.login).toBe(newLogin);
                expect(newUser.name).toBe(newName);
                expect(newUser.surname).toBe(newSurname);

                expect(newUser.password).toBe(hashedNewPassword);

                // Clean up
                userService.deleteUser(addResult);
            });

            it("should list all users", function() {
                // Arrange: Set up the necessary data for the test
                var userService = createObject("component", "bugtracker.user_management.user_management");

                var newLogin = "testuser";
                var newName = "Test";
                var newSurname = "User";
                var newPassword = "testpassword";
                var hashedNewPassword = "9F735E0DF9A1DDC702BF0A1A7B83033F9F7153A00C29DE82CEDADC9957289B05";

                var addResult = userService.addUser(
                    newLogin,
                    newName,
                    newSurname,
                    newPassword
                );

                // Call the listUsers method
                var userList = userService.listUsers();

                // Assert that the userList is not null and is a query
                expect(userList.recordCount).toBeGT(1);
                expect(isQuery(userList)).toBeTrue();

                // Clean up
                userService.deleteUser(addResult);
            });

            it("should get the user by credentials", function() {
                // Arrange: Set up the necessary data for the test
                var userService = createObject("component", "bugtracker.user_management.user_management");

                var newLogin = "testuser";
                var newName = "Test";
                var newSurname = "User";
                var newPassword = "testpassword";
                var hashedNewPassword = "9F735E0DF9A1DDC702BF0A1A7B83033F9F7153A00C29DE82CEDADC9957289B05";

                // Act: Call the addUser function
                var addResult = userService.addUser(
                    newLogin,
                    newName,
                    newSurname,
                    newPassword
                );

                // Assert: Check if the user was added to the database
                var newUser = userService.getUserIdByCredentials(newLogin, newPassword);

                expect(newUser.id).toBe(addResult);

                // Clean up
                userService.deleteUser(addResult);
            });

            it("should update user details", function() {
                // Arrange: Set up the necessary data for the test
                var userService = createObject("component", "bugtracker.user_management.user_management");

                var newLogin = "testuser";
                var newName = "Test";
                var newSurname = "User";
                var newPassword = "testpassword";
                var hashedNewPassword = "9F735E0DF9A1DDC702BF0A1A7B83033F9F7153A00C29DE82CEDADC9957289B05";

                // Act: Call the addUser function
                var addResult = userService.addUser(
                    newLogin,
                    newName,
                    newSurname,
                    newPassword
                );

                // Create a mock user for testing
                var mockUser = {
                    userId: addResult,
                    newLogin: "newLogin",
                    newUsername: "newUsername",
                    newUserSurname: "newUserSurname",
                    newPassword: "newPassword",
                    hashedNewPassword: "5C29A959ABCE4EDA5F0E7A4E7EA53DCE4FA0F0ABBE8EAA63717E2FED5F193D31"
                };

                // Call the updateUser method with the mock user data
                userService.updateUser(
                    mockUser.userId,
                    mockUser.newLogin,
                    mockUser.newUsername,
                    mockUser.newUserSurname,
                    mockUser.newPassword
                );

                // Fetch the updated user details
                var updatedUser = userService.getUserById(mockUser.userId);

                // Assert that the user details have been updated
                expect(updatedUser.login).toBe(mockUser.newLogin);
                expect(updatedUser.name).toBe(mockUser.newUsername);
                expect(updatedUser.surname).toBe(mockUser.newUserSurname);
                expect(updatedUser.password).toBe(mockUser.hashedNewPassword);
            });
        });
    }
}

