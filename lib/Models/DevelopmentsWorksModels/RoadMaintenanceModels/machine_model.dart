class MachineModel {
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic machine;
  dynamic timeIn;
  dynamic timeOut;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  MachineModel({
    this.id,
    this.blockNo,
    this.streetNo,
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
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
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
      'blockNo': blockNo,
      'streetNo': streetNo,
      'machine': machine,
      'timeIn': timeIn,
      'timeOut': timeOut,
      'date': date,
      'time': time,
      'posted': posted,  // Include the posted status
    };
  }
}
