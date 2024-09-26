class WalkingTracksWorkModel{
  int? id;
  String? type_of_work;
  DateTime? start_date;
  DateTime? expected_comp_date;
  String? walking_tracks_comp_status;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  WalkingTracksWorkModel({
    this.id,
    this.type_of_work,
    this.start_date,
    this.expected_comp_date,
    this.walking_tracks_comp_status,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory WalkingTracksWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return WalkingTracksWorkModel(
        id: json['id'],
        type_of_work: json['type_of_work'],
        start_date: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
        expected_comp_date: json['expected_comp_date'] != null ? DateTime.parse(json['expected_comp_date']) : null,
        walking_tracks_comp_status:json['walking_tracks_comp_status'],
        date:  json['walking_tracks_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'type_of_work':type_of_work,
      'start_date': start_date?.toString(),
      'expected_comp_date': expected_comp_date?.toString(),
      'walking_tracks_comp_status':walking_tracks_comp_status,
      'walking_tracks_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
