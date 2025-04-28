<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class ProcessSlowQueries extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'process:slowqueries';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Process slow queries from MySQL slow query log and insert into database';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $logFilePath = 'C:/xampp/mysql/data/mysql-slow.log'; // Adjust the path to your log file

        if (file_exists($logFilePath)) {
            $logContents = file_get_contents($logFilePath);
            // Split the log into individual queries
            $queries = explode("# Time:", $logContents);

            $this->info("Found " . count($queries) . " potential slow queries.");

            foreach ($queries as $query) {
                if (strpos($query, 'Query_time:') !== false) {
                    // Extract execution time
                    preg_match("/Query_time: (\d+\.\d+)/", $query, $matches);
                    $executionTime = $matches[1] ?? 0;

                    // Debug: Output execution time
                    $this->info("Execution Time: $executionTime");

                    // Skip queries that are faster than the threshold (e.g., 2 seconds)
                    if ($executionTime <= 2) {
                        continue;
                    }

                    // Debug: Output the raw query block to check its format
                    $this->info("Raw Query Block: $query");

                    // Refined regex to capture the entire query text, including after SET timestamp
                    preg_match("/SET timestamp=\d+;[\s\S]*?SELECT [^\r\n]+/s", $query, $queryMatches);
                    $queryText = $queryMatches[0] ?? '';

                    // Debug: Output the extracted query text
                    $this->info("Extracted Query Text: $queryText");

                    // Insert into the database if there's query text
                    if ($queryText) {
                        try {
                            DB::table('suspicious_queries')->insert([
                                'query_text' => $queryText,
                                'execution_time' => $executionTime,
                                'detected_at' => now(),
                            ]);
                            $this->info("Query successfully inserted into database.");
                        } catch (\Exception $e) {
                            $this->error("Error inserting query: " . $e->getMessage());
                        }
                    } else {
                        $this->error("Query text was not extracted properly.");
                    }
                }
            }

            $this->info('Slow queries processed and inserted into the database!');
        } else {
            $this->error("Slow query log file does not exist at $logFilePath");
        }

        return Command::SUCCESS;
    }
}
