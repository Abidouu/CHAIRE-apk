

class Media {
  String? mediaId;
  String? mediaType;
  String? mediaUrl;
  String? mediaDescription;
  String? userId;
  String? dowarId;


  Media({
    this.mediaId,
    this.mediaType,
    this.mediaUrl,
    this.mediaDescription,
    this.userId,
    this.dowarId,
  });

  // Convert Media object to JSON
  Map<String, dynamic> toJson() {
    return {
      'mediaId' : mediaId,
      'mediaType': mediaType,
      'mediaUrl': mediaUrl,
      'mediaDescription': mediaDescription,
      'uploaderId': userId,
      'dowarId': dowarId,
    };
  }

  // Create Media object from JSON
  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      mediaId: json['mediaId'],
      mediaType: json['mediaType'],
      mediaUrl: json['mediaUrl'],
      mediaDescription: json['mediaDescription'],
      userId: json['userId'],
      dowarId: json['dowarId'],
    );
  }
}

