class Plant
{
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
}