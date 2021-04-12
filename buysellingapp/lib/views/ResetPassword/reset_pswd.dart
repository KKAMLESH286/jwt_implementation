import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_entry_field/pin_entry.dart';
import 'package:untitled/res/colors.dart';
import 'package:untitled/res/images.dart';
import 'package:untitled/views/ResetPassword/password_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool correct = false;
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();

  var controller = Get.put(PasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.grey,
        ),
        title: Container(
            margin: EdgeInsets.only(left: 40.0, right: 40.0),
            child: Text(
              'Reset Password',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              )),
            )),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        'The recover code was send to your Email'
                        '\n'
                        'address. Please enter the code. ',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black45, height: 1.4),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  child: Text(
                    'OTP',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: PinEntryField(
                          fieldWidth: 60.0,
                          height: 60.0,
                          fieldCount: 4,
                          inputType: PinInputType.none,
                          fieldStyle: PinEntryStyle(
                              textStyle: TextStyle(
                                  color: Colors.black38, fontSize: 20.0),
                              fieldBackgroundColor: Colors.black12,
                              fieldBorderRadius: BorderRadius.circular(10.0),
                              fieldPadding: 25.0),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25.0, bottom: 25.0),
                  height: 2.0,
                  color: Colors.black12,
                ),
                Container(
                  child: Text(
                    'New Password?',
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: Icon(
                        Icons.lock_outline,
                        size: 20.0,
                        color: Colors.black38,
                      ),
                    ),
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black12, width: 0.01))),
                            child: TextField(
                              obscureText: true,
                              controller: password1,
                              onChanged: (bool) {
                                if ((password1.text == password2.text &&
                                    (password1.text.isNotEmpty &&
                                        password2.text.isNotEmpty))) {
                                  setState(() {
                                    print(1);
                                    correct = true;
                                  });
                                } else {
                                  setState(() {
                                    print(2);
                                    correct = false;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: Colors.black26,
                                  ),
                                  suffixIcon: Container(
                                      padding: EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(AppImages.checks,
                                          color: correct
                                              ? Colors.green
                                              : Colors.redAccent))),
                            ),),),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 25.0),
                  child: Text(
                    'Confirm Password?',
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: Icon(
                        Icons.lock_outline,
                        size: 20.0,
                        color: Colors.black38,
                      ),
                    ),
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black12, width: 0.01))),
                            child: TextField(
                              obscureText: true,
                              onChanged: (bool) {
                                if ((password2.text == password1.text &&
                                    (password1.text.isNotEmpty &&
                                        password2.text.isNotEmpty))) {
                                  setState(() {
                                    print(3);
                                    correct = true;
                                  });
                                } else {
                                  setState(() {
                                    print(4);
                                    correct = false;
                                  });
                                }
                              },
                              controller: password2,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: Colors.black26,
                                  ),
                                  suffixIcon: Container(
                                      padding: EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(AppImages.checks,
                                          color: correct
                                              ? Colors.green
                                              : Colors.redAccent))),
                            )))
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                        color: primaryColor,
                        child: Text(
                          'Reset',
                          style: TextStyle(color: Colors.white, fontSize: 17.0),
                        ),
                        onPressed: () {
                          controller.getPassword("5fd89f6b07f6b42a8effaef3", password1.text.toString(),
                              password2.text.toString());
                        },
                      ),
                    )
                  ],
                ),
                Container(
                  height: 100.0,
                  color: Colors.transparent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

// Widget checkicon(){
//   return    Column(
//     children: [
//       Container(padding:EdgeInsets.all(15.0),child:(password2.text!=password1.text) ?
//       SvgPicture.asset(AppImages.check1,color: Colors.transparent):SvgPicture.asset(AppImages.check1,color: Colors.green),
//
//       ),
//
//     ],
//   );
//
// }

}
