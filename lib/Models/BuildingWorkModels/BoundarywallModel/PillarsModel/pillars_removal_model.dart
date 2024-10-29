class PillarsRemovalModel{
  int? id;
  dynamic block;
  dynamic no_of_pillars;
  dynamic total_length;
  dynamic date;
  dynamic time;
  dynamic user_id;
  int posted;

  PillarsRemovalModel({
    this.id,
    this.block,
    this.no_of_pillars,
    this.total_length,
    this.time,
    this.date,
    this.user_id,
    this.posted = 0

  });

  factory PillarsRemovalModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PillarsRemovalModel(
        id: json['id'],
        block: json['block'],
        no_of_pillars: json['no_of_pillars'],
        total_length:  json['total_length'],
        time: json ['time'],
        user_id: json['user_id'],
        date: json['pillars_removal_date'],
        posted: json['posted']?? 0
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block':block,
      'no_of_pillars':no_of_pillars,
      'total_length':total_length,
      'user_id':user_id,
      'pillars_removal_date':date,
      'time': time,
      'posted':posted,
    };
  }
}
