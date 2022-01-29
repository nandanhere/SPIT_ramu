require('dotenv').config()
const express = require('express');
const app = express()
const mongoose = require('mongoose');
const cors = require('cors')
const api = require('./Routes/api')
const port = process.env.PORT || 3000;
const dbURI = process.env.MONGO_URI || 'mongodb://localhost:27017';
app.use(express.json());
app.use(express.urlencoded({extended: true}))
app.use(cors())



mongoose.connect(dbURI,{useNewUrlParser:true,useUnifiedTopology:true})
.then((result)=>{
    console.log('connected to db');
})
.catch((err)=>{
    console.log(err);
})



app.use('/api', api);

app.listen(port , () => {
    console.log(`Server running on port ${port}`)
})
