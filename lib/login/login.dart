import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_21/Teacher/teacherdashboard.dart';
import 'package:flutter_web_21/student/studentdashboard.dart';
import 'package:flutter_web_21/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';



class LoginPage extends StatefulWidget {
  static final String routName="/";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isStudentSelected = false, isTeacherSelected = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.book,
              size: 100,
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                  text: "Login ".toUpperCase(),
                  style: GoogleFonts.modakTextTheme()
                      .headline6
                      .copyWith(fontSize:24,fontWeight:FontWeight.w100),
                  children: [
                    TextSpan(
                      text: "With",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildCustomToggle(context, "Teacher", () {
                      setState(() {
                        if (isStudentSelected) {
                          isStudentSelected = !isStudentSelected;
                          isTeacherSelected = !isTeacherSelected;
                        }
                      });
                    }, isTeacherSelected),
                    buildCustomToggle(context, "Student", () {
                      setState(() {
                        if (isTeacherSelected) {
                          isStudentSelected = !isStudentSelected;
                          isTeacherSelected = !isTeacherSelected;
                        }
                      });
                    }, isStudentSelected),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                signInCard(
                  onPress: () {
                     signInWithGoogle().then((value){
                        if(value!=null){
                          if(isTeacherSelected){
                            Navigator.pushNamed(
                                context, TeacherHomePage.routName);
                          }else {
                            Navigator.pushNamed(
                                context, StudentHomePage.routName);
                          }
                        }
                     });
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildCustomToggle(BuildContext context, text, onTap, isSelected) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(10),
        color: isSelected ? Colors.blue.shade100 : Colors.grey.shade100,
        borderOnForeground: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: Colors.white70,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Text(
            text.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
  Future<User> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    UserCredential authResult = await _auth.signInWithCredential(credential);
    User _user = authResult.user;
    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);
    User currentUser = await _auth.currentUser;
    assert(_user.uid == currentUser.uid);
    return currentUser;
  }
}

