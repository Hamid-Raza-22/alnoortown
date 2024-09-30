class BlocksDetailsModels{
  int? id;
  dynamic block;
  dynamic marla;
  dynamic plot_no;
  dynamic user_id;
   // New field to track whether data has been posted

  BlocksDetailsModels({
    this.id,
    this.block,
    this.marla,
    this.plot_no,
    this.user_id,
  });

  factory BlocksDetailsModels.fromMap(Map<dynamic,dynamic>json)
  {
    return BlocksDetailsModels(
      id: json['id'],
      block: json['block'],
      marla: json['marla'],
      user_id: json['user_id'],
      plot_no:  json['plot_no'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block':block,
      'marla':marla,
      'user_id':user_id,
      'plot_no':plot_no,

    };
  }
}
