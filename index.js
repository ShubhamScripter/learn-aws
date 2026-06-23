require('dotenv').config();

const express = require('express');
const pool = require('./config/db');
const apiRoutes = require('./routes/api');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

app.get('/', (req, res) => {
  res.json({
    name: 'TaskFlow SaaS',
    status: 'running',
    version: '1.0.0',
    endpoints: {
      health: 'GET /health',
      users: 'GET/POST /api/users',
      tasks: 'GET/POST /api/tasks',
      userTasks: 'GET /api/users/:id/tasks',
    },
  });
});

app.get('/health', async (req, res) => {
  try {
    await pool.query('SELECT 1');
    res.json({ status: 'ok', database: 'connected', timestamp: new Date().toISOString() });
  } catch (err) {
    res.status(503).json({ status: 'error', database: 'disconnected', message: err.message });
  }
});

app.use('/api', apiRoutes);

app.use((req, res) => {
  res.status(404).json({ error: 'Route not found' });
});

app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({ error: 'Internal server error' });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`TaskFlow SaaS running on port ${PORT}`);
});
