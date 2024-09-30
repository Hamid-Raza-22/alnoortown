class LoginModels{
  int? id;
  dynamic user_id;
  dynamic user_name;
  dynamic contact;
  dynamic cnic;
  dynamic image;
  dynamic address;
  dynamic city;
  dynamic password;

  LoginModels({
    this.id,
    this.user_id,
    this.user_name,
    this.contact,
    this.cnic,
    this.image,
    this.address,
    this.city,
    this.password,
  });

  factory LoginModels.fromMap(Map<dynamic,dynamic>json)
  {
    return LoginModels(
      id: json['id'],
      user_id: json['user_id'],
      user_name: json['user_name'],
      contact:  json['contact'],
      cnic:  json['cnic'],
      image:  json['image'],
      address:  json['address'],
      city:  json['city'],
      password:  json['password'],

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'user_id':user_id,
      'user_name':user_name,
      'contact':contact,
      'cnic':cnic,
      'image':image,
      'address':address,
      'city':city,
      'password':password,
    };
  }
}
