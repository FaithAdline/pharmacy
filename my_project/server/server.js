// Import required modules
const express = require('express');
const { Server } = require('ws');
const bodyParser = require('body-parser');

// Set the port
const PORT = process.env.PORT || 3000;

// Create an instance of Express
const app = express();

// Middleware to parse JSON request bodies
app.use(bodyParser.json());

// Set up Express server
const server = app.use((req, res) => res.send('Hello World!')).listen(PORT, () => console.log(`Listening on ${PORT}`));

// Create a WebSocket server
const wss = new Server({ server });

// WebSocket connection handling
wss.on('connection', (ws) => {
  console.log('Client connected');

  // Handle incoming messages
  ws.on('message', (message) => {
    console.log(`Received: ${message}`);
  });

  // Handle client disconnection
  ws.on('close', () => {
    console.log('Client disconnected');
  });
});

// Route to handle POST requests to place orders
app.post('/place_order', (req, res) => {
  // Extract data from request body
  const { medication, quantity } = req.body;

  // Validate request data
  if (!medication || !quantity) {
    return res.status(400).json({ error: 'Invalid order data' });
  }

  // Process the order (example: print order details)
  console.log('Order placed - Medication:', medication, ', Quantity:', quantity);

  // Send a response back to the client
  res.status(200).json({ message: 'Order placed successfully' });
});

// Route to handle GET requests to check statements
app.get('/check_statement', (req, res) => {
  // Implement logic to check statements (example: retrieve statement data from database)

  // Send a response back to the client
  res.status(200).json({ statement: 'Statement data goes here' });
});

// Start the server
server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

