import 'package:teachassist/utils/coursedata/mark.dart';

class Assignment {
  final String name;
  final List<Mark> marks = [];
  final String feedback;
  Assignment({required this.name, required this.feedback});
}
