import 'package:flutter/material.dart';
import 'package:generic_date/screens/authentication/namedate.dart';
import 'package:generic_date/screens/authentication/verification.dart';
import 'package:generic_date/services/event-service.dart';
import 'package:generic_date/shared/layout/simple_layout.dart';
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
  List<int> number = [1,2,3,4];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      UserProvider provider = Provider.of<UserProvider>(context, listen: false);
       User? user = await provider.getUser();
       if(user.verified == false){
         Navigator.pushAndRemoveUntil(
           context,
           MaterialPageRoute(builder: (context) => const VerificationScreen()),
               (Route<dynamic> route) => false,
         );
         return;
       }
      if(user.birthday == null || user.username == null ){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>  const IntialSettings()),
              (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    double maxWidth = width > 620 ? 600 : width - 20;
    double maxHeight = height > 900 ? 750 : height - 180;



    return SimpleLayout(layout:Consumer<UserProvider>(
        builder: (context, userProvider, child) =>
            Stack(
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
    ),    Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top:20),
                          child: SizedBox(
                            width: maxWidth ,
                            height: maxHeight,
                            child: Stack(
                              children: [
                               ...number.map((num){
                                return AnimatedContainer(color: Colors.red,
                                   width: maxWidth,
                                   height: maxHeight,
                                   duration: Duration(milliseconds: 1000),
                                   curve: Curves.bounceInOut,
                                   child: Text(num.toString())  ,
                                   );

                               })

                              ],
                            ),

                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          if(number.isEmpty){
                            return;
                          }
                          setState(() {
                            number.removeLast();
                          });
                        },
                        child: Container(
                          width: maxWidth,
                          color: Colors.white,
                          height: 80,
                        ),
                      )

                    ],
                  )
                ]))
        , title: 'Home', hideAppbar: true,);
  }
}

void checkUserData(){

}


