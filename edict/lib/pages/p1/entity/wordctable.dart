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
    final Map<String, dynamic> data = {};
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
  String? tone;
  String? wordtrans;
  String? video;

  DataWord({this.id, this.wordname, this.tone, this.wordtrans, this.video});

  DataWord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wordname = json['wordname'];
    tone = json['tone'];
    wordtrans = json['wordtrans'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['wordname'] = wordname;

    ///音标
    data['tone'] = tone;
    data['wordtrans'] = wordtrans;
    data['video'] = video;
    return data;
  }
}
