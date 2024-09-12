
class BackFilingModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic status;
  dynamic date;
  dynamic time;

  BackFilingModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.status,
    this.date,
    this.time

  });

  factory BackFilingModel.fromMap(Map<dynamic,dynamic>json)
  {
    return BackFilingModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
        status: json['status'],
        date:  json['date'],
        time:  json['time']

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'status':status,
      'date':date,
      'time':time,

    };
  }
}
