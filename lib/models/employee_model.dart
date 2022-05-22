

import 'dart:convert';

List<Employee> employeeFromJson(String str) => List<Employee>.from(json.decode(str).map((x) => Employee.fromMap(x)));

String employeeToJson(List<Employee> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Employee {
  int? _id;
  String? _name;
  String? _username;
  String? _email;
  String? _profileImage;
  // Address? address;
  String? _phone;
  String? _website;
  // Company? company;
  Employee(dynamic obj){
    _id= obj["id"];
    _name= obj["name"];
    _username= obj["username"];
    _email= obj["email"];
    _profileImage= obj["profile_image"] ?? "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector-PNG.png";
    // address: Address.fromJson(json["address"]),
    _phone= obj["phone"] ?? "123";
    _website= obj["website"] ?? "website";
  }

  Employee.fromMap(Map<String,dynamic> data){
    _id = data['id'];
    _name = data['name'];
    _username = data['username'];
    _email = data['email'];
    _profileImage = data['profile_image'];
    _phone = data['phone'];
    _website = data['website'];
  }
  Map<String, dynamic> toMap() => {'id' : _id,'name' : _name,'username' : _username, 'email' : _email, 'profile_image':_profileImage,'phone':_phone,'website':_website};

  int? get id => _id;
  String? get name => _name;
  String? get username => _username;
  String? get email => _email;
  String? get profileImage => _profileImage;
  String? get phone => _phone;
  String? get website => _website;

}




// class Address {
//   Address({
//     this.street,
//     this.suite,
//     this.city,
//     this.zipcode,
//     this.geo,
//   });
//
//   String? street;
//   String? suite;
//   String? city;
//   String? zipcode;
//   Geo? geo;
//
//   factory Address.fromJson(Map<String, dynamic> json) => Address(
//     street: json["street"],
//     suite: json["suite"],
//     city: json["city"],
//     zipcode: json["zipcode"],
//     geo: Geo.fromJson(json["geo"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "street": street,
//     "suite": suite,
//     "city": city,
//     "zipcode": zipcode,
//     "geo": geo?.toJson(),
//   };
// }
//
// class Geo {
//   Geo({
//     this.lat,
//     this.lng,
//   });
//
//   String? lat;
//   String? lng;
//
//   factory Geo.fromJson(Map<String, dynamic> json) => Geo(
//     lat: json["lat"],
//     lng: json["lng"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "lat": lat,
//     "lng": lng,
//   };
// }
//
// class Company {
//   Company({
//     this.name,
//     this.catchPhrase,
//     this.bs,
//   });
//
//   String? name;
//   String? catchPhrase;
//   String? bs;
//
//   factory Company.fromJson(Map<String, dynamic> json) => Company(
//     name: json["name"],
//     catchPhrase: json["catchPhrase"],
//     bs: json["bs"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "catchPhrase": catchPhrase,
//     "bs": bs,
//   };
// }
