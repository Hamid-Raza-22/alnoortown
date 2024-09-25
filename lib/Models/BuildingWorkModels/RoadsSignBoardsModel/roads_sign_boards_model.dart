class RoadsSignBoardsModel{
  int? id;
  String? block_no;
  String? road_no;
  String? from_plot_no;
  String? to_plot_no;
  String? road_side;
  String? comp_status;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  RoadsSignBoardsModel({
    this.id,
    this.block_no,
    this.road_no,
    this.from_plot_no,
    this.to_plot_no,
    this.road_side,
    this.comp_status,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory RoadsSignBoardsModel.fromMap(Map<dynamic,dynamic>json)
  {
    return RoadsSignBoardsModel(
        id: json['id'],
        block_no: json['block_no'],
        road_no: json['road_no'],
        from_plot_no: json['from_plot_no'],
        to_plot_no: json['to_plot_no'],
        road_side: json['road_side'],
        comp_status:json['comp_status'],
        date:  json['roads_sign_boards_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'road_no':road_no,
      'from_plot_no':from_plot_no,
      'to_plot_no':to_plot_no,
      'road_side':road_side,
      'comp_status':comp_status,
      'roads_sign_boards_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
