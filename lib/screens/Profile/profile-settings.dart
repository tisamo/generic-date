import 'package:chip_list/chip_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:generic_date/models/user_image.dart';
import 'package:generic_date/provider/userlist-provider.dart';
import 'package:generic_date/services/hobby.service.dart';
import 'package:generic_date/shared/elements/inputs/text_input.dart';
import 'package:provider/provider.dart';
import '../../models/role.dart';
import '../../models/user.dart';
import '../../shared/layout/simple_layout.dart';
import '../../shared/styles/colors.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key, this.firstTime = true}) : super(key: key);
  final bool firstTime;
  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState<T extends ChangeNotifier>
    extends State<ProfileSettings> {
  final ImagePicker _picker = ImagePicker();
  List<int> photos = [0, 1, 2, 3, 4, 5];
  List<String> list = [];
  List<Role> hobbies = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController dateInput = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      UserProvider provider = Provider.of<UserProvider>(context, listen: false);
      hobbies = await getHobbies();
      await provider.getUserHobbies();
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    bioController.dispose();
    heightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool firstTime = widget.firstTime;
    double width = MediaQuery.sizeOf(context).width;
    double maxWidth = width > 400 ? 400 : width - 10;
    return Consumer<UserProvider>(
      builder:
          (BuildContext context, UserProvider userProvider, Widget? child) {
        return SimpleLayout(
          showNavbar: firstTime,
          layout: Stack(
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
              Center(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Container(
                      width: width - 20,
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: maxWidth,
                            child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Images",
                                      textAlign: TextAlign.right,
                                      style:  TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  )
                                ]),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 320,
                            width: maxWidth,
                            child: Card(
                              shadowColor: ColorTheme.secondaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.spaceAround,
                                  runAlignment: WrapAlignment.spaceAround,
                                  children: [
                                    ...(photos.map((el) {
                                      return Container(
                                        alignment: Alignment.center,
                                        width: maxWidth / 3.5,
                                        height: 130,
                                        padding: const EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: ColorTheme.secondaryColor,
                                            width: 1,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        child: el <
                                                userProvider.user.images.length
                                            ? Stack(
                                                children: [
                                                  Positioned.fill(
                                                    child: Image.network(
                                                      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                                      fit: BoxFit
                                                          .cover, // You can also try BoxFit.fill if you want to stretch the image
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              75.0),
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        alignment:
                                                            Alignment.center,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        child: IconButton(
                                                          onPressed: () {
                                                            userProvider.DeleteImage(
                                                                userProvider
                                                                        .user
                                                                        .images[
                                                                    el]);
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            75.0),
                                                    child: Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Color(0xFFe0f2f1),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned.fill(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            ColorTheme
                                                                .primaryColor,
                                                        radius: 20.0,
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                            size: 20.0,
                                                          ),
                                                          onPressed: () async {
                                                            takeSnapshot(
                                                                userProvider);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      );
                                    })).toList(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: maxWidth,
                            child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'User Details',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  )
                                ]),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: maxWidth,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: CustomTextInput(
                                        hint: 'Write something about yourself',
                                        controller: bioController,
                                        maxLines: 5,
                                        enableSuggestions: true,
                                        validator: (val) {
                                          if (val == null || val.length > 3) {
                                            return 'username must be 4 chars at least';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: CustomTextInput(
                                        hint: 'Height in cm',
                                        controller: heightController,
                                        required: true,
                                        inputType: TextInputType.number,
                                        maxLines: 1,
                                        enableSuggestions: true,
                                        validator: (val) {
                                          if (val == null || val.length < 3) {
                                            return 'Invalid height';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: maxWidth,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Row(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                _dialogBuilder(
                                                    context);
                                              },
                                              child: Text("Select Hobbies"))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          title: 'Profile',
        );
      },
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    double maxWidth = width > 600 ? 600 : width;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          child: Consumer<UserProvider>(
            builder: (BuildContext context, UserProvider userProvider, Widget? child) {
              User currentUser = userProvider.user;

              return Column(children: [
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  color: ColorTheme.secondaryColor,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Pick some hobbies",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                    height: height - 100,
                    width: maxWidth,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Wrap(
                              children: [
                                ...(hobbies.map((element) {
                                  return Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: OutlinedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(currentUser.hobbies.any((el)=> el.id == element.id) ? ColorTheme.primaryColor  : Colors.white),
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  color: ColorTheme.primaryColor,
                                                  width: 2)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(30.0))),
                                        ),
                                        onPressed: () {
                                          userProvider.addToSelectedHobbies(element);
                                        },
                                        child: Text(
                                          element.name,
                                          style:  TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: currentUser.hobbies.any((el)=> el.id == element.id) ? Colors.white  : Colors.black),
                                        ),
                                      ));
                                })).toList(),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    )),
                Container(
                    height: 50,
                    color: ColorTheme.secondaryColor,
                    alignment: Alignment.center,
                    child:
                            ElevatedButton(
                                onPressed: () {
                                  userProvider.updateUserHobbies();
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Save")),


                        ),
              ]);
            },
          ),
        );
      },
    );
  }

  void takeSnapshot(UserProvider provider) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? img = await picker.pickImage(source: ImageSource.gallery);

      if (img == null) return;

      final bytes = await img.readAsBytes();

      String fileName = img.name;

      var formData = FormData.fromMap({
        'photo': MultipartFile.fromBytes(bytes, filename: fileName),
      });

      UserImage userImage = await provider.uploadImage(formData);
      provider.addImageToUser(userImage);

      if (!mounted) return;
    } catch (e) {
      print("Error occurred during image selection or upload: $e");
    }
  }

  int checkValue(List list) {
    print(list.length);
    if (list.isEmpty) {
      return 2;
    }
    return list.length;
  }
}
