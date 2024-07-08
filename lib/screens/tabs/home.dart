import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:generic_date/services/event-service.dart';
import 'package:provider/provider.dart';
import '../../models/event.dart';
import '../../provider/userlist-provider.dart';
import '../../shared/elements/bottom-nav.dart';

late List<Event> events;

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

                FutureBuilder<List<Event>>(
                    future: _fetchEvent(),
                    builder: (context, AsyncSnapshot<List<Event>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        if(snapshot.data?.length == 0 || snapshot.data == null){
                          return const Padding(padding: EdgeInsets.only(top: 20), child:Text('Nincs esemény'));
                        }
                        else{
                          return ListView.builder(
                              itemCount: snapshot.data?.length,
                              padding: const EdgeInsets.only(top: 20),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (_, int index) {
                                return Text('${snapshot.data?[index].name}');
                              });
                        }
                        }

                    }),
              ],
            ))),
        bottomNavigationBar: const BottomNav());
  }
}

  Future<List<Event>>_fetchEvent()  async  {
   return await getEvents();
}
