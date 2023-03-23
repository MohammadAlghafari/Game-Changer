// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:game_changer/modules/shared_entities/game_entity.dart';

import '../../core/services/local_database_service.dart';

class GameModel extends GameEntity{
 
  GameModel({
    required int id,
    required String title,
    String? description,
    required int maxCount,
    String? address,
    String? latitude,
    String? longitude,
    required String date,
     String? image,
  }) : super(id: id, title: title, description: description, maxCount: maxCount, address: address, latitude: latitude, longitude: longitude, date: date, image: image );

  
  factory GameModel.fromLocalDataBase(Game source) => GameModel(
      id: source.id,
      title: source.title,
      address: source.address,
      description: source.description,
      latitude: source.latitude,
      longitude: source.longitude,
      maxCount: source.maxCount,
      date: source.date,
      image: source.image);

  @override
  bool operator ==(covariant GameModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.maxCount == maxCount &&
        other.address == address &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.date == date &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        maxCount.hashCode ^
        address.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        date.hashCode ^
        image.hashCode;
  }
}
