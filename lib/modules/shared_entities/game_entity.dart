// ignore_for_file: public_member_api_docs, sort_constructors_first
class GameEntity {
  int id;
  String title;
  String? description;
  int maxCount;
  String? address;
  String? latitude;
  String? longitude;
  String date;
  String? image;
  GameEntity({
    required this.id,
    required this.title,
    this.description,
    required this.maxCount,
    this.address,
    this.latitude,
    this.longitude,
    required this.date,
    this.image,
  });
}
