class PipelineModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic length;
  dynamic date;

  PipelineModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.length,
    this.date
  });

  factory PipelineModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PipelineModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      length: json['length'],
        date:  json['date']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'length':length,
      'date':date
    };
  }
}
