import 'package:flutter/material.dart';
import 'package:generic_date/provider/token-service.dart';
import 'package:generic_date/shared/layout/simple_layout.dart';
import 'package:generic_date/shared/styles/colors.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double maxWidth = width > 400 ? 400 : width - 20;
    return SimpleLayout(
        layout: Center(
          child: Container(
              width: width - 20,
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250,
                    width: maxWidth,
                    child: Card(
                      shadowColor: ColorTheme.secondaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(75.0),
                                  child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFe0f2f1),
                                    ),
                                  )),
                              // Edit icon
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.5),
                                    radius: 20.0,
                                    child: IconButton(
                                      icon: Icon(Icons.edit,
                                          color: Colors.white, size: 20.0),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/profile-settings');
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('name'),
                              SizedBox(
                                width: 10,
                              ),
                              Text('25')
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              ColorTheme.primaryColor)),
                      onPressed: () async {
                        await logout();
                      },
                      child: const Text(
                        "Log Out",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              )),
        ),
        title: 'Profile');
  }
}
