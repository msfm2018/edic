class GroupCTable {
  int? code;
  String? msg;
  List<Data>? data;

  GroupCTable({this.code, this.msg, this.data});

  GroupCTable.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? groupname;
  String? groupid;
  String? finish;

  Data({this.id, this.groupname, this.groupid, this.finish});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupname = json['groupname'];
    groupid = json['groupid'];
    finish = json['finish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['groupname'] = groupname;
    data['groupid'] = groupid;
    data['finish'] = finish;
    return data;
  }
}
