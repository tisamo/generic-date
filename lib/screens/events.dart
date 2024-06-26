import '../models/event.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  EventsScreen({Key? key}) : super(key: key);

  Future<List<Event>>? events;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Events'),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Text('Events'),
            ),
          ],
        ),
      ),
    );
  }
}
