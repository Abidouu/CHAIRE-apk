

class Question {
  String? questionId;
  String? questionType;
  String? questionCorp;

  Question({this.questionId, this.questionType, this.questionCorp});


  // The two functions bellow are colled serializers for the model Question

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionId: json['questionId'] ,
      questionType: json['questionType'] ,
      questionCorp: json['questionCorp'] ,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionId'] = questionId;
    data['questionType'] = questionType;
    data['questionCorp'] = questionCorp;
    return data;
  }
}
