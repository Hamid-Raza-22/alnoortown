
class ManholesModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic noOfManholes;
  dynamic date;
  dynamic time;


  ManholesModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.noOfManholes,
    this.date,
    this.time

  });

  factory ManholesModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ManholesModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
        noOfManholes: json['noOfManholes'],
        date:  json['date'],
        time:  json['time']

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'noOfManholes':noOfManholes,
      'date':date,
      'time':time,

    };
  }
}
