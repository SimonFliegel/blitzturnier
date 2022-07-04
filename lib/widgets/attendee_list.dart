import 'package:flutter/material.dart';

import '../models/attendee.dart';

class AttendeeList extends StatelessWidget {
  final List<Attendee> attendees;
  final MediaQueryData mediaQuery;
  final Function incrScore;
  final Function decrScore;
  final Function delScore;

  const AttendeeList(
    this.mediaQuery,
    this.attendees,
    this.incrScore,
    this.decrScore,
    this.delScore, {
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
          child: ExpansionTile(
            title: Row(
              children: [
                SizedBox(
                    width: mediaQuery.size.width * 0.5,
                    child: Text(
                      attendees[index].name,
                      style: Theme.of(context).textTheme.headline5,
                    )),
                SizedBox(
                  width: mediaQuery.size.width * 0.15,
                  child: Text(
                    attendees[index].score.toString(),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                SizedBox(
                  width: mediaQuery.size.width * 0.15,
                  child: Text(
                    '${attendees[index].rank.toString()}.',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(right: mediaQuery.size.width * 0.25),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          padding: EdgeInsets.only(
                            right: mediaQuery.size.width * 0.025,
                          ),
                          onPressed: () => incrScore(attendees[index]),
                          icon: const Icon(Icons.add_circle),
                          iconSize: mediaQuery.size.width * 0.1,
                          color: Colors.green,
                        ),
                        IconButton(
                          padding: EdgeInsets.only(
                            left: mediaQuery.size.width * 0.025,
                          ),
                          onPressed: () => decrScore(attendees[index]),
                          icon: const Icon(Icons.remove_circle),
                          iconSize: mediaQuery.size.width * 0.1,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    padding:
                        EdgeInsets.only(left: mediaQuery.size.width * 0.25),
                    onPressed: () => delScore(attendees[index]),
                    icon: const Icon(Icons.delete),
                    iconSize: mediaQuery.size.width * 0.1,
                    color: Theme.of(context).errorColor,
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
