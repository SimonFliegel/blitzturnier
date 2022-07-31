import 'package:flutter/material.dart';

import '../widgets/attendee_list.dart';
import '../widgets/new_attendee.dart';

import '../models/attendee.dart';

class AttendeeScreen extends StatefulWidget {
  final MediaQueryData mediaQuery;
  final List<Attendee> attendees;
  final Function addAttendee;
  final Function delAttendee;
  final Function incrScore;
  final Function decrScore;

  const AttendeeScreen(
    this.mediaQuery,
    this.attendees,
    this.addAttendee,
    this.delAttendee,
    this.incrScore,
    this.decrScore, {
    Key? key,
  }) : super(key: key);

  @override
  State<AttendeeScreen> createState() => _AttendeeScreenState();
}

class _AttendeeScreenState extends State<AttendeeScreen> {
  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: const Text('Teilnehmerliste'),
      actions: <Widget>[
        IconButton(
          onPressed: () => widget.addAttendee(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        height: widget.mediaQuery.size.height -
            appBar.preferredSize.height -
            widget.mediaQuery.padding.top,
        child: AttendeeList(
          widget.mediaQuery,
          widget.attendees,
          widget.delAttendee,
          widget.incrScore,
          widget.decrScore,
        ),
      ),
    );
  }
}
