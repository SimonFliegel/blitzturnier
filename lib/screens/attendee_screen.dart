import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/new_attendee.dart';
import '../widgets/attendee_entry.dart';

import '../providers/attendee.dart';

class AttendeeScreen extends StatefulWidget {
  final MediaQueryData mediaQuery;

  const AttendeeScreen(
    this.mediaQuery, {
    Key? key,
  }) : super(key: key);

  @override
  State<AttendeeScreen> createState() => _AttendeeScreenState();

  void _createNewAttendee(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewAttendee(
                Provider.of<Attendees>(ctx, listen: false).addAttendee),
          );
        });
  }
}

class _AttendeeScreenState extends State<AttendeeScreen> {
  late int selected;

  @override
  Widget build(BuildContext context) {
    final attendees = Provider.of<Attendees>(context).attendees;
    final AppBar appBar = AppBar(
      title: const Text(
        'Teilnehmerliste',
        style: TextStyle(
          fontSize: 26,
        ),
      ),
      toolbarHeight: widget.mediaQuery.size.height * 0.08,
      actions: <Widget>[
        IconButton(
          padding: EdgeInsets.all(widget.mediaQuery.size.width * 0.03),
          iconSize: widget.mediaQuery.size.width * 0.09,
          icon: const Icon(Icons.add),
          onPressed: () => widget._createNewAttendee(context),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        height: widget.mediaQuery.size.height -
            appBar.preferredSize.height -
            widget.mediaQuery.padding.top,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: attendees.length,
          itemBuilder: (ctx, index) {
            return AttendeeEntry(widget.mediaQuery, attendees[index]);
          },
        ),
      ),
    );
  }
}
