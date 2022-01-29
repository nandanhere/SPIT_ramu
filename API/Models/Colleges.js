const mongoose = require('mongoose')
const Schema=mongoose.Schema;



const CollegeSchema=new Schema({
    name: {
        type: String,
        required: true
      },
    address: {
        type: String,
        required: true
    },
    coordinates: {
        type: [Number],
        required: true
    },
    university : {
        type: String,
        required: true,
    },
    hostelFees : {
        type: Number,
        required: true,
    },
    collegeFees : {
        type: Number,
        required: true,
    },
    branch : {
        bname : {
            type : String,
            required : true,
        },
        cutoff : {
            type : Number,
            required : true,
        }
    },
    imageUrls : {
        type : [String],
        
    }
    
})

const College=mongoose.model('colleges',CollegeSchema)

module.exports = College;