class MachineModel {
  int? id;
  dynamic block_no;
  dynamic street_no;
  dynamic machine;
  dynamic time_in;
  dynamic time_out;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  MachineModel({
    this.id,
    this.block_no,
    this.street_no,
    this.machine,
    this.time_in,
    this.time_out,
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
      time_in: json['time_in'],
      time_out: json['time_out'],
      date: json['machine_date'],
      time: json['time'],
      posted: json['posted']??0  // Get the posted status from the database
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'block_no': block_no,
      'street_no': street_no,
      'machine': machine,
      'time_in': time_in,
      'time_out': time_out,
      'machine_date': date,
      'time': time,
      'posted': posted,  // Include the posted status
    };
  }
}
