import 'package:flutter/material.dart';
import '../../models/event.dart';
import '../shared/elements/bottom-nav.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

setFormWidth(screenWidth) {
  if (screenWidth > 500) {
    return 500;
  }
  return screenWidth;
}
late DateTime selectedDate;
class EventForm extends StatefulWidget {

  const EventForm({super.key});

  @override
  EventFormState createState() {
    return EventFormState();
  }
}


class EventFormState extends State<EventForm> {
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  Widget build(BuildContext context) {
    final lastDate = DateTime(DateTime.now().year + 5);

    // Build a Form widget using the _formKey created above.
    return Container(
      child: SizedBox(
        width: setFormWidth(MediaQuery.of(context).size.width),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Add TextFormFields and ElevatedButton here.
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controllers[0],
                  validator: (val) {
                    if (val!.length < 5) {
                      return 'Event name';
                    }
                  },
                  decoration: InputDecoration(hintText: 'name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SfDateRangePicker(
                  onSelectionChanged: _onSelectionChange,
                  selectionMode: DateRangePickerSelectionMode.single,
                ),
                  ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: controllers[1],
                    decoration: InputDecoration(hintText: 'place'),
                    validator: (val) {
                      if (val?.length == 0) return 'Please enter a Place';
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: controllers[2],
                    decoration: InputDecoration(hintText: 'description'),
                    validator: (val) {
                      if (val?.length == 10)
                        return 'Please add a description longer than 10 chars!';
                    }),
              ),
             Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          Event event = Event(
                              name: controllers[0].text,
                              partyTime: selectedDate,
                              place: controllers[1].text,
                              description: controllers[2].text,
                              organizer: '4124421124214');
                        }
                      },
                      child: const Text('Regisztráció'),
                    )),

            ],
          ),
        ),
      ),
    );
  }
}

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({Key? key}) : super(key: key);

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
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  'Esemény hozzáadása',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              EventForm(),
            ],
          )
        ]),
        bottomNavigationBar: const BottomNav()
    );

  }
}

void _onSelectionChange(DateRangePickerSelectionChangedArgs dateSelected) {
  selectedDate = dateSelected.value;
}
