class Response {
  final String status;
  final String message;

  Response(this.status, this.message);

  Response.fromJson(Map<String, dynamic> map)
      : status = map['status'],
        message = map['msg'];

  bool isOk() => status == 'OK';
}
