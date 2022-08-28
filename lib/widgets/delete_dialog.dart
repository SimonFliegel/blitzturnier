import 'package:flutter/material.dart';

import '../providers/attendee.dart';

class DeleteDialog extends StatelessWidget {
  final Attendee attendee;
  final Function deleteHandler;

  const DeleteDialog(
    this.attendee,
    this.deleteHandler, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Teilnehmer entfernen',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontFamily: 'Open Sans',
            color: Colors.black,
            fontSize: 18,
          ),
          children: <TextSpan>[
            const TextSpan(text: 'Soll Teilnehmer/-in '),
            TextSpan(
              text: attendee.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(
                text:
                    ' wirklich aus dem Turnier entfernt werden?\n\nDer Rang und die gesammelten Punkte gehen dabei verloren.'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Nein'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Ja'),
          onPressed: () {
            Navigator.of(context).pop();
            deleteHandler(attendee);
          },
        ),
      ],
    );
  }
}
