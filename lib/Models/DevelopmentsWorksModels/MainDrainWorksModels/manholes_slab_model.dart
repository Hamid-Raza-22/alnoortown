class ManholesSlabModel{
  int? id;
  String? blockNo;
  String? streetNo;
  String? numOfCompSlab;




  ManholesSlabModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.numOfCompSlab,



  });

  factory ManholesSlabModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ManholesSlabModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      numOfCompSlab: json['numOfCompSlab'],


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'numOfCompSlab':numOfCompSlab,

    };
  }
}
