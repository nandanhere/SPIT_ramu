const router = require('express').Router();
const College = require('../Models/Colleges');


router.get('/college-details', async (req, res) => {

    try{
        const response = await College.find({});
        console.log(response)
        res.status(200).json({colleges : response});
    }
    catch(err){
        console.log(err);
        res.status(500).json("Error" + err);
    }
})

router.post('/add-college', async (req,res)=> {
    try{
        const {name, address, coordinates, university, hostelFees, collegeFees, branch, imageUrls} = req.body;
        const college = new College({
            name,
            address,
            coordinates,
            university,
            hostelFees,
            collegeFees,
            branch,
            imageUrls
        });
        await college.save();
        res.status(200).json({message : "College added successfully"});

    }
    catch(err){
        console.log(err);
        res.status(500).json("Error" + err);
    }
})

module.exports = router;