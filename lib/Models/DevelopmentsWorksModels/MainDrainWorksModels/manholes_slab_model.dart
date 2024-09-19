class ManholesSlabModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic numOfCompSlab;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  ManholesSlabModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.numOfCompSlab,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory ManholesSlabModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ManholesSlabModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      numOfCompSlab: json['numOfCompSlab'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'numOfCompSlab':numOfCompSlab,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
