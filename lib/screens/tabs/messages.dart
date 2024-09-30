import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:generic_date/shared/layout/simple_layout.dart';

class Messages extends StatelessWidget {
  Messages({Key? key}) : super(key: key);
  List<int> numbers = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 600 ? 600 : width;

    return SimpleLayout(
        hideAppbar: true,
        layout: Center(
          child: Container(
            width: maxWidth,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        width: 10,
                      ),
                      itemCount: numbers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(75.0)),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.red,
                                  child: Center(
                                    child: Text(index.toString()),
                                  ),
                                ),
                              ),
                            ]);
                      },
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                      width: width - 30,
                      height: 40,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: "Filer Users"),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: width - 20,
                      child: ListView.builder(
                        itemCount: numbers.length,
                        itemBuilder: (context, index) {
                          final n = numbers[index];
                          return SizedBox(
                            height: 60,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    color: Colors.red,
                                    child: Center(
                                      child: Text(n.toString()),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30),
                                Flexible(
                                  child: Text(
                                    "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        title: "Messages");
  }
}
