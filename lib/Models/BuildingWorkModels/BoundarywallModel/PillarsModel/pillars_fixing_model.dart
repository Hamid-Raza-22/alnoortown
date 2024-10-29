class PillarsFixingModel{
  int? id;
  dynamic block;
  dynamic no_of_pillars;
  dynamic total_length;
  dynamic date;
  dynamic time;
  dynamic user_id;
  int posted;

  PillarsFixingModel({
    this.id,
    this.block,
    this.no_of_pillars,
    this.total_length,
    this.time,
    this.date,
    this.user_id,
    this.posted = 0

  });

  factory PillarsFixingModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PillarsFixingModel(
        id: json['id'],
        block: json['block'],
        no_of_pillars: json['no_of_pillars'],
        total_length:  json['total_length'],
        time: json ['time'],
        user_id: json['user_id'],
        date: json['pillars_fixing_date'],
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
      'pillars_fixing_date':date,
      'time': time,
      'posted':posted,
    };
  }
}
