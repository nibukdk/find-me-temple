class EventModel {
  final String name;
  final String imgUrl;
  final DateTime occassionTime;
  final String venue;
  final String description;

  const EventModel({
    required this.name,
    required this.imgUrl,
    required this.occassionTime,
    required this.venue,
    required this.description,
  });
}
