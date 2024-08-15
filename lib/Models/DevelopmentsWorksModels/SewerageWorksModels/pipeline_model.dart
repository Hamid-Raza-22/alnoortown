class PipelineModel{
  int? id;
  String? blockNo;
  String? streetNo;
  String? length;


  PipelineModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.length,

  });

  factory PipelineModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PipelineModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      length: json['length'],

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'length':length,

    };
  }
}
