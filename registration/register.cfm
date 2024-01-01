
<cfset menu = createObject("component", "bugtracker.menu")>

<html>
<head>
    <title>User Registration</title>
    <style>

        .container {
            width: 500px;
            height: 450px;
            margin: 20px;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 8px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <CFOUTPUT>#menu.renderMenu()#</CFOUTPUT>
    <div class="container">
        <h2>User Registration</h2>
        <form action="process_registration.cfm" method="post">
            <label for="username">Login:</label>
            <input type="text" name="login" required><br>

            <label for="username">Name:</label>
            <input type="text" name="name" required><br>

            <label for="username">Surname:</label>
            <input type="text" name="surname" required><br>
        
            <label for="password">Password:</label>
            <input type="password" name="password" required><br>
        
            <button type="submit">Register</button>
        </form>
    </div>
</body>
</html>

