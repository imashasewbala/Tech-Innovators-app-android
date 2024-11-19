// feedback.dart
class FeedbackModel {
  String userMail;
  String message;
  String question1;
  String question2;
  String question3;
  int rating;

  FeedbackModel({
    required this.userMail,
    required this.message,
    required this.question1,
    required this.question2,
    required this.question3,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_mail': userMail,
      'message': message,
      'question1': question1,
      'question2': question2,
      'question3': question3,
      'rating': rating,
    };
  }
}
