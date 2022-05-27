import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_application_todo/ui/theme.dart';
import 'package:flutter_application_todo/ui/widgets/button.dart';
import 'package:flutter_application_todo/ui/widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskBar extends StatefulWidget {
  const AddTaskBar({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskBar> createState() => _AddTaskBarState();
}

class _AddTaskBarState extends State<AddTaskBar> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();

  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20, 25, 30];

  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add Task", style: headingStyle),
                  MyInputField(
                    title: "Title",
                    hint: "Enter Your Task Title",
                    controller: _titleController,
                  ),
                  MyInputField(
                    title: "Note",
                    hint: "Enter Your Note",
                    controller: _noteController,
                  ),
                  MyInputField(
                    title: "Date",
                    hint: DateFormat.yMMMd().format(_selectedDate),
                    widget: IconButton(
                      onPressed: () {
                        _getDateFromUser(context);
                      },
                      icon: Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: MyInputField(
                        title: "Start Time",
                        hint: _startTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isStartTime: true);
                          },
                          icon: Icon(Icons.access_time_rounded),
                        ),
                      )),
                      SizedBox(width: 10),
                      Expanded(
                          child: MyInputField(
                        title: "End Time",
                        hint: _endTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isStartTime: false);
                          },
                          icon: Icon(Icons.access_time_rounded),
                        ),
                      ))
                    ],
                  ),
                  MyInputField(
                    title: "Remind",
                    hint: "$_selectedRemind minutes early",
                    widget: DropdownButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 32,
                      elevation: 4,
                      style: subTitleStyle,
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRemind = int.parse(newValue!);
                        });
                      },
                      items:
                          remindList.map<DropdownMenuItem<String>>((int value) {
                        return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                  MyInputField(
                    title: "Repeat",
                    hint: "$_selectedRepeat",
                    widget: DropdownButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 32,
                      elevation: 4,
                      style: subTitleStyle,
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRepeat = newValue!;
                        });
                      },
                      items: repeatList
                          .map<DropdownMenuItem<String>>((String? value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value!,
                              style: TextStyle(color: Colors.grey)),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Color", style: titleStyle),
                            Wrap(
                                children: List<Widget>.generate(3, (int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedColor = index;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: index == 0
                                          ? Color.fromRGBO(244, 67, 54, 1)
                                          : index == 1
                                              ? Color.fromRGBO(76, 175, 80, 1)
                                              : Color.fromRGBO(33, 150, 243, 1),
                                      child: _selectedColor == index
                                          ? Icon(
                                              Icons.done,
                                              color: Colors.white,
                                            )
                                          : Container()),
                                ),
                              );
                            }))
                          ],
                        ),
                        MyButton(
                            label: "Create Task", onTap: () => _validateDate())
                      ])
                ],
              ),
            )));
  }

  _getDateFromUser(BuildContext context) async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    } else {
      print("No Date Selected");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time Cancelled");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.input,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      //add to database
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all the fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color.fromRGBO(138, 176, 171, 10),
        icon: Icon(
          Icons.warning_amber_rounded,
        ),
      );
    }
  }
}

_appBar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: GestureDetector(
      onTap: () => Get.back(),
      child: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    ),
    actions: [
      CircleAvatar(
        backgroundImage: AssetImage("images/profile_image.jpg"),
      ),
      SizedBox(width: 20, height: 20),
    ],
  );
}
