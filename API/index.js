require('dotenv').config()
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors')
const api = require('./Routes/api')
const port = process.env.PORT || 3000;
const dbURI = process.env.DB_URI || 'mongodb://localhost:27017';
app.use(express.json());
app.use(expres.urlencoded({extended: true}))
app.use(cors())


const connection = async () => {
    try {
        await mongoose.connect(dbURI,{useNewUrlParser:true,useUnifiedTopology:true});
        console.log("Successfully connected to database!");
    }
    catch(error){
        console.log('Database conenction failed');
    }
}

connection();

app.use('/api', api);

app.listen(port , () => {
    console.log(`Server running on port ${port}`)
})
