import logo from './logo.svg';
import './App.css';
import React, { useEffect, useState } from "react";
import axios from "axios";

function App() {
  const [failedLogs, setFailedLogs] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    setLoading(true);
    axios.get("http://127.0.0.1:8000/api/failed-logins")
      .then(response => {
        setFailedLogs(response.data);
        setLoading(false);
      })
      .catch(error => {
        console.error("Error fetching logs", error);
        setError("Failed to load login attempts");
        setLoading(false);
      });
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <h1 className="main-title">Database Audit Tool</h1>
        <h2 className="section-title">Failed Login Attempts</h2>

        {loading && <div className="loading">Loading data...</div>}

        {error && <div className="error-message">{error}</div>}

        {!loading && !error && failedLogs.length === 0 && (
          <div className="no-data">No failed login attempts found</div>
        )}

        <div className="logs-container">
          {failedLogs.map((log, index) => (
            <div key={index} className="log-card">
              <div className="log-header">
                <span className="log-username">{log.username}</span>
                <span className="log-time">{log.attempt_time}</span>
              </div>
              <div className="log-details">
                <span className="log-host">Host: {log.host}</span>
              </div>
            </div>
          ))}
        </div>
      </header>
    </div>
  );
}

export default App;