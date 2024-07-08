class LocalFeedback {
  // int id;
  String message;
  int rating;

  LocalFeedback({required this.message, required this.rating});

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'message': message,
      'rating': rating,
    };
  }
}