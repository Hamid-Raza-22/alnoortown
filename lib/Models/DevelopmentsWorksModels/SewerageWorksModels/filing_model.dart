
class FilingModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic status;
  dynamic date;

  FilingModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.status,
    this.date

  });

  factory FilingModel.fromMap(Map<dynamic,dynamic>json)
  {
    return FilingModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      status: json['status'],
        date:  json['date']

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'status':status,
      'date':date

    };
  }
}
