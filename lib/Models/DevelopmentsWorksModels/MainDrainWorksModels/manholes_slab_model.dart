class ManholesSlabModel{
  int? id;
  dynamic block_no;
  dynamic street_no;
  dynamic no_of_comp_slabs;
  dynamic date;
  dynamic time;
  dynamic user_id;
  int posted;  // New field to track whether data has been posted

  ManholesSlabModel({
    this.id,
    this.block_no,
    this.street_no,
    this.no_of_comp_slabs,
    this.date,
    this.time,
    this.user_id,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory ManholesSlabModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ManholesSlabModel(
      id: json['id'],
      block_no: json['block_no'],
      street_no: json['street_no'],
      no_of_comp_slabs: json['no_of_comp_slabs'],
        date:  json['manholes_slabs_date'],
        time:  json['time'],
        user_id: json['user_id'],
      posted: json['posted']??0 // Get the posted status from the database


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'street_no':street_no,
      'no_of_comp_slabs':no_of_comp_slabs,
      'manholes_slabs_date':date,
      'time':time,
      'user_id':user_id,
      'posted': posted,  // Include the posted status

    };
  }
}
