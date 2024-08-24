import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:generic_date/shared/styles/colors.dart';

import '../../models/infp-type.dart';
import '../tabs/home.dart';

class InfpResultScreen extends StatelessWidget {
  final String infpType;
  List<MBTIType> infpList = MBTIType.getAllPersonalityTypes();

  InfpResultScreen({Key? key, required this.infpType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MBTIType? selectedInfpType = infpList.firstWhere(
        (el) => el.name.toLowerCase().contains(infpType.toLowerCase()),
        orElse: () => MBTIType(
            name: 'Unknown', description: 'Description not available'));
    List<String> infpInfos = selectedInfpType.name.split('-');
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
              color: ColorTheme.primaryColor,
              alignment: Alignment.bottomLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    infpInfos[0],
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                    ),
                  ),
                ],
              )),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.orangeAccent,
            alignment: Alignment.topRight,
            child: Text(
              infpInfos[1],
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
            color: ColorTheme.secondaryColor,
            alignment: Alignment.center,
            child: Text(
              selectedInfpType.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              color: ColorTheme.primaryColor,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                        (Route<dynamic> route) => false,
                  );;
                },
                child: const Text(
                  'Back',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              )),
        ),
      ],
    );
  }
}
