import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_21/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TeacherHomePage extends StatefulWidget {
  static final String routName = "/teacherHomePage";

  @override
  _TeacherHomePageState createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  String fileName = "No File Chosen yet";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(FontAwesomeIcons.solidFolder),
                child: Text("Schedule Paper"),
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.solidFilePdf),
                child: Text("Check Copy"),
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.solidFilePdf),
                child: Text("Checked Copy"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Image.file(
                        File(fileName),
                        fit: BoxFit.cover,
                        height:200,
                        width:200,
                      ),
                    ),
                    isThreeLine: true,
                    onTap: () {
                      pickFile().then((value) {
                        if (value != null) {
                          setState(() {
                            fileName = value.path;
                          });
                        }
                      });
                    },
                    shape: Border.all(width: 2, color: Colors.black12),
                    title: Text(
                      "Choose File/PDF",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(fileName),
                    trailing: IconButton(
                      icon: Icon(CupertinoIcons.calendar),
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2),
                    child: Text(
                      "Choose Paper Date and Start Time",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: CupertinoDatePicker(
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (DateTime newDate) {
                        print(newDate);
                      },
                      use24hFormat: false,
                      minimumDate:
                          DateTime(DateTime.now().year, 1, DateTime.now().day),
                      maximumDate: new DateTime(
                          DateTime.now().year, 12, DateTime.now().day),
                      minimumYear: DateTime.now().year - 1,
                      maximumYear: DateTime.now().year + 1,
                      minuteInterval: 1,
                      mode: CupertinoDatePickerMode.dateAndTime,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2),
                    child: Text(
                      "Choose Paper Duration",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  CupertinoTimerPicker(
                    onTimerDurationChanged: (time) {},
                    minuteInterval: 5,
                    mode: CupertinoTimerPickerMode.hms,
                    alignment: Alignment.center,
                    initialTimerDuration:
                        Duration(hours: 3, minutes: 0, seconds: 0),
                    secondInterval: 10,
                  ),
                ],
              ),
            ),
            Container(
              child: ListView(
                children: List.generate(
                  10,
                  (index) => ListTile(
                    title: Container(
                      child: Text("Copy ${index + 1}"),
                    ),
                    trailing: CircleAvatar(child: Text("${index + 1}")),
                  ),
                ),
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
