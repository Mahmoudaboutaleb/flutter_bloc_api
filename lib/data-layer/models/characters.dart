class Character {
  late int id;
  late String name;
  late String status;
  late String species;
  late String gender;
  late String image;
  late Map<String, dynamic> origin;
  late Map<String, dynamic> location;
  late List<String> episode;
  late String created;

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    gender = json['gender'];
    image = json['image'];
    origin = json['origin'];
    location = json['location'];
    episode = List<String>.from(json['episode']);
    created = json['created'];
  }
}
