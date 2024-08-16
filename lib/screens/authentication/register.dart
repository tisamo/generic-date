import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:generic_date/provider/userlist-provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../services/geolocation.service.dart';
import '../../shared/elements/navigation-element.dart';
import '../../shared/regexes/regexes.dart' as regex;
import '../../models/user.dart';
import '../../http-client/http-client.dart';

getWidth(screenWidth) {
  if (screenWidth > 500) {
    return 500;
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


class MyCustomFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bioController = TextEditingController();
  final birthDayController = TextEditingController();


  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  void dispose() {
    for(var controller in controllers){
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: getWidth(MediaQuery.of(context).size.width),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0,0, 30),
                        child: Text(
                          'Regisztráció',
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: userNameController,
                          validator: (val) {
                            if (val!.length < 5) {
                              return 'Username must be at least 5 chars long';
                            }
                          },
                          decoration: InputDecoration(hintText: 'name'),
                          obscureText: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: emailController,
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
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(hintText: 'password'),
                            obscureText: true,
                            validator: (val) {
                              if (val == null || val.length < 7) {
                                return 'Enter valid password';
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DatePickerWidget(
                          dateFormat: 'yyyy-MM-dd',
                          onConfirm: (dateTime, list){
                            birthDayController.text = dateTime.toString();
                          },
                          pickerTheme: DateTimePickerTheme(
                            showTitle: false,
                          ),

                        ),
                      ),
                      Consumer<UserProvider>(
                        builder: (context, userProvider, child) => Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  User user =  User(
                                      name: userNameController.text,
                                      email: emailController.text,
                                      description: bioController.text,
                                      password: passwordController.text,
                                      birthday:  birthDayController.text ,
                                      longitude: 0,
                                      latitude: 0,
                                      image:
                                      'https://img.freepik.com/premium-vector/abstract-colorful-psychedelic-groovy-background-vector-illustration_518299-2962.jpg');
                                  post('users/create', user.toJson())
                                      .then((value) => {
                                    userProvider.SetUser(User.fromJson(
                                        value as Map<String, dynamic>)),
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        content: Text(
                                            'Registration successful')))
                                  })
                                      .catchError((onError) => {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Email is already taken')),
                                    )
                                  });
                                }
                              },
                              child: const Text('Regisztráció'),
                            )),
                      ),
                    ],
                  ),
                ),
              ),

              NavigationText(
                  text: 'Van már felhasználód?', route: '/login', padding: 20),
            ],
          ),
        ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _UsersState();
}

class _UsersState extends State<RegisterScreen> {
  late Future<dynamic> users;
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
            const LoginForm(),
      ]),
    );
  }
}

Future<String> _getLocation() async {
  Position location = await determinePosition();
  final String latLong = '${location.latitude} ${location.longitude}';
  return latLong;
}
