class RemoteResponseModel {
  String? title;
  List<Rows>? rows;

  RemoteResponseModel({this.title, this.rows});

  RemoteResponseModel.fromJson(Map<String, dynamic> json) {
    title = json['title']??"N/A";
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(new Rows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rows {
  String? title;
  String? description;
  String? imageHref;

  Rows({this.title, this.description, this.imageHref});

  Rows.fromJson(Map<String, dynamic> json) {
    title = json['title']??"N/A";
    description = json['description']??"N/A";
    imageHref = json['imageHref']??"N/A";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['imageHref'] = this.imageHref;
    return data;
  }
}