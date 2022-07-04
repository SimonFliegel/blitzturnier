import 'dart:io';

import 'package:flutter/material.dart';

class NewAttendee extends StatefulWidget {
  final Function addAttendee;

  const NewAttendee(this.addAttendee, {Key? key}) : super(key: key);

  @override
  State<NewAttendee> createState() => _NewAttendeeState();
}

class _NewAttendeeState extends State<NewAttendee> {
  final _nameController = TextEditingController();

  void _submitData() {
    if (_nameController.text.isEmpty) {
      return;
    }
    final enteredText = _nameController.text;

    widget.addAttendee(enteredText);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                controller: _nameController,
                onSubmitted: (_) => _submitData(),
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text('Teilnehmer hinzufügen'),
            )
          ],
        ),
      ),
    );
  }
}
