import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:generic_date/shared/layout/simple_layout.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    return SimpleLayout(
      hideAppbar: true,
        layout: Column(
          children: [
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) =>
                     const SizedBox(width: 10,),
                  itemCount: numbers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.center, children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(75.0)),
                        child: Container(
                          width: 80,
                          height: 80,
                          color: Colors.red,
                          child: Center(child: Text(index.toString()),),),
                      ),
                    ]);
                  },
                ),
              ),

            )
          ],
        ),
        title: "Messages");
  }
}
