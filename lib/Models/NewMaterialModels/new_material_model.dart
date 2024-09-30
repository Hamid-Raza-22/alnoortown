class NewMaterialModel{
  int? id;
  dynamic sand;
  dynamic soil;
  dynamic base;
  dynamic sub_base;
  dynamic water_bound;
  dynamic other_material;
  dynamic other_material_value;
  dynamic date;
  dynamic time;
  dynamic user_id;
  int posted;  // New field to track whether data has been posted

  NewMaterialModel({
    this.id,
    this.sand,
    this.soil,
    this.base,
    this.sub_base,
    this.water_bound,
    this.other_material,
    this.other_material_value,
    this.date,
    this.time,
    this.user_id,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory NewMaterialModel.fromMap(Map<dynamic,dynamic>json)
  {
    return NewMaterialModel(
      id: json['id'],
      sand: json['sand'],
      soil: json['soil'],
      base: json['base'],
      sub_base: json['sub_base'],
      water_bound: json['water_bound'],
      other_material: json['other_material'],
        other_material_value: json['other_material_value'],
        date:  json['new_material_date'],
        time:  json['time'],
        user_id: json['user_id'],
      posted: json['posted']??0 // Get the posted status from the database
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'sand':sand,
      'soil':soil,
      'base':base,
      'sub_base':sub_base,
      'water_bound':water_bound,
      'other_material':other_material,
      'other_material_value':other_material_value,
      'new_material_date':date,
      'time':time,
      'user_id':user_id,
      'posted': posted,  // Include the posted status

    };
  }
}
