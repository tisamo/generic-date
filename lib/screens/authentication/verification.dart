import 'package:flutter/material.dart';
import 'package:generic_date/provider/userlist-provider.dart';
import 'package:generic_date/screens/Profile/profile-settings.dart';
import 'package:generic_date/screens/authentication/namedate.dart';
import 'package:generic_date/services/utils-service.dart';
import 'package:generic_date/shared/styles/colors.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationState();
}

class _VerificationState extends State<VerificationScreen> {
  bool isFormValid = false;
  TextEditingController one = TextEditingController();
  TextEditingController two = TextEditingController();
  TextEditingController three = TextEditingController();
  TextEditingController four = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    double maxWidth = width > 600 ? 600 : width - 20;

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: ColorTheme.primaryColor,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.orangeAccent,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: ColorTheme.secondaryColor,
                ),
              ),
            ],
          ),
          Center(
            child: SizedBox(
              width: maxWidth,
              height: height > 750 ? 375 : 350,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Type your PIN",
                            style: TextStyle(
                              color: ColorTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                          SizedBox(
                            width: 270,
                            child: Form(
                              key: _formKey,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: TextFormField(
                                      controller: one,
                                      decoration: const InputDecoration(
                                        counterText: "",
                                      ),
                                      maxLength: 1,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      validator: (val) {
                                        return val!.length == 1 ? null : '';
                                      },
                                      onChanged: (val) {
                                        if (val.isNotEmpty) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                        setState(() {
                                          isFormValid =
                                              _formKey.currentState?.validate() ??
                                                  false;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40,
                                    child: TextFormField(
                                      controller: two,
                                      decoration: const InputDecoration(
                                        counterText: "",
                                      ),
                                      maxLength: 1,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      validator: (val) {
                                        return val!.length == 1 ? null : '';
                                      },
                                      onChanged: (val) {
                                        if (val.isEmpty) {
                                          FocusScope.of(context).previousFocus();
                                        } else {
                                          FocusScope.of(context).nextFocus();
                                        }
                                        setState(() {
                                          isFormValid =
                                              _formKey.currentState?.validate() ??
                                                  false;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40,
                                    child: TextFormField(
                                      controller: three,
                                      decoration: const InputDecoration(
                                        counterText: "",
                                      ),
                                      maxLength: 1,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      validator: (val) {
                                        return val!.length == 1 ? null : '';
                                      },
                                      onChanged: (val) {
                                        if (val.isEmpty) {
                                          FocusScope.of(context).previousFocus();
                                        } else {
                                          FocusScope.of(context).nextFocus();
                                        }
                                        setState(() {
                                          isFormValid =
                                              _formKey.currentState?.validate() ??
                                                  false;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40,
                                    child: TextFormField(
                                      controller: four,
                                      decoration: const InputDecoration(
                                        counterText: "",
                                      ),
                                      maxLength: 1,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      validator: (val) {
                                        return val!.length == 1 ? null : '';
                                      },
                                      onChanged: (val) {
                                        if (val.isEmpty) {
                                          FocusScope.of(context).previousFocus();
                                        }
      
                                        setState(() {
                                          isFormValid =
                                              _formKey.currentState?.validate() ??
                                                  false;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Send email again",
                              style: TextStyle(
                                color: Colors.orangeAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                isFormValid
                                    ? ColorTheme.secondaryColor.withOpacity(0.7)
                                    : ColorTheme.secondaryColor.withOpacity(0.2),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final code =
                                    "${one.value.text}${two.value.text}${three.value.text}${four.value.text}";
                                UserProvider provider = Provider.of<UserProvider>(
                                    context,
                                    listen: false);
                                bool isVerificationSuccess =
                                    await provider.verifyUser(code);
                                String message =
                                    "Your user have been successfully verified";
                                if (isVerificationSuccess == false) {
                                  message = "Verification was not successful";
                                }
                                showToast(message);
                                User user = provider.user;
                                if(user.birthday == null || user.username == null ){
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => const IntialSettings()),
                                        (Route<dynamic> route) => false,
                                  );
                                }
                              }
                            },
                            child: const Text(
                              'Send',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
