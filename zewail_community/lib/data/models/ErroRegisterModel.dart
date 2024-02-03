class ErrorRegisterModel {
  Error? error;

  ErrorRegisterModel({this.error});

  ErrorRegisterModel.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    }
    return data;
  }
}

class Error {
  List<String>? stMobile;

  Error({this.stMobile});

  Error.fromJson(Map<String, dynamic> json) {
    stMobile = json['st_mobile'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['st_mobile'] = this.stMobile;
    return data;
  }
}
