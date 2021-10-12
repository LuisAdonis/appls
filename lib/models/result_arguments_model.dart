import 'package:appls/models/question.dart';

class ResultArguments {
  final int score;
  final List<Question> questions;
  final int totalTime;

  const ResultArguments({required this.score, required this.questions, required this.totalTime});
}
