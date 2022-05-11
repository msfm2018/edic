class WordCTable {
  int? code;
  String? msg;
  List<DataWord>? data;

  WordCTable({this.code, this.msg, this.data});

  WordCTable.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <DataWord>[];
      json['data'].forEach((v) {
        data!.add(DataWord.fromJson(v));
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

class DataWord {
  int? id;
  String? wordname;
  String? wordtrans;

  DataWord({this.id, this.wordname, this.wordtrans});

  DataWord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wordname = json['wordname'];
    wordtrans = json['wordtrans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['wordname'] = wordname;
    data['wordtrans'] = wordtrans;
    return data;
  }
}
