import 'dart:convert';

import 'package:equatable/equatable.dart';

class BestOffer extends Equatable {
  final String id;
  final String name;
  final String address;
  final String sqfeet;
  final String rent;
  final String bedroom;
  final String bathroom;
  final String kitchen;
  final String vacant;
  final String parking;
  final String about;
  final String imageUrl;

  const BestOffer({
    required this.id,
    required this.name,
    required this.address,
    required this.sqfeet,
    required this.rent,
    required this.bedroom,
    required this.bathroom,
    required this.kitchen,
    required this.vacant,
    required this.parking,
    required this.about,
    required this.imageUrl,
  });

  factory BestOffer.fromMap(Map<String, dynamic> data) => BestOffer(
        id: data['id'] as String,
        name: data['name'] as String,
        address: data['address'] as String,
        sqfeet: data['sqfeet'] as String,
        rent: data['rent'] as String,
        bedroom: data['bedroom'] as String,
        bathroom: data['bathroom'] as String,
        kitchen: data['kitchen'] as String,
        vacant: data['vacant'] as String,
        parking: data['parking'] as String,
        about: data['about'] as String,
        imageUrl: data['imageUrl'] as String,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'address': address,
        'sqfeet': sqfeet,
        'rent': rent,
        'bedroom': bedroom,
        'bathroom': bathroom,
        'kitchen': kitchen,
        'vacant': vacant,
        'parking': parking,
        'about': about,
        'imageUrl': imageUrl,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BestOffer].
  factory BestOffer.fromJson(String data) {
    return BestOffer.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BestOffer] to a JSON string.
  String toJson() => json.encode(toMap());

  BestOffer copyWith({
    String? id,
    String? name,
    String? address,
    String? sqfeet,
    String? rent,
    String? bedroom,
    String? bathroom,
    String? kitchen,
    String? vacant,
    String? parking,
    String? about,
    String? imageUrl,
  }) {
    return BestOffer(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      sqfeet: sqfeet ?? this.sqfeet,
      rent: rent ?? this.rent,
      bedroom: bedroom ?? this.bedroom,
      bathroom: bathroom ?? this.bathroom,
      kitchen: kitchen ?? this.kitchen,
      vacant: vacant ?? this.vacant,
      parking: parking ?? this.parking,
      about: about ?? this.about,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      address,
      sqfeet,
      rent,
      bedroom,
      bathroom,
      kitchen,
      vacant,
      parking,
      about,
      imageUrl,
    ];
  }
}
