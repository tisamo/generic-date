import 'package:flutter/material.dart';
import 'package:generic_date/screens/authentication/namedate.dart';
import 'package:generic_date/screens/authentication/verification.dart';
import 'package:generic_date/services/event-service.dart';
import 'package:generic_date/shared/layout/simple_layout.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';
import '../../models/event.dart';
import '../../models/user.dart';
import '../../provider/userlist-provider.dart';
import '../../shared/styles/colors.dart';
import '../Profile/profile-settings.dart';

late List<Event> events;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      UserProvider provider = Provider.of<UserProvider>(context, listen: false);
      if(provider.user == null){
        await provider.getUser();
      }
      await _fetchUsers(provider);
    });
  }

  Future<void> _fetchUsers(UserProvider provider) async {
    if(provider.queriedUsers.isEmpty){
      List<User>? fetchedUsers = await provider.getUsers();
      if(fetchedUsers != null){
        setState(() {
          provider.queriedUsers = fetchedUsers;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    double maxWidth = width > 620 ? 600 : width - 20;
    double maxHeight = height > 900 ? 750 : height - 180;

    return SimpleLayout(
      layout: Consumer<UserProvider>(builder: (context, userProvider, child) {
        if (userProvider.user == null) {
          return const Center(
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(
                    child: Text("No user found"),
                  )));
        } else {
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(color: ColorTheme.primaryColor)),
                  Expanded(
                      flex: 1,
                      child: Container(color: ColorTheme.secondaryColor)),
                  Expanded(
                      flex: 1, child: Container(color: Colors.orangeAccent)),
                ],
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: maxWidth,
                        height: maxHeight,
                        child: userProvider.queriedUsers == null
                            ? const CircularProgressIndicator()
                            : userProvider.queriedUsers.isEmpty
                                ? const Text(
                                    "No data")
                                : Stack(
                                    children: [
                                      ...userProvider.queriedUsers.map((user) {
                                        return Stack(
                                          children: [
                                        Positioned.fill(
                                        child: Image.network(
                                          'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                          fit: BoxFit
                                              .cover, // You can also try BoxFit.fill if you want to stretch the image
                                        )),
                                        Positioned(
                                          bottom: 50,
                                          left: 20,
                                          child: Text(user.username!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),)
                                        ),
                                            Positioned(
                                                bottom: 20,
                                                left: 20,
                                                child: Text(user.birthday!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), )
                                            )

                                          ],
                                        );

                                      }).toList()
                                    ],
                                  ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (userProvider.queriedUsers.isEmpty) {
                        return;
                      }
                        userProvider.removeLastItemFromQueriedList();
                      if (userProvider.queriedUsers.isEmpty) {
                        await _fetchUsers(userProvider);
                      }
                    },
                    child: Container(
                      width: maxWidth,
                      color: Colors.white,
                      height: 80,
                    ),
                  )
                ],
              ),
            ],
          );
        }
      }),
      title: 'Home',
      hideAppbar: true,
    );
  }
}
