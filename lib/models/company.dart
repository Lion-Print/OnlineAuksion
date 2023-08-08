class Companys {
  late int createdBy;
  late String createdDate;
  late int modifiedBy;
  late String modifiedDate;
  late int id;
  late String name;
  late String director;
  late String phone;
  late List suppliers;

  Companys({required this.createdBy,required this.createdDate,required this.modifiedBy,required this.modifiedDate,required this.id,required this.name,required this.director,required this.phone,required this.suppliers});

  Companys.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'] ?? 0;
    createdDate = json['createdDate'] ?? '';
    modifiedBy = json['modifiedBy'] ?? 0;
    modifiedDate = json['modifiedDate'] ?? '';
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    director = json['director'] ?? '';
    phone = json['phone'] ?? '';
    suppliers = json['suppliers'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdBy'] = createdBy;
    data['createdDate'] = createdDate;
    data['modifiedBy'] = modifiedBy;
    data['modifiedDate'] = modifiedDate;
    data['id'] = id;
    data['name'] = name;
    data['director'] = director;
    data['phone'] = phone;
    data['suppliers'] = suppliers;
    return data;
  }

  @override
  String toString() {
    return 'Company{createdBy: $createdBy, createdDate: $createdDate, modifiedBy: $modifiedBy, modifiedDate: $modifiedDate, id: $id, name: $name, director: $director, phone: $phone, suppliers: $suppliers}';
  }
}
