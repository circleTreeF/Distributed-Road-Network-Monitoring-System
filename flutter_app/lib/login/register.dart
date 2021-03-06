import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/fancy_dialog.dart';
import 'package:flutter_app/login/user_account.dart';
import 'package:flutter_app/login/widgets/UserText.dart';
import 'package:flutter_app/post_model.dart';
import 'package:flutter_app/post_service.dart';
import 'package:flutter_app/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_screen.dart';





class RegisterScreen extends StatefulWidget {



  @override
  _RegisterScreenState createState() => _RegisterScreenState();


}

class _RegisterScreenState extends State<RegisterScreen> {
  final controller = ScrollController();
  double offset = 0;

  UserText _userText;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(400),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UserText(),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(70)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(600),
                          height: ScreenUtil.getInstance().setHeight(80),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                               // addUser();
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context)=>LoginScreen()
                                    )
                                );
                              },
                              child: Center(
                                child: Text("Register",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(200),
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  void addUser() {
    createPost1(new Post1(username:_userText.nameController.text,password:_userText.passwordController.text)).then((response) {
      if (response.statusCode >= 200) {
        var _content = response.body;
        Map<String, dynamic> enter = jsonDecode(_content);
        print('${enter['result']}');
        print(enter['result']);
        if(enter['result']==true){
          UserAccount().user_id=int.parse(_userText.nameController.text);
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context)=>LoginScreen()
              )
          );
        }
        else {
          showDialog(
              context: context,
              builder: (BuildContext context) => FancyDialog()
          );
        }

      }
      else
        print(response.statusCode);
    } ).catchError((error){
      print('error : $error');
    });
  }










}
