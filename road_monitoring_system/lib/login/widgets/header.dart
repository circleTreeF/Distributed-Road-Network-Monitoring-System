import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

///The header of the pop up dialog
class MyHeader extends StatefulWidget {

  final String textTop;
  final String textBottom;
  final double offset;
  const MyHeader(
      {Key key, this.textTop, this.textBottom, this.offset})
      : super(key: key);

  @override
  MyHeaderState createState() => MyHeaderState();
}


class MyHeaderState extends State<MyHeader> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.zero ,
        height: 350,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(27, 42, 107, 1.0),
              Color.fromRGBO(0, 86, 151, 1.0),
            ],
          ),
        ),
        child: Column(

          children: <Widget>[
            SizedBox(height: 70),
                 Container(

                child:
                  Image.asset('assets/images/logo.png',

                    ),
                   width: 200,
                   height: 200,

              ),
  ],
            ),
    ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
