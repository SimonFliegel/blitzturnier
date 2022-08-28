import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/attendee.dart';
import '../custom/custom_expansion_tile.dart';
import '../widgets/delete_dialog.dart';

class AttendeeEntry extends StatefulWidget {
  final MediaQueryData mediaQuery;
  final Attendee attendee;
  const AttendeeEntry(
    this.mediaQuery,
    this.attendee, {
    Key? key,
  }) : super(key: key);

  @override
  State<AttendeeEntry> createState() => _AttendeeEntryState();
}

class _AttendeeEntryState extends State<AttendeeEntry> {
  @override
  Widget build(BuildContext context) {
    final attendeeData = Provider.of<Attendees>(context);

    return Card(
      elevation: 3,
      child: CustomExpansionPile(
        height: widget.mediaQuery.size.height * 0.11,
        title: SizedBox(
          child: Row(
            children: [
              SizedBox(
                width: widget.mediaQuery.size.width * 0.4,
                child: Text(
                  widget.attendee.name,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              IconButton(
                padding: EdgeInsets.all(widget.mediaQuery.size.width * 0.05),
                onPressed: () => attendeeData.decreaseScore(widget.attendee),
                icon: const Icon(Icons.remove),
                iconSize: widget.mediaQuery.size.width * 0.1,
                color: Colors.red,
              ),
              SizedBox(
                width: widget.mediaQuery.size.width * 0.05,
                child: Text(
                  widget.attendee.score.toString(),
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              IconButton(
                padding: EdgeInsets.all(widget.mediaQuery.size.width * 0.025),
                onPressed: () => attendeeData.increaseScore(widget.attendee),
                icon: const Icon(Icons.add),
                iconSize: widget.mediaQuery.size.width * 0.1,
                color: Colors.green,
              ),
            ],
          ),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: widget.mediaQuery.size.width * 0.4,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: widget.mediaQuery.size.width * 0.025),
                      child: Text(
                        'Rang: ',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    Text(
                      '${widget.attendee.rank.toString()}.',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: widget.mediaQuery.size.width * 0.25),
                child: TextButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => DeleteDialog(
                            widget.attendee, attendeeData.deleteAttendee));
                    // attendeeData.deleteAttendee(widget.attendee);
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Entfernen'),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(Theme.of(context).errorColor),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
