import 'package:flutter/material.dart';
import 'package:hotel_flutter/presentation/widgets/room/background_room_image.dart'; // Ensure this file exists
import 'package:hotel_flutter/presentation/widgets/room/reservation_room.dart';
import 'package:hotel_flutter/presentation/widgets/room/reservation_booking.dart';

class HotelScreen extends StatefulWidget {
  final String backgroundImage;
  final String hotelName;
  final double rating;
  final int price;
  final String location;
  final String time;

  const HotelScreen({
    super.key,
    required this.backgroundImage,
    required this.hotelName,
    required this.rating,
    required this.price,
    required this.location,
    required this.time,
  });

  @override
  State<StatefulWidget> createState() {
    return _HotelScreenState();
  }
}

class _HotelScreenState extends State<HotelScreen> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hotelName),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_outline),
            color: const Color.fromARGB(255, 52, 46, 46),
            onPressed: () {
              // Add favorite functionality here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: BackgroundRoomImage(image: widget.backgroundImage),
            ),
<<<<<<< HEAD
            Reservation(
              hotelName: widget.hotelName,
=======
            ReservationRoom(
              roomName: widget.roomName,
>>>>>>> 95b2a9928ed611e77a3ad156504ed2c4b07136cc
              rating: widget.rating,
              price: widget.price,
              location: widget.location,
              time: widget.time,
              activeIndex: _activeIndex,
              onNavTap: (index) {
                setState(() {
                  _activeIndex = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
