class PipelineModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic length;
  dynamic date;
  dynamic time;

  PipelineModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.length,
    this.date,
    this.time
  });

  factory PipelineModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PipelineModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      length: json['length'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'length':length,
      'date':date,
      'time':time,
    };
  }
}
