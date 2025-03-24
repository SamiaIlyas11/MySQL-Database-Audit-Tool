import React, { useEffect, useState } from "react";
import axios from "axios";

function App() {
  const [logs, setLogs] = useState([]);

  useEffect(() => {
    axios.get("http://localhost:5000/logs") // Flask API
      .then(response => setLogs(response.data))
      .catch(error => console.error("Error fetching logs", error));
  }, []);

  return (
    <div>
      <h1>MySQL Audit Logs</h1>
      <table border="1">
        <thead>
          <tr>
            <th>Time</th>
            <th>Type</th>
            <th>User</th>
            <th>Host</th>
            <th>Details</th>
          </tr>
        </thead>
        <tbody>
          {logs.map((log, index) => (
            <tr key={index}>
              <td>{log.event_time}</td>
              <td>{log.event_type}</td>
              <td>{log.user}</td>
              <td>{log.host}</td>
              <td>{log.details}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default App;
