import 'dart:math';

import 'package:flutter/material.dart';
import 'package:generic_date/models/user.dart';
import 'package:generic_date/provider/userlist-provider.dart';
import 'package:generic_date/screens/tabs/home.dart';
import 'package:generic_date/shared/styles/colors.dart';
import 'package:provider/provider.dart';

import '../../services/utils-service.dart';
import '../../shared/elements/inputs/text_input.dart';


class IntialSettings extends StatefulWidget {
  const IntialSettings({super.key});


  @override
  InitialSettingsState createState() {
    return InitialSettingsState();
  }
}

class InitialSettingsState extends State<IntialSettings> {
  final PageController _controller1 = PageController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool nameValid = false;

  @override
  void dispose() {
    // Dispose of the PageControllers to avoid memory leaks
    _controller1.dispose();
    nameController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .sizeOf(context)
        .width;
    double height = MediaQuery
        .sizeOf(context)
        .height;
    double maxWidth = width > 600 ? 600 : width - 20;
    double maxHeight = height > 800 ? 750 : height - 100;
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                    color: ColorTheme.primaryColor,
                  )),
              Expanded(
                  child: Container(
                    color: ColorTheme.secondaryColor,
                  )),
            ],
          ),
          Form(
            key: _formKey,
            child: PageView(
              controller: _controller1,
              children: [
                Center(
                    child: SizedBox(
                      width: maxWidth,
                      height: maxHeight,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Please Chose an username",
                                  style: TextStyle(
                                      color: ColorTheme.primaryColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                CustomTextInput(
                                  hint: 'username',
                                  controller: nameController,
                                  required: true,
                                  inputType: TextInputType.number,
                                  maxLines: 1,
                                  enableSuggestions: true,
                                  onChanged: (val) {
                                    setState(() {
                                      nameValid = val!.length > 3;
                                    });
                                  },
                                  validator: (val) {
                                    if (val.length > 3) {
                                      return 'username must be 4 chars';
                                    }

                                    return null;
                                  },
                                ),
                                Opacity(
                                  opacity: nameValid ? 1.0 : 0.7,
                                  child: IgnorePointer(
                                    ignoring: !nameValid,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              ColorTheme.secondaryColor),
                                        ),
                                        onPressed: () {
                                          _controller1.nextPage(
                                              duration:
                                              const Duration(milliseconds: 200),
                                              curve: Curves.bounceIn);
                                        },
                                        child: const Text("Next",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold))),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
                Center(
                    child: SizedBox(
                      width: maxWidth,
                      height: maxHeight,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Please Chose an username",
                                  style: TextStyle(
                                      color: ColorTheme.secondaryColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextFormField(
                                  controller: dateController,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Please enter your date of birth";
                                    }

                                    DateTime birthDate;

                                    try {
                                      birthDate = DateTime.parse(val);
                                    } catch (e) {
                                      return "Invalid date format";
                                    }

                                    int age = calculateAge(birthDate);

                                    if (age < 18) {
                                      return "You must be at least 18 years old";
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.calendar_today,
                                      textDirection: TextDirection.ltr,),
                                    label: const Text.rich(
                                      TextSpan(children: <InlineSpan>[
                                        WidgetSpan(
                                            child: Text('Date of birth')),
                                        WidgetSpan(
                                          child: Text(
                                            ' *',
                                            style: TextStyle(
                                                color: Colors.red),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: ColorTheme.secondaryColor,
                                        width: 2.0, // Thinner width
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: Colors.blueAccent,
                                        width: 2.0,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: ColorTheme.secondaryColor,
                                        style: BorderStyle.solid,
                                        width: 10.0,
                                      ),
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate =
                                    await showDatePicker(
                                      context: context,
                                      initialEntryMode:
                                      DatePickerEntryMode
                                          .calendarOnly,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2100),
                                    );
                                    if (pickedDate != null) {
                                      String formattedDate = pickedDate
                                          .toString()
                                          .split(' ')[0];
                                      setState(() {
                                        dateController.text = formattedDate;
                                      });
                                    }
                                  },
                                ),
                                SizedBox(height: 150, child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  children: [
                                    Opacity(
                                      opacity: nameValid ? 1.0 : 0.7,
                                      child: IgnorePointer(
                                        ignoring: !nameValid,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all(
                                                  ColorTheme.secondaryColor),
                                            ),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                UserProvider provider = Provider
                                                    .of<UserProvider>(
                                                    context,
                                                    listen: false);
                                               bool isSuccess = await  provider.setInitialSettings(
                                                    nameController.value.text,
                                                dateController.value.text);
                                               if(isSuccess){
                                                 showToast("Welcome");
                                                 Navigator.pushAndRemoveUntil(
                                                   context,
                                                   MaterialPageRoute(builder: (context) => const Home()),
                                                       (Route<dynamic> route) => false,
                                                 );
                                               }
                                              }
                                            },
                                            child: const Text("Save",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight
                                                        .bold))),
                                      ),
                                    ),

                                    TextButton(
                                        onPressed: () {
                                          _controller1.previousPage(
                                              duration:
                                              const Duration(milliseconds: 200),
                                              curve: Curves.bounceIn);
                                        },
                                        child: const Text("Back",
                                            style: TextStyle(
                                                color: ColorTheme.primaryColor,
                                                fontWeight: FontWeight.bold)))
                                  ],
                                ),)

                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
