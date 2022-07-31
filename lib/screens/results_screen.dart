import 'package:flutter/material.dart';

import '../models/attendee.dart';

class ResultsScreen extends StatefulWidget {
  final MediaQueryData mediaQuery;
  List<Attendee> rankedAttendees;

  ResultsScreen(
    this.mediaQuery,
    this.rankedAttendees, {
    Key? key,
  }) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  List<bool> isSelected = [false];

  @override
  Widget build(BuildContext context) {
    Widget buildCircleAvatar(int index) {
      String? img;
      switch (widget.rankedAttendees[index].rank) {
        case 1:
          img = 'assets/images/firstplace.png';
          break;
        case 2:
          img = 'assets/images/secondplace.png';
          break;
        case 3:
          img = 'assets/images/thirdplace.png';
          break;
        default:
          img = null;
      }
      return img != null
          ? CircleAvatar(
              radius: 25,
              backgroundImage: Image.asset(img).image,
              backgroundColor: Colors.transparent,
            )
          : CircleAvatar(
              radius: 25,
              backgroundColor: Colors.transparent,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  ' ${widget.rankedAttendees[index].rank.toString()}.',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            );
    }

    return widget.rankedAttendees.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Ergebnisse'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.import_export),
                  onPressed: () {
                    setState(() {
                      widget.rankedAttendees =
                          widget.rankedAttendees.reversed.toList();
                    });
                  },
                ),
              ],
            ),
            body: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: widget.rankedAttendees.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: widget.mediaQuery.size.height * 0.146,
                  child: Card(
                    elevation: 3,
                    child: Center(
                      child: ListTile(
                        leading: Padding(
                          padding: EdgeInsets.only(
                              right: widget.mediaQuery.size.width * 0.075),
                          child: buildCircleAvatar(index),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.rankedAttendees[index].name,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                              widget.rankedAttendees[index].score.toString(),
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Ergebnisse'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'noch keine Punkte vergeben',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: widget.mediaQuery.size.height * 0.1),
                  SizedBox(
                    height: widget.mediaQuery.size.height * 0.4,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
