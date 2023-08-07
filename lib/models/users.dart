class Users{

 /* "createdBy": null,
  "createdDate": "2023-08-07T04:24:42.168+00:00",
  "modifiedBy": null,
  "modifiedDate": "2023-08-07T04:24:42.168+00:00",
  "id": 2,
  "fullName": "Soliyev Alijon(Manager)",
  "username": "+101",
  "password": "$2a$10$qhx6UM2sTOgnykxfz8e8o.NxmQn9/jrRl8gJU32JOMxIBDSFFyql6",
  "fcmToken": null,
  "role": {
  "id": 2,
  "name": "ROLE_MANAGER"
  },
  "company": null,
  "supplier": null*/

  late int createdBy;
  late String createdDate;
  late int modifiedBy;
  late String modifiedDate;
  late int id;
  late String fullName;
  late String username;
  late String password;
  late String fcmToken;
  late Role role;
  late Company company;
  late Supplier supplier;


  Users({required this.createdBy,required this.createdDate,required this.modifiedBy,required this.modifiedDate,required this.id,required this.fullName,required this.username,required this.password,required this.fcmToken,required this.role,required this.company,required this.supplier});

  Users.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'] ?? 0;
    createdDate = json['createdDate'] ?? '';
    modifiedBy = json['modifiedBy'] ?? 0;
    modifiedDate = json['modifiedDate'] ?? '';
    id = json['id'] ?? 0;
    fullName = json['fullName'] ?? '';
    username = json['username'] ?? '';
    password = json['password'] ?? '';
    fcmToken = json['fcmToken'] ?? '';
    role = (json['role'] != null ? Role.fromJson(json['role']) : Role(id: 0, name: ''));
    company = (json['company'] != null ? Company.fromJson(json['company']) : Company( id: 0, name: '', createdBy: 1, createdDate: '', modifiedBy: 1, modifiedDate: '', director: '', phone: ''));
    supplier = (json['supplier'] != null ? Supplier.fromJson(json['supplier']) : Supplier(id: 0, name: '', info: ''));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdBy'] = createdBy ?? 0;
    data['createdDate'] = createdDate ?? '';
    data['modifiedBy'] = modifiedBy ?? '';
    data['modifiedDate'] = modifiedDate ?? '';
    data['id'] = id ?? 0;
    data['fullName'] = fullName ?? '';
    data['username'] = username ?? '';
    data['password'] = password ?? '';
    data['fcmToken'] = fcmToken ?? '';
    data['role'] = role != null ? role.toJson() : Role(id: 0, name: '');
    data['company'] = company != null ? company.toJson() : Company( id: 0, name: '', createdBy: 1, createdDate: '', modifiedBy: 1, modifiedDate: '', director: '', phone: '');
    data['supplier'] = supplier != null ? supplier.toJson() : Supplier(id: 0, name: '', info: '');
    return data;
  }

  @override
  String toString() {
    return 'Users{createdBy: $createdBy, createdDate: $createdDate, modifiedBy: $modifiedBy, modifiedDate: $modifiedDate, id: $id, fullName: $fullName, username: $username, password: $password, fcmToken: $fcmToken, role: $role, company: $company, supplier: $supplier}';
  }
}

class Role {
  late int id;
  late String name;

  Role({required this.id,required this.name});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    return 'Role{id: $id, name: $name}';
  }
}

class Company {
  late int createdBy;
  late String createdDate;
  late int modifiedBy;
  late String modifiedDate;
  late int id;
  late String name;
  late String director;
  late String phone;

  Company({required this.createdBy,required this.createdDate,required this.modifiedBy,required this.modifiedDate,required this.id,required this.name,required this.director,required this.phone});

  Company.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'] ?? 0;
    createdDate = json['createdDate'] ?? '';
    modifiedBy = json['modifiedBy'] ?? 0;
    modifiedDate = json['modifiedDate'] ?? '';
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    director = json['director'] ?? '';
    phone = json['phone'] ?? '';
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
    return data;
  }

  @override
  String toString() {
    return 'Company{createdBy: $createdBy, createdDate: $createdDate, modifiedBy: $modifiedBy, modifiedDate: $modifiedDate, id: $id, name: $name, director: $director, phone: $phone}';
  }

}

class Supplier {
  late int id;
  late String name;
  late String info;

  Supplier({required this.id,required this.name,required this.info});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    info = json['info'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['info'] = info;
    return data;
  }

  @override
  String toString() {
    return 'Supplier{id: $id, name: $name, info: $info}';
  }
}