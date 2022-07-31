import 'package:flutter/material.dart';

import '../models/attendee.dart';

class AttendeeList extends StatelessWidget {
  final MediaQueryData mediaQuery;
  final List<Attendee> attendees;
  final Function delAttendee;
  final Function incrScore;
  final Function decrScore;

  const AttendeeList(
    this.mediaQuery,
    this.attendees,
    this.delAttendee,
    this.incrScore,
    this.decrScore, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: attendees.length,
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 3,
          child: ExpansionTile(
            title: Row(
              children: [
                SizedBox(
                  width: mediaQuery.size.width * 0.4,
                  child: Text(
                    attendees[index].name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.all(mediaQuery.size.width * 0.05),
                  onPressed: () => decrScore(attendees[index]),
                  icon: const Icon(Icons.remove),
                  iconSize: mediaQuery.size.width * 0.1,
                  color: Colors.red,
                ),
                SizedBox(
                  width: mediaQuery.size.width * 0.05,
                  child: Text(
                    attendees[index].score.toString(),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.all(mediaQuery.size.width * 0.025),
                  onPressed: () => incrScore(attendees[index]),
                  icon: const Icon(Icons.add),
                  iconSize: mediaQuery.size.width * 0.1,
                  color: Colors.green,
                ),
              ],
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: mediaQuery.size.width * 0.4,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: mediaQuery.size.width * 0.025),
                          child: Text(
                            'Rang: ',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                        Text(
                          '${attendees[index].rank.toString()}.',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: mediaQuery.size.width * 0.25),
                    child: TextButton.icon(
                      onPressed: () => delAttendee(attendees[index]),
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                            Theme.of(context).errorColor),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
