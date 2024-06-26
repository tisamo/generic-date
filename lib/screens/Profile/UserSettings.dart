import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:generic_date/models/tag.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<UserSettings> {
  List<int> tags = [];
  List<Tag> options = [
    Tag(id: 1, name: 're'),
    Tag(id: 2, name: 'r22e'),
    Tag(id: 3, name: 'rere'),
    Tag(id: 4, name: 'ere')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ChipsChoice<int>.multiple(
          value: tags,
          onChanged: (val) => setState(() => tags = val),
          choiceItems: C2Choice.listFrom<int, Tag>(
            source: options,
            value: (i, v) => v.id,
            label: (i, v) => v.name,
          ),
        ),
      ),
    );
  }
}
