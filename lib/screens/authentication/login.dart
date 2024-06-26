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

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<LoginForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  List<TextEditingController> controllers = [
    TextEditingController(text: 'kristof.krasznai95@gmail.com'),
    TextEditingController(text: 'Tisamo012345'),
  ];

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
                      controller: controllers[0],
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
                        controller: controllers[1],
                        decoration: const InputDecoration(hintText: 'password'),
                        obscureText: true,
                        validator: (val) {
                          if (val == null || val.length < 7)
                            return 'Enter valid password';
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
                                  email: controllers[0].text,
                                  password: controllers[1].text);
                              var token = await userProvider.login(logInfo);
                              await userProvider.authenticate(token!);
                              if (token == null) {
                              } else {
                                await saveTokenToStorage(token);
                                 Navigator.pushNamed(context, '/');
                              }
                            }
                          },
                            child: const Text('Bejelentkezés'),
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
        title: Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 100),
              child: Text(
                'Bejelentkezés',
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
