class LocalFeedback {
  // int id;
  String email;
  String message;
  int rating;

  LocalFeedback({required this.email,required this.message, required this.rating});

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'email':email,
      'message': message,
      'rating': rating,
    };
  }
}