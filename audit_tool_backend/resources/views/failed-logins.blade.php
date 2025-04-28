<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Failed Login Attempts</title>
</head>
<body>
    <h1>Failed Login Attempts</h1>
    <table border="1">
        <thead>
            <tr>
                <th>Username</th>
                <th>Host (IP)</th>
                <th>Attempt Time</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($failedLogins as $login)
                <tr>
                    <td>{{ $login->username }}</td>
                    <td>{{ $login->host }}</td>
                    <td>{{ $login->attempt_time }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
</body>
</html>
