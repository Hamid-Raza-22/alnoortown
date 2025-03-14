class ElectricityWorkModel{
  int? id;
  dynamic block_no;
  dynamic electricity_work_status;
  dynamic date;
  dynamic time;
  dynamic user_id;
  int posted;  // New field to track whether data has been posted

  ElectricityWorkModel({
    this.id,
    this.block_no,
    this.electricity_work_status,
    this.date,
    this.time,
    this.user_id,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory ElectricityWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ElectricityWorkModel(
        id: json['id'],
        block_no: json['block_no'],
        electricity_work_status: json['electricity_work_status'],
        date:  json['electricity_work_date'],
        time:  json['time'],
        user_id: json['user_id'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'electricity_work_status':electricity_work_status,
      'electricity_work_date':date,
      'time':time,
      'user_id':user_id,
      'posted': posted,  // Include the posted status

    };
  }
}
