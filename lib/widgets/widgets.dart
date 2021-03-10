import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class signInCard extends StatelessWidget {
  final onPress;
  const signInCard({
    this.onPress,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width*1,
      margin:EdgeInsets.symmetric(horizontal:10),
      child: ElevatedButton.icon(
        onPressed: onPress,
        icon: Icon(
          FontAwesomeIcons.google,
        ),
        label: Text(
          "  Google  Sign  In".toUpperCase(),
        ),
      ),
    );
  }
}