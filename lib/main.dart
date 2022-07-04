import 'package:flutter/material.dart';

import './widgets/attendee_list.dart';
import './widgets/new_attendee.dart';

import '../models/attendee.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blitzturnier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              headline5: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
              headline4: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.normal,
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
      ),
      home: const MyHomePage(title: 'Teilnehmer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Attendee> _attendees = [
    // Attendee('Sebastian'),
    // Attendee('Theo'),
    // Attendee('Vivien'),
    // Attendee('Sebastian'),
    // Attendee('Theo'),
    // Attendee('Vivien'),
    // Attendee('Sebastian'),
    // Attendee('Theo'),
    // Attendee('Vivien'),
    // Attendee('Sebastian'),
    // Attendee('Theo'),
    // Attendee('Vivien'),
    // Attendee('Sebastian'),
    // Attendee('Theo'),
    // Attendee('Vivien'),
    // Attendee('Sebastian'),
    // Attendee('Theo'),
    // Attendee('Vivien'),
  ];

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
  }

  void _increaseScore(Attendee attendee) {
    setState(() {
      attendee.score++;
    });
  }

  void _decreaseScore(Attendee attendee) {
    setState(() {
      if (attendee.score > 0) {
        attendee.score--;
      } else {
        return;
      }
    });
  }

  void _deleteAttendee(Attendee attendee) {
    setState(() {
      _attendees.remove(attendee);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewAttendee(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );

    return Scaffold(
        appBar: appBar,
        body: Container(
          height: mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top,
          child: AttendeeList(mediaQuery, _attendees, _increaseScore,
              _decreaseScore, _deleteAttendee),
        ));
  }
}
