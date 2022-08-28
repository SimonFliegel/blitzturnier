import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/attendee.dart';

class ResultsScreen extends StatefulWidget {
  final MediaQueryData mediaQuery;

  const ResultsScreen(
    this.mediaQuery, {
    Key? key,
  }) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  bool isReversed = false;
  @override
  Widget build(BuildContext context) {
    var rankedAttendees =
        Provider.of<Attendees>(context, listen: false).rankedAttendees;

    Widget buildCircleAvatar(List<Attendee> rankedAttendees, int index) {
      String? img;
      switch (rankedAttendees[index].rank) {
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
                  ' ${rankedAttendees[index].rank.toString()}.',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            );
    }

    Widget buildResultsList(List<Attendee> rankedAttendees) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: rankedAttendees.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            child: SizedBox(
              height: widget.mediaQuery.size.height * 0.1125,
              child: Center(
                child: ListTile(
                  leading: Padding(
                    padding: EdgeInsets.only(
                        right: widget.mediaQuery.size.width * 0.075),
                    child: buildCircleAvatar(rankedAttendees, index),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        rankedAttendees[index].name,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        rankedAttendees[index].score.toString(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return rankedAttendees.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              title: const Text(
                'Ergebnisse',
                style: TextStyle(fontSize: 26),
              ),
              toolbarHeight: widget.mediaQuery.size.height * 0.08,
              actions: <Widget>[
                IconButton(
                  padding: EdgeInsets.all(widget.mediaQuery.size.width * 0.04),
                  icon: const Icon(Icons.import_export),
                  iconSize: widget.mediaQuery.size.width * 0.09,
                  onPressed: () {
                    setState(() {
                      isReversed = !isReversed;
                    });
                  },
                ),
              ],
            ),
            body: isReversed
                ? buildResultsList(rankedAttendees.reversed.toList())
                : buildResultsList(rankedAttendees))
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Ergebnisse',
                style: TextStyle(fontSize: 26),
              ),
              toolbarHeight: widget.mediaQuery.size.height * 0.08,
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
