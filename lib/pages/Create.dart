import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holiday2/helpers/Date.dart';
import 'package:holiday2/pages/Home.dart';
import 'package:holiday2/ui/DatePickerModal.dart';
import 'package:holiday2/ui/drawer.dart';

class CreatePage extends StatelessWidget {
  static const String route = '/create';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Create Holiday')),
        drawer: buildDrawer(context, route),
        body: CreateForm());
  }
}

// Create a Form widget.
class CreateForm extends StatefulWidget {
  @override
  CreateFormState createState() {
    return CreateFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class CreateFormState extends State<CreateForm> {
  TextEditingController _controller = TextEditingController(text: 'ddd');
  DateTime dateTimeFrom = DateTime.now();
  DateTime dateTimeTo = DateTime.now();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.create),
            title: new TextField(
              controller: _controller,
              decoration: new InputDecoration(
                hintText: "Title",
              ),
            ),
          ),
          new ListTile(
              leading: const Icon(Icons.today),
              title: const Text('Date From'),
              subtitle: Text(DateHelper.dateHourFormat(dateTimeFrom)),
              onTap: () {
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return new DatePickerModal(
                        widget: new CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.dateAndTime,
                      initialDateTime: dateTimeFrom,
                      onDateTimeChanged: (DateTime newDateTime) {
                        if (mounted) {
                          setState(() => dateTimeFrom = newDateTime);
                        }
                      },
                    ));
                  },
                );
              }),
          new ListTile(
              leading: const Icon(Icons.today),
              title: const Text('Date To'),
              subtitle: Text(DateHelper.dateHourFormat(dateTimeTo)),
              onTap: () {
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return new DatePickerModal(
                        widget: new CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.dateAndTime,
                      initialDateTime: dateTimeTo,
                      onDateTimeChanged: (DateTime newDateTime) {
                        if (mounted) {
                          setState(() => dateTimeTo = newDateTime);
                        }
                      },
                    ));
                  },
                );
              }),
          Align(
            alignment: AlignmentDirectional.center,
            child: RaisedButton(
              onPressed: () {
                String title = _controller.text.toString();

                Timer.run(() {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("""
Title: $title\n
Date From: $dateTimeFrom\n
Date To: $dateTimeTo\n
                        """),
                        );
                      });
                });

                Navigator.pushReplacementNamed(context, HomePage.route);
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
