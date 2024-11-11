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
  double mark = 0;
  Uri url = Uri();
  Course(this.code, this.name, this.period, this.room, this.startDate, this.endDate, this.hasFinal, this.hasMidterm, this.finalOrMidtermMark, this.hasMark, this.mark, this.url);

  bool isFailing() {
    if (mark < 50) {
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