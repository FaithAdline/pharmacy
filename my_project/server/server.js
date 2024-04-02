// server.js
// Import required modules
const express = require('express');
const bodyParser = require('body-parser');

// Create an instance of Express
const app = express();

// Middleware to parse JSON request bodies
app.use(bodyParser.json());

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
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
