const express = require('express')
let bodyParser = require('body-parser');
const app = express()
const cors = require('cors')
require('dotenv').config()
app.use(bodyParser.urlencoded({ extended: false }));

app.use(cors())
app.use(express.static('public'))
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/views/index.html')
});

let users = [];
app.route('/api/users')
.post( (req, res) => {
  const user = {
    username: req.body.username,
    _id: new Date().getTime().toString()
  };
  users.push(user);
  res.json(user);
})
  .get((req, res) => {
    res.json(users);
  });

  app.post('/api/users/:_id/exercises', (req, res) => {
    const userId = req.params._id;
    const user = users.find(u => u._id === userId);
    if (!user) {
      return res.json({ error: 'User not found' });
    }
    const exercise = {
      description: req.body.description,
      duration: parseInt(req.body.duration),
      date: req.body.date ? new Date(req.body.date).toDateString() : new Date().toDateString()
    };
    if (!user.exercises) {
      user.exercises = [];
    }
    user.exercises.push(exercise);
    res.json({
      _id: user._id,
      username: user.username,
      date: exercise.date,
      duration: exercise.duration,
      description: exercise.description
    });
  });

app.get('/api/users/:_id/logs', (req, res) => {
  const userId = req.params._id;
  const user = users.find(u => u._id === userId);
  if (!user) {
    return res.json({ error: 'User not found' });
  }
  const logs = user.exercises || [];
  const from = req.query.from ? new Date(req.query.from) : null;
  const to = req.query.to ? new Date(req.query.to) : null;
  const limit = parseInt(req.query.limit) || logs.length; 

  const filteredLogs = logs.filter(log => {
    const logDate = new Date(log.date);
    return (!from || logDate >= from) && (!to || logDate <= to);
  }).slice(0, limit);

  res.json({
    _id: user._id,
    username: user.username,
    count: filteredLogs.length,
    log: filteredLogs
  });
});

const listener = app.listen(process.env.PORT || 3000, () => {
  console.log('Your app is listening on port ' + listener.address().port)
})
