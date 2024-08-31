
class FilingModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic status;
  dynamic date;
  dynamic time;

  FilingModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.status,
    this.date,
    this.time

  });

  factory FilingModel.fromMap(Map<dynamic,dynamic>json)
  {
    return FilingModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
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
