class Response {
  final String status;
  final String message;
  final String url;

  Response(this.status, this.message, {this.url});

  Response.fromJson(Map<String, dynamic> map)
      : status = map['status'],
        message = map['msg'],
        url = map['url'];

  bool isOk() => status == 'OK';
  
  bool isError() => status == 'ERROR';
}
