import 'package:church/models/events_model.dart';
import 'package:flutter/foundation.dart';

class EventsProvider with ChangeNotifier {
  // Create the fake list of temples
  final List<EventModel> _events = [
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_2.jpg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_1.jpg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_1.jpg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_3.jpeg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_4.jpg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_4.jpg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_4.jpg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_4.jpg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_4.jpg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_4.jpg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_4.jpg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_4.jpg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_4.jpg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_4.jpg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_4.jpg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_4.jpg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_4.jpg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
    EventModel(
        name: "Saraswati Puja",
        venue: "Ramghat 04",
        imgUrl: "assets/images/events/img_4.jpg",
        occassionTime: DateTime.utc(1999, 02, 09),
        description: "This is done for mata saraswati"),
  ];

  // Future<void> getTemples() async {}

  List<EventModel> get getEvents => [..._events];
}
