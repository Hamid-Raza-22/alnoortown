class ManholesSlabModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic numOfCompSlab;
  dynamic date;

  ManholesSlabModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.numOfCompSlab,
    this.date
  });

  factory ManholesSlabModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ManholesSlabModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      numOfCompSlab: json['numOfCompSlab'],
        date:  json['date']

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'numOfCompSlab':numOfCompSlab,
      'date':date

    };
  }
}
