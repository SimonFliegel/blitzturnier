import 'package:blitzturnier/models/attendee.dart';
import 'package:flutter/material.dart';

import 'attendee_screen.dart';
import 'results_screen.dart';
import '../widgets/new_attendee.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Attendee> _attendees = [
    Attendee('Sebastian'),
    Attendee('Theo'),
    Attendee('Vivien'),
    Attendee('Sebastian'),
    Attendee('Theo'),
    Attendee('Vivien'),
    Attendee('Sebastian'),
    Attendee('Theo'),
    Attendee('Vivien'),
    Attendee('Sebastian'),
    Attendee('Theo'),
    Attendee('Vivien'),
    Attendee('Sebastian'),
    Attendee('Theo'),
    Attendee('Vivien'),
    Attendee('Sebastian'),
    Attendee('Theo'),
    Attendee('Vivien'),
  ];
  List<Attendee> _rankedAttendees = [];

  void _startAddNewAttendee(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewAttendee(_addAttendee),
          );
        });
  }

  void _addAttendee(String name) {
    final newAttendee = Attendee(name);

    setState(() {
      _attendees.add(newAttendee);
      _attendees
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    });
    _updateRanks(_attendees);
  }

  void _increaseScore(Attendee attendee) {
    setState(() {
      attendee.score++;
    });
    _updateRanks(_attendees);
  }

  void _decreaseScore(Attendee attendee) {
    setState(() {
      if (attendee.score > 0) {
        attendee.score--;
      } else {
        return;
      }
    });
    _updateRanks(_attendees);
  }

  void _deleteAttendee(Attendee attendee) {
    setState(() {
      _attendees.remove(attendee);
    });
    _updateRanks(_attendees);
  }

// better solution with one single list?
  void _updateRanks(List<Attendee> attendeeList) {
    _rankedAttendees = List.from(attendeeList);
    _rankedAttendees.sort((a, b) => b.score.compareTo(a.score));

    int previousScore = 0;
    int rank = 1;
    for (var a in _rankedAttendees) {
      if (a.score < previousScore) {
        rank++;
      }
      previousScore = a.score;
      a.rank = rank;
    }

    for (int i = 0; i < _rankedAttendees.length; i++) {
      attendeeList[i].rank = _rankedAttendees[i].rank;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            AttendeeScreen(
              mediaQuery,
              _attendees,
              _startAddNewAttendee,
              _deleteAttendee,
              _increaseScore,
              _decreaseScore,
            ),
            ResultsScreen(mediaQuery, _rankedAttendees),
          ],
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.primary,
          child: TabBar(
            labelColor: Theme.of(context).colorScheme.secondary,
            indicatorColor: Theme.of(context).colorScheme.secondary,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.supervisor_account_rounded),
                text: 'Teilnehmer',
              ),
              Tab(
                icon: Icon(Icons.emoji_events),
                text: 'Ergebnisse',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
