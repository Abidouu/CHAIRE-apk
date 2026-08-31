class Dowar {
  String? douwarId;
  String? dowarName;
  String? intervalId;

  Dowar({
    this.douwarId,
    this.dowarName,
    this.intervalId
  });

  factory Dowar.fromJson(Map<String, dynamic> json) => Dowar(
        douwarId: json['douwarId'],
        dowarName: json['dowarName'],
        intervalId: json['intervalId'],
      );

  Map<String, dynamic> toJson() => {
        'douwarId': douwarId,
        'dowarName': dowarName,
        'intervalId': intervalId,
      };
}
