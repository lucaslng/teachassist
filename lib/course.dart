import 'package:flutter/material.dart';

class Course {
  String code = "";
  String name = "";
  String period = "";
  String room = "";
  DateTime startDate = DateTime(0);
  DateTime endDate = DateTime(0);
  bool hasFinal = false;
  bool hasMidterm = false;
  int finalOrMidtermMark = 0;
  bool hasMark = false;
  String markString = "-1";
  Uri url = Uri();
  Course(this.code, this.name, this.period, this.room, this.startDate, this.endDate, this.hasFinal, this.hasMidterm, this.finalOrMidtermMark, this.hasMark, this.markString, this.url);

  List<Assignment> assignments = [];

  double getMark() {
    if (!isLevel()) {
      return double.parse(markString);
    } else {
      return -1;
    }
  }

  bool isFailing() {
    if (getMark() < 50) {
      return true;
    } else {
      return false;
    }
  }
  
  bool isLevel() {
    if (markString.contains(RegExp("[^0-9.]"))) {
      return true;
    } else {
      return false;
    }
  }

  String status() {
    if (endDate.isAfter(DateTime.now()) && startDate.isBefore(DateTime.now())) {
      return "ongoing";
    } else if (endDate.isBefore(DateTime.now())) {
      return "completed";
    } else if (startDate.isAfter(DateTime.now())) {
      return "upcoming";
    } else {
      return "unknown";
    }
  }

}

class Assignment {
  final String name;
  final List<Mark> marks = [];
  final String feedback;
  Assignment({required this.name, required this.feedback});
}

class Mark {
  final double mark;
  final int total;
  final int percent;
  final double weight;
  const Mark({required this.mark, required this.total, required this.percent, required this.weight});
}