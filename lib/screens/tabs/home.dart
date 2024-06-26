import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:generic_date/services/event-service.dart';
import 'package:provider/provider.dart';
import '../../models/event.dart';
import '../../provider/userlist-provider.dart';
import '../../shared/elements/bottom-nav.dart';

late List<Event>? events;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Home'),
          automaticallyImplyLeading: false,
        ),

    body: Consumer<UserProvider>(
      builder: (context, userProvider, child) =>
        Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                if(!userProvider.isAuthenticated) ...[
                TextButton(
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.amberAccent,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
                ],

                FutureBuilder(
                    future: _fetchEvent(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // While waiting for the data to load
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('fos');
                      } else {
                        if(events?.length == 0 || events == null){
                          return Padding(padding: EdgeInsets.only(top: 20), child:Text('Nincs esemény'));
                        }
                        else{
                          return Container(
                              child: ListView.builder(
                                  itemCount: events?.length,
                                  padding: EdgeInsets.only(top: 20),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Text('${events?[index].name}');
                                  }));
                        }
                        }

                    }),
              ],
            ))),
        bottomNavigationBar: const BottomNav());
  }
}

_fetchEvent() async {
  List<Event>? event = await getEvents();
  events = event;
  return event;
}
