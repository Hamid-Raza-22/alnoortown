class RoadsDetailModels{
  int? id;
  dynamic phase;
  dynamic block;
  dynamic street;
  dynamic length;
  dynamic road_type;

  RoadsDetailModels({
    this.id,
    this.phase,
    this.block,
    this.street,
    this.length,
    this.road_type,

  });

  factory RoadsDetailModels.fromMap(Map<dynamic,dynamic>json)
  {
    return RoadsDetailModels(
      id: json['id'],
      phase: json['phase'],
      block: json['block'],
      street:  json['street'],
      length:  json['length'],
      road_type:  json['road_type'],

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block':block,
      'phase':phase,
      'street':street,
      'length':length,
      'road_type':road_type,

    };
  }
}
