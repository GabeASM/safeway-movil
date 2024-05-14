import 'dart:io';

class Event {
  Event(this.category, this.description, this.latitude, this.longitude,
      this.image);
  File image;
  String category;
  String description;
  double latitude;
  double longitude;

  @override
  String toString() {
    return 'Event{category: $category, description: $description, latitude: $latitude, longitude: $longitude, image: $image}';
  }
}
