class MainDrainExavationModel{
  int? id;
  String? blockNo;
  String? streetNo;
  String? completedLength;




  MainDrainExavationModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.completedLength,



  });

  factory MainDrainExavationModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MainDrainExavationModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      completedLength: json['completedLength'],


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'completedLength':completedLength,

    };
  }
}
