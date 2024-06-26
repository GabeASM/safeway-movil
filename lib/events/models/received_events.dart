class EventReceived {
  final int id;
  final String image;
  final String category;
  final String description;
  final double latitude;
  final double longitude;
  final String createdAt;
  final int userId;

  EventReceived({
    required this.id,
    required this.image,
    required this.category,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.userId,
  });

  factory EventReceived.fromJson(Map<String, dynamic> json) {
    return EventReceived(
      id: json['id'],
      image: json['image'],
      category: json['category'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdAt: json['createdAt'],
      userId: json['userId'],
    );
  }

  static List<EventReceived> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => EventReceived.fromJson(json)).toList();
  }
}
