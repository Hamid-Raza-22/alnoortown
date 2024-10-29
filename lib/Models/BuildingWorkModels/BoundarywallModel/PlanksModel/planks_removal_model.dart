class PlanksRemovalModel{
  int? id;
  dynamic block;
  dynamic no_of_planks;
  dynamic total_length;
  dynamic date;
  dynamic time;
  dynamic user_id;
  int posted;

  PlanksRemovalModel({
    this.id,
    this.block,
    this.no_of_planks,
    this.total_length,
    this.time,
    this.date,
    this.user_id,
    this.posted = 0

  });

  factory PlanksRemovalModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PlanksRemovalModel(
        id: json['id'],
        block: json['block'],
        no_of_planks: json['no_of_planks'],
        total_length:  json['total_length'],
        time: json ['time'],
        user_id: json['user_id'],
        date: json['planks_removal_date'],
        posted: json['posted']?? 0
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block':block,
      'no_of_planks':no_of_planks,
      'total_length':total_length,
      'user_id':user_id,
      'planks_removal_date':date,
      'time': time,
      'posted':posted,
    };
  }
}
