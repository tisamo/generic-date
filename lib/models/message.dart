class Message{
  Message({
    required this.message
});
  String message;

  Map<String, dynamic> toJson() => {"message": message,};

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
    );
  }

}
