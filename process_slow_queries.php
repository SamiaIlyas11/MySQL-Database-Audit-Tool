<?php

// Database connection (replace with your DB details)
$pdo = new PDO('mysql:host=127.0.0.1;dbname=audit_tool', 'root', '');

// Path to the slow query log file
$logFilePath = 'C:/xampp/mysql/data/mysql-slow.log';

// Read the slow query log
$logContents = file_get_contents($logFilePath);

// Split the log by queries
$queries = explode("# Time:", $logContents);

// Loop through each query to extract details and insert them into the database
foreach ($queries as $query) {
    if (strpos($query, 'Query_time:') !== false) {
        // Extract the query execution time
        preg_match("/Query_time: (\d+\.\d+)/", $query, $matches);
        $executionTime = $matches[1] ?? 0;

        // Skip queries with execution time below threshold (e.g., 2 seconds)
        if ($executionTime <= 2) {
            continue;
        }

        // Extract the query text (typically starts with 'SELECT', 'UPDATE', etc.)
        preg_match("/(\S+ SELECT .+)/", $query, $queryMatches);
        $queryText = $queryMatches[1] ?? '';

        // Insert the query and execution time into the database
        if ($queryText) {
            $stmt = $pdo->prepare("INSERT INTO suspicious_queries (query_text, execution_time) VALUES (?, ?)");
            $stmt->execute([$queryText, $executionTime]);
        }
    }
}

echo "Slow queries processed and inserted into database!";
?>
