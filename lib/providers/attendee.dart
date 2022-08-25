import 'package:flutter/widgets.dart';

class Attendee {
  int id;
  final String name;
  int score = 0;
  int rank = 0;

  Attendee(this.id, this.name);
}

class Attendees with ChangeNotifier {
  final List<Attendee> _attendees = [
    Attendee(1, 'Sebastian'),
    Attendee(2, 'Theo'),
    Attendee(3, 'Vivien'),
    Attendee(4, 'Sebastian'),
    Attendee(5, 'Theo'),
    Attendee(6, 'Vivien'),
    Attendee(7, 'Sebastian'),
    Attendee(8, 'Theo'),
    Attendee(9, 'Vivien'),
  ];
  List<Attendee> _rankedAttendees = [];

  List<Attendee> get attendees {
    return [..._attendees];
  }

  List<Attendee> get rankedAttendees {
    return [..._rankedAttendees];
  }

  void addAttendee(String name) {
    final newAttendee = Attendee(_attendees.length + 1, name);

    _attendees.add(newAttendee);
    _attendees
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    updateRanks(_attendees);
    notifyListeners();
  }

  void increaseScore(Attendee attendee) {
    attendee.score++;
    updateRanks(_attendees);
    notifyListeners();
  }

  void decreaseScore(Attendee attendee) {
    if (attendee.score > 0) {
      attendee.score--;
    } else {
      return;
    }
    updateRanks(_attendees);
    notifyListeners();
  }

  void deleteAttendee(Attendee attendee) {
    _attendees.remove(attendee);
    updateRanks(_attendees);
    notifyListeners();
  }

  void updateRanks(List<Attendee> attendeeList) {
    _rankedAttendees = List.from(attendeeList);
    _rankedAttendees.sort((a, b) => b.score.compareTo(a.score));

    int previousScore = 0;
    int rank = 1;
    for (var a in _rankedAttendees) {
      if (a.score < previousScore) {
        rank++;
      }
      previousScore = a.score;
      // backsync. to attendeeList
      var matchingAttendee =
          attendeeList.firstWhere((attendee) => attendee.id == a.id);
      matchingAttendee.rank = rank;
    }
  }
}
