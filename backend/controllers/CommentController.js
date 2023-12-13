const Comment = require('../models/Comment');
const LogController = require('../controllers/LogController');

async function createComment(req,res){
    console.log(req.body);
    try{
        const comment = await Comment.create(req.body);
        res.status(201).json(comment);
    }
    catch(err){
        LogController.createLog("CommentController.js","createComment",err.message);
        res.status(500).json({error: err.message});
    }
}

async function getAllComments(req,res){
    try{
        const comments = await Comment.find();
        res.status(201).json(comments);
    }
    catch(err){
        LogController.createLog("CommentController.js","getAllComments",err.message);
        res.status(500).json({error:err.message});
    }
}

async function updateComment(req, res) {
    try {
        const { id } = req.params;
        const updates = req.body;
        const updatedComment = await Comment.findOneAndUpdate({ id: id }, updates, { new: true });
        
        res.status(201).json(updatedComment);
    } catch (err) {
        LogController.createLog("CommentController.js","updateComment",err.message);
        res.status(500).json({ error: err.message });
    }
}


async function deleteComment(req,res){
    try{
        const { id } = req.params;
        await Comment.findOneAndRemove({ id: id });
        res.sendStatus(201);
    }
    catch(err){
        LogController.createLog("CommentController.js","deleteComment",err.message);
        res.status(500).json({error: err.message});
    }
}

module.exports={
    createComment,
    getAllComments,
    updateComment,
    deleteComment
};