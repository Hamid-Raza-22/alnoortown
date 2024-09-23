class PipelineModel{
  int? id;
  dynamic block_no;
  dynamic street_no;
  dynamic length;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  PipelineModel({
    this.id,
    this.block_no,
    this.street_no,
    this.length,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory PipelineModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PipelineModel(
      id: json['id'],
      block_no: json['block_no'],
      street_no: json['street_no'],
      length: json['length'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'street_no':street_no,
      'length':length,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
