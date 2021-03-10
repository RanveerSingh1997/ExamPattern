import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_21/student/exampaper.dart';
import 'copywriting.dart';



class StudentHomePage extends StatefulWidget {
  static final String routName="/studentHomePage";
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: DefaultTabController(
        initialIndex: currentIndex,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white54,
            title: Text(
              "Examination".toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
            ),
            centerTitle: true,
            actions: [
              TextButton.icon(
                icon: Icon(
                  Icons.upload_sharp,
                  color: Colors.black,
                ),
                onPressed: () {},
                label: Text(
                  'Submit Copy'.toUpperCase(),
                  style: Theme.of(context).textTheme.caption.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
            bottom: TabBar(
                onTap: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                automaticIndicatorColorAdjustment: true,
                isScrollable: false,
                physics: ScrollPhysics(),
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    child: Text("Exam Paper"),
                    icon: Icon(CupertinoIcons.book_circle_fill),
                  ),
                  Tab(
                    child: Text("Paper Writing"),
                    icon: Icon(CupertinoIcons.book_solid),
                  ),
                ]),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              PaperPDFPreviewPage("http://www.africau.edu/images/default/sample.pdf"),
              CopyDrawPage(),
            ],
          ),
        ),
      ),
    );
  }
}