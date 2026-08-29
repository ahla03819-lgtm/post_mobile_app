class RegisterResponse {
  RegisterResponse({
    this.message,
    this.messageKh,
    this.messageCh,
    this.code,
    this.data,
  });

  RegisterResponse.fromJson(dynamic json) {
    message = json['message'];
    messageKh = json['messageKh'];
    messageCh = json['messageCh'];
    code = json['code'];
    data = json['data'];
  }

  String? message;
  String? messageKh;
  String? messageCh;
  String? code;
  dynamic data;
}
