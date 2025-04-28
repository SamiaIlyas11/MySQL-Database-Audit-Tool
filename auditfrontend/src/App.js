import React, { useEffect, useState } from "react";
import './App.css';
import axios from "axios";

function App() {
  const [activeTab, setActiveTab] = useState("failedLogins");
  const [failedLogs, setFailedLogs] = useState([]);
  const [userActivity, setUserActivity] = useState([]);
  const [schemaChanges, setSchemaChanges] = useState([]);
  const [queryPerformance, setQueryPerformance] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [timeFilter, setTimeFilter] = useState("all");
  const [searchQuery, setSearchQuery] = useState("");
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  // Fetch data based on active tab
  useEffect(() => {
    setLoading(true);
    setError(null);

    if (activeTab === "failedLogins") {
      // Use the actual API for failed logins
      axios.get("http://127.0.0.1:8000/api/failed-logins")
        .then(response => {
          setFailedLogs(response.data);
          setLoading(false);
        })
        .catch(error => {
          console.error("Error fetching failed login logs", error);
          setError("Failed to load login attempts");
          setLoading(false);
        });
    } else {
      // Use mock data for other sections
      setTimeout(() => {
        if (activeTab === "userActivity") {
          const mockUserActivity = [
            { username: "john_doe", action: "SELECT", table: "customers", timestamp: "2025-04-28 10:15:22", rows_affected: 5 },
            { username: "admin", action: "UPDATE", table: "orders", timestamp: "2025-04-28 09:45:17", rows_affected: 12 },
            { username: "jane_smith", action: "INSERT", table: "products", timestamp: "2025-04-28 11:32:08", rows_affected: 3 },
            { username: "dev_user", action: "DELETE", table: "archived_logs", timestamp: "2025-04-28 08:22:51", rows_affected: 25 },
            { username: "system", action: "TRUNCATE", table: "temp_data", timestamp: "2025-04-28 07:12:33", rows_affected: 150 },
          ];
          setUserActivity(mockUserActivity);
        } else if (activeTab === "schemaChanges") {
          const mockSchemaChanges = [
            { username: "dba_admin", action: "ADD COLUMN", object: "customers.email_verified", timestamp: "2025-04-28 09:12:45" },
            { username: "admin", action: "CREATE INDEX", object: "orders.customer_id_idx", timestamp: "2025-04-28 10:30:22" },
            { username: "dev_user", action: "ALTER TABLE", object: "products", timestamp: "2025-04-28 11:05:17" },
            { username: "system", action: "DROP CONSTRAINT", object: "orders.fk_customer", timestamp: "2025-04-28 08:45:30" },
            { username: "jane_smith", action: "MODIFY COLUMN", object: "users.password", timestamp: "2025-04-28 14:22:11" },
          ];
          setSchemaChanges(mockSchemaChanges);
        } else if (activeTab === "queryPerformance") {
          const mockQueryPerformance = [
            { query_id: "q123456", username: "john_doe", execution_time: 2.54, cpu_usage: "45%", memory_usage: "12MB", timestamp: "2025-04-28 10:15:22" },
            { query_id: "q123457", username: "admin", execution_time: 0.15, cpu_usage: "5%", memory_usage: "2MB", timestamp: "2025-04-28 09:45:17" },
            { query_id: "q123458", username: "jane_smith", execution_time: 15.32, cpu_usage: "85%", memory_usage: "45MB", timestamp: "2025-04-28 11:32:08" },
            { query_id: "q123459", username: "dev_user", execution_time: 1.87, cpu_usage: "22%", memory_usage: "8MB", timestamp: "2025-04-28 08:22:51" },
            { query_id: "q123460", username: "system", execution_time: 5.43, cpu_usage: "35%", memory_usage: "18MB", timestamp: "2025-04-28 07:12:33" },
          ];
          setQueryPerformance(mockQueryPerformance);
        }
        setLoading(false);
      }, 800); // simulate network delay for mock data
    }
  }, [activeTab]);

  const handleTabChange = (tab) => {
    setActiveTab(tab);
    setSearchQuery("");
  };

  const handleSearch = (e) => {
    setSearchQuery(e.target.value);
  };

  // Filter function based on search query and time
  const filterData = (data) => {
    return data.filter(item => {
      // Search filtering
      const searchInItem = JSON.stringify(item).toLowerCase().includes(searchQuery.toLowerCase());

      // Time filtering (mock implementation)
      let timeMatch = true;
      if (timeFilter === "today") {
        // All our mock data is from today anyway
        timeMatch = true;
      } else if (timeFilter === "week") {
        timeMatch = true;
      } else if (timeFilter === "month") {
        timeMatch = true;
      }

      return searchInItem && timeMatch;
    });
  };

  // Get current data based on active tab
  const getCurrentData = () => {
    switch (activeTab) {
      case "failedLogins":
        return filterData(failedLogs);
      case "userActivity":
        return filterData(userActivity);
      case "schemaChanges":
        return filterData(schemaChanges);
      case "queryPerformance":
        return filterData(queryPerformance);
      default:
        return [];
    }
  };

  const renderContent = () => {
    const data = getCurrentData();

    if (loading) {
      return <div className="loading">Loading data...</div>;
    }

    if (error) {
      return <div className="error-message">{error}</div>;
    }

    if (data.length === 0) {
      return <div className="no-data">No data found</div>;
    }

    switch (activeTab) {
      case "failedLogins":
        return (
          <div className="logs-container">
            {data.map((log, index) => (
              <div key={index} className="log-card">
                <div className="log-header">
                  <span className="log-username">{log.username}</span>
                  <span className="log-time">{log.attempt_time}</span>
                </div>
                <div className="log-details">
                  <span className="log-host">Host: {log.host}</span>
                  {log.status && <span className="log-status">Status: {log.status}</span>}
                </div>
              </div>
            ))}
          </div>
        );

      case "userActivity":
        return (
          <div className="logs-container">
            {data.map((activity, index) => (
              <div key={index} className="log-card">
                <div className="log-header">
                  <span className="log-username">{activity.username}</span>
                  <span className="log-time">{activity.timestamp}</span>
                </div>
                <div className="log-details">
                  <div className="activity-type">
                    <span className={`action-badge ${activity.action.toLowerCase()}`}>{activity.action}</span>
                  </div>
                  <span className="activity-table">Table: {activity.table}</span>
                  <span className="activity-rows">Rows affected: {activity.rows_affected}</span>
                </div>
              </div>
            ))}
          </div>
        );

      case "schemaChanges":
        return (
          <div className="logs-container">
            {data.map((change, index) => (
              <div key={index} className="log-card">
                <div className="log-header">
                  <span className="log-username">{change.username}</span>
                  <span className="log-time">{change.timestamp}</span>
                </div>
                <div className="log-details">
                  <div className="schema-change-type">
                    <span className="schema-badge">{change.action}</span>
                  </div>
                  <span className="schema-object">Object: {change.object}</span>
                </div>
              </div>
            ))}
          </div>
        );

      case "queryPerformance":
        return (
          <div className="logs-container">
            {data.map((query, index) => (
              <div key={index} className="log-card">
                <div className="log-header">
                  <span className="log-username">{query.username}</span>
                  <span className="log-time">{query.timestamp}</span>
                </div>
                <div className="log-details">
                  <span className="query-id">Query ID: {query.query_id}</span>
                  <div className="performance-metrics">
                    <span className={`execution-time ${query.execution_time > 10 ? 'slow' : query.execution_time > 5 ? 'medium' : 'fast'}`}>
                      {query.execution_time} sec
                    </span>
                    <span className="cpu-usage">CPU: {query.cpu_usage}</span>
                    <span className="memory-usage">Memory: {query.memory_usage}</span>
                  </div>
                </div>
              </div>
            ))}
          </div>
        );

      default:
        return <div className="no-data">Select a category to view data</div>;
    }
  };

  return (
    <div className="App">
      <aside className={`sidebar ${isMenuOpen ? 'sidebar-open' : ''}`}>
        <div className="sidebar-header">
          <h3>Menu</h3>
          <button className="mobile-close" onClick={() => setIsMenuOpen(false)}>×</button>
        </div>
        <nav className="sidebar-nav">
          <button
            className={`nav-item ${activeTab === "failedLogins" ? "active" : ""}`}
            onClick={() => handleTabChange("failedLogins")}
          >
            Failed Logins
          </button>
          <button
            className={`nav-item ${activeTab === "userActivity" ? "active" : ""}`}
            onClick={() => handleTabChange("userActivity")}
          >
            User Activity
          </button>
          <button
            className={`nav-item ${activeTab === "schemaChanges" ? "active" : ""}`}
            onClick={() => handleTabChange("schemaChanges")}
          >
            Schema Changes
          </button>
          <button
            className={`nav-item ${activeTab === "queryPerformance" ? "active" : ""}`}
            onClick={() => handleTabChange("queryPerformance")}
          >
            Query Performance
          </button>
        </nav>
        <div className="sidebar-footer">
          <p>Last updated: Today 14:36</p>
        </div>
      </aside>

      <main className="main-content">
        <header className="top-bar">
          <button className="menu-toggle" onClick={() => setIsMenuOpen(!isMenuOpen)}>☰</button>
          <h1 className="main-title">Database Audit Tool</h1>
          <div className="user-info">
            <span className="user-avatar">JD</span>
            <span className="user-name">John Doe</span>
          </div>
        </header>

        <div className="content-area">
          <div className="content-header">
            <h2 className="section-title">
              {activeTab === "failedLogins" && "Failed Login Attempts"}
              {activeTab === "userActivity" && "User Activity Logs"}
              {activeTab === "schemaChanges" && "Database Schema Changes"}
              {activeTab === "queryPerformance" && "Query Performance Metrics"}
            </h2>

            <div className="filters">
              <div className="search-box">
                <input
                  type="text"
                  placeholder="Search..."
                  value={searchQuery}
                  onChange={handleSearch}
                />
              </div>

              <div className="time-filter">
                <select value={timeFilter} onChange={(e) => setTimeFilter(e.target.value)}>
                  <option value="all">All Time</option>
                  <option value="today">Today</option>
                  <option value="week">This Week</option>
                  <option value="month">This Month</option>
                </select>
              </div>

              <button className="export-btn">Export Data</button>
            </div>
          </div>

          <div className="dashboard-summary">
            <div className="stat-card">
              <div className="stat-value">{failedLogs.length}</div>
              <div className="stat-label">Failed Logins</div>
            </div>
            <div className="stat-card">
              <div className="stat-value">{userActivity.length}</div>
              <div className="stat-label">User Actions</div>
            </div>
            <div className="stat-card">
              <div className="stat-value">{schemaChanges.length}</div>
              <div className="stat-label">Schema Changes</div>
            </div>
            <div className="stat-card">
              <div className="stat-value">{queryPerformance.length}</div>
              <div className="stat-label">Queries Analyzed</div>
            </div>
          </div>

          {renderContent()}
        </div>

        <footer className="app-footer">
          <p>Database Audit Tool v1.0 | Copyright © 2025</p>
        </footer>
      </main>
    </div>
  );
}

export default App;