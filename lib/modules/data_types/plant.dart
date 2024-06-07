import 'package:equatable/equatable.dart';

class Plant extends Equatable{
  int id;
  String name;
  String image;
  String description;
  String type;
  String? light;
  String? ideal_temperature;
  String? resistance_zone;
  String? suitable_location;
  String? careful;
  String? liquid_fertilizer;
  String? clean;
  String? toxicity;
  String? names;

  Plant({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.type,
    required this.light,
    required this.ideal_temperature,
    required this.resistance_zone,
    required this.suitable_location,
    required this.careful,
    required this.liquid_fertilizer,
    required this.clean,
    required this.toxicity,
    required this.names
  });


  factory Plant.fromJson(Map<String, dynamic> plantData)
  {
    return Plant(
        id: plantData['id'],
        name: plantData['name'],
        image: plantData['image'],
        description: plantData['description'],
        type: plantData['type'],
        light: plantData['light'],
        ideal_temperature: plantData['ideal_temperature'],
        resistance_zone: plantData['resistance_zone'],
        suitable_location: plantData['suitable_location'],
        careful: plantData['careful'],
        liquid_fertilizer: plantData['liquid_fertilizer'],
        clean: plantData['clean'],
        toxicity: plantData['toxicity'],
        names: plantData['names']
    );
  }

  @override
  List<Object?> get props => [
     id,
    name,
    image,
    description,
    type,
    light,
    ideal_temperature,
    resistance_zone,
    suitable_location,
    careful,
    liquid_fertilizer,
    clean,
    toxicity,
    names
  ];


}