import 'package:coffe_zone/class/question.dart';

class FeedbackCategory {
  final String category;
  final List<Question> questions;

  FeedbackCategory({required this.category, required this.questions});

  factory FeedbackCategory.fromJson(Map<String, dynamic> json, String categoryName) {
    List<Question> questions = (json[categoryName] as List).map((q) => Question.fromJson(q)).toList();
    return FeedbackCategory(category: categoryName, questions: questions);
  }
}