import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:generic_date/models/user.dart';
import 'package:generic_date/services/user.service.dart';
import 'package:provider/provider.dart';
import '../../provider/userlist-provider.dart';
import '../../shared/elements/bottom-nav.dart';

 List<User>? users;

class Swiper extends StatelessWidget {
  const Swiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Home'),
          automaticallyImplyLeading: false,
        ),
        body: Consumer<UserProvider>(
            builder: (context, userProvider, child) => Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    if (!userProvider.isAuthenticated) ...[
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
                        future: _fetchUsers(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // While waiting for the data to load
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            print(snapshot);
                            return Text('fos');
                          } else {
                            // When data is successfully fetched
                            if (users?.length == 0 || users == null) {
                              return Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text('Nincs esemény'));
                            } else {
                              return Container(
                                  child: ListView.builder(
                                itemCount: users?.length,
                                padding: EdgeInsets.only(top: 20),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final item = users![index];
                                  return Dismissible(
                                    key: Key('item_$index'),
                                    onDismissed: (direction) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('$item dismissed')));
                                    },
                                    child: ListTile(
                                      title: Text(item.name),
                                    ),
                                  );
                                },
                              ));
                            }
                          }
                        }),
                  ],
                ))),
        bottomNavigationBar: const BottomNav());
  }
}

_fetchUsers() async {
  List<User> userResponse = await getUsers();
  users = userResponse;
  return users;
}
