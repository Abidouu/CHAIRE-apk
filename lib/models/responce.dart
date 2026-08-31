



class Response {
  String? responseId;
  DateTime? responseDate;
  String? responseCorp;
  String? questionId;
  String? userId;
  String? dowarId;

  Response({
    this.responseId,
    this.responseDate,
    this.responseCorp,
    this.questionId,
    this.userId,
    this.dowarId,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      responseId: json['responseId'] ,
      responseDate: DateTime.parse(json['responseDate'] as String? ?? ''),
      responseCorp: json['responseCorp'] as String?,
      questionId: json['questionId'] ,
      userId: json['userId'] ,
      dowarId: json['dowarId'] ,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['responseId'] = responseId;
    data['responseDate'] = responseDate?.toIso8601String();
    data['responseCorp'] = responseCorp;
    data['questionId'] = questionId;
    data['user'] = userId;
    data['dowar'] = dowarId;
    return data;
  }
}
