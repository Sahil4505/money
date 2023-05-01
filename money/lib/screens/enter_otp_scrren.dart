import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money/screens/home_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../provider/auth_provider.dart';
import '../utils/utils.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                color: Constants.primaryColor,
              ))
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Constants.primaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          "Verify OTP",
                          style: GoogleFonts.raleway(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    Container(
                      child: Text(
                        "Enter OTP sent to your phone number.",
                        style: Constants.fontandcolor,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Pinput(
                      length: 6,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                        width: 50,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Constants.primaryColor)),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      onCompleted: (value) {
                        setState(() {
                          otpCode = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                            minimumSize: Size(300, 60),
                            backgroundColor: Constants.primaryColor),
                        onPressed: () {
                          if (otpCode != null) {
                            verifyOtp(context, otpCode!);
                          } else {
                            showSnackBar(context, "Enter 6-Digit code");
                          }
                        },
                        child: Text(
                          "Verify",
                          style: Constants.fonts,
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Didn't received any code ?  ",
                            style: Constants.fontandcolor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Resend new code",
                            style: Constants.fontandcolorandweight,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        //check if user is in db
        ap.checkExistingUser().then((value) async {
          Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
                (route) => false);
          // if (value == true) {
          //   ap.getDataFromFireStore().then(
          //         (value) => ap.saveUserDataToSP().then(
          //               (value) => ap.setSignIn().then(
          //                     (value) => Navigator.pushAndRemoveUntil(
          //                         context,
          //                         MaterialPageRoute(
          //                           builder: (context) => HomeScreen(),
          //                         ),
          //                         (route) => false),
          //                   ),
          //             ),
          //       );
          // } else {
          //   Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => SignUpPage(),
          //       ),
          //       (route) => false);
          //   // Navigator.push(
          //   //     context,
          //   //     MaterialPageRoute(
          //   //       builder: (context) => SignUpPage(),
          //   //     ));
          // }
        });
      },
    );
  }
}