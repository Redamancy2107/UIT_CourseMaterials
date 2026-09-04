const test = require('node:test');
const assert = require('node:assert');
const http = require('node:http');

// Set port to 3002 for testing to avoid conflicts
process.env.PORT = '3002';

// Import and start the app
require('./app.js');

test('Web App Tests', async (t) => {
  // Allow a tiny delay for the server to finish binding to the port
  await new Promise(resolve => setTimeout(resolve, 250));

  await t.test('GET / should return HTML with student name', async () => {
    const res = await new Promise((resolve, reject) => {
      http.get('http://localhost:3002/', resolve).on('error', reject);
    });

    // Assert correct status code
    assert.strictEqual(res.statusCode, 200, 'Status code should be 200');

    // Assert correct content type
    const contentType = res.headers['content-type'] || '';
    assert.ok(contentType.includes('html'), 'Content-type should include html');

    // Assert correct body content
    const body = await new Promise((resolve) => {
      let data = '';
      res.on('data', chunk => {
        data += chunk;
      });
      res.on('end', () => {
        resolve(data);
      });
    });

    assert.ok(body.includes('24520601'), 'Response body should include student ID 24520601');
    assert.ok(body.includes('Nguyễn Đại Hưng'), 'Response body should include student name Nguyễn Đại Hưng');
  });

  // Force process exit to close server and let tests complete
  setTimeout(() => {
    process.exit(0);
  }, 100);
});
