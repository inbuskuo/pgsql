require('dotenv').config();
let bodyParser = require('body-parser');
const express = require('express');
const cors = require('cors');
const dns = require('dns');
const URL = require('url').URL;
const app = express();
app.use(bodyParser.urlencoded({ extended: false }));
// Basic Configuration
const port = process.env.PORT || 3000;

app.use(cors());

app.use('/public', express.static(`${process.cwd()}/public`));

app.get('/', function(req, res) {
  res.sendFile(process.cwd() + '/views/index.html');
});

// Your first API endpoint
app.get('/api/hello', function(req, res) {
  res.json({ greeting: 'hello API' });
});

let urlDatabase = {};

  app.get('/api/shorturl/:id', (req, res) => {
    const id = req.params.id;
    if (urlDatabase[id]) {
      res.redirect(urlDatabase[id]);
    } else {
      res.json({ error: 'No short URL found for the given input' });
    }
  });

  app.post('/api/shorturl', (req, res) => {
    const originalUrl = req.body.url;
    const urlObject = new URL(originalUrl);
   
   dns.lookup(urlObject.hostname, (err, address) => {
      if (err) {
         res.json({ error: 'Invalid URL' });
      }else{
    const id = Object.keys(urlDatabase).length + 1;
    urlDatabase[id] =  originalUrl ;
    res.json({ original_url: originalUrl , short_url: id });
      }
    });
   
  });

app.listen(port, function() {
  console.log(`Listening on port ${port}`);
});
