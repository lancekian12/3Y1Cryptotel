const express = require('express');
const hotelController = require('../controllers/test.hotelController');
const roomController = require('../controllers/test.roomController');
const ratingController = require('../controllers/test.ratingController');
const { upload } = require('../middleware/imageUpload');

const router = express.Router();

// Hotel routes
router.route('/hotels')
    .get(hotelController.getHotel)
    .post(upload.single('image'),hotelController.createHotel);

router.route('/hotels/:id')
    .get(hotelController.getHotel)
    .patch(hotelController.updateHotel)
    .delete(hotelController.deleteHotel);

// Room routes
router.route('/rooms/:hotelId')
    .post(upload.single('image'),roomController.createRoom);

router.route('/rooms/:id')
    .get(roomController.getRoom)
    .patch(roomController.updateRoom)
    .delete(roomController.deleteRoom);

// Rating routes
router.route('/ratings/:roomId')
    .post(ratingController.createRating);

router.route('/ratings/:id')
    .get(ratingController.getRating)
    .patch(ratingController.updateRating)
    .delete(ratingController.deleteRating);

module.exports = router;