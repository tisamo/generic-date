import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:generic_date/models/login-into.dart';
import 'package:generic_date/provider/userlist-provider.dart';
import 'package:generic_date/shared/elements/navigation-element.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/regexes/regexes.dart' as regex;
import '../../models/user.dart';

getWidth(screenWidth) {
  if (screenWidth > 350) {
    return 350;
  }
  return screenWidth;
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

Future<void> saveTokenToStorage(String token) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
}

class MyCustomFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();
  final userController = TextEditingController(text: 'kek');
  final passController = TextEditingController(text: 'kek');



  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: getWidth(MediaQuery.of(context).size.width),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                    child: TextFormField(
                      controller: userController,
                      validator: (value) {
                        if (!regex.isValidEmail(value)) {
                          return 'Enter valid email please';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: 'email'),
                      obscureText: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: TextFormField(
                        controller: passController,
                        decoration: const InputDecoration(hintText: 'password'),
                        obscureText: true,
                        validator: (val) {
                          if (val == null || val.length < 7) {
                            return 'Enter valid password';
                          }
                          return null;
                        }),
                  ),
                  Consumer<UserProvider>(
                    builder: (context, userProvider, child) => Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              LoginInfo logInfo = LoginInfo(
                                  email: userController.text,
                                  password: passController.text);
                              var token = await userProvider.login(logInfo);
                              await userProvider.authenticate(token!);
                              if (token != null) {
                                 await saveTokenToStorage(token);
                                 Navigator.pushNamed(context, '/');
                              }
                            }
                          },
                            child: const Text('Login'),
                        )),
                  ),
                ],
              ),
            ),
          ),
          NavigationText(
              text: 'Nincs felhasználód?', route: '/register', padding: 30),
          NavigationText(text: 'Vissza a főoldalra', route: '/'),
        ],
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _UsersState();
}

class _UsersState extends State<LoginScreen> {
  late Future<User> user;

  @override
  void initState() {
    super.initState();
    /* makeGetRequest('users').then((userss) => {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Provider.of<UserProvider>(context, listen: false)
                .SetUser(User.fromJson(userss));
          })

       });
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 100),
              child: Text(
                'Login',
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
             LoginForm(),
          ],
        )
      ]),
    );
  }
}
