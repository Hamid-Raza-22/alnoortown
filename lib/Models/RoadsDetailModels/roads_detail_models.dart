class RoadsDetailModels{
  int? id;
  dynamic phase;
  dynamic block;
  dynamic street;
  dynamic length;
  dynamic road_type;
  //dynamic user_id;
  RoadsDetailModels({
    this.id,
    this.phase,
    this.block,
    this.street,
    this.length,
    this.road_type,
    //this.user_id,
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
      //user_id: json['user_id'],
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
      //'user_id':user_id,
    };
  }
}
