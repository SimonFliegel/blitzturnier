import 'package:flutter/material.dart';

import 'attendee_screen.dart';
import 'results_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            AttendeeScreen(mediaQuery),
            ResultsScreen(mediaQuery),
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
