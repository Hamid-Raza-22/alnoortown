class MachineModel {
  int? id;
  dynamic block_no;
  dynamic street_no;
  dynamic machine;
  dynamic timeIn;
  dynamic timeOut;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  MachineModel({
    this.id,
    this.block_no,
    this.street_no,
    this.machine,
    this.timeIn,
    this.timeOut,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)
  });

  factory MachineModel.fromMap(Map<dynamic, dynamic> json) {
    return MachineModel(
      id: json['id'],
      block_no: json['block_no'],
      street_no: json['street_no'],
      machine: json['machine'],
      timeIn: json['timeIn'],
      timeOut: json['timeOut'],
      date: json['date'],
      time: json['time'],
      posted: json['posted'],  // Get the posted status from the database
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'block_no': block_no,
      'street_no': street_no,
      'machine': machine,
      'timeIn': timeIn,
      'timeOut': timeOut,
      'date': date,
      'time': time,
      'posted': posted,  // Include the posted status
    };
  }
}
