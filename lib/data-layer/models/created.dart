// ignore_for_file: public_member_api_docs, sort_constructors_first
class Created {
  String? created;
  Created({
    this.created,
  });
  Created.fromJson(Map<String, dynamic> json) {
    created = json['created'];
  }
}
