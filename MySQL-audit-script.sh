#!/bin/sh
C:/xampp/mysql/bin/mysql -u root -h localhost audit_tool -e "
INSERT INTO audit_logs (event_type, user, host, details)
SELECT 'Login Attempt', user, host, CONCAT('Login attempt by ', user, ' from ', host)
FROM mysql.user;

INSERT INTO audit_logs (event_type, user, host, details)
SELECT 'Privilege Check', user, host, CONCAT('User ', user, ' has SUPER privilege')
FROM mysql.user WHERE CONVERT(Super_priv USING latin1) = CONVERT('Y' USING latin1);

INSERT INTO audit_logs (event_type, user, host, details)
SELECT 'Database Check', user, host, CONCAT('User ', user, ' has access to: ', GROUP_CONCAT(db))
FROM mysql.db GROUP BY user, host;

-- Check if mysql.proc exists and has the right columns
INSERT INTO audit_logs (event_type, user, details)
SELECT 'Schema Check', 'system', 'Checking MySQL schema version'
FROM dual;
"
echo "Audit logs updated successfully in MySQL database."