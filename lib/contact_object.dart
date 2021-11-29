class ContactObject {
  final int? id;
  final String name;
  final String phone;

  ContactObject({this.id, required this.name, required this.phone});
  ContactObject.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        phone = res["phone"];

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'phone': phone};
  }
}
