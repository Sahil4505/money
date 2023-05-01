import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../provider/auth_provider.dart';
import '../utils/utils.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController phoneController = new TextEditingController();
  Country country = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: "");
  final formKey = GlobalKey<FormState>();
  late String _contactNo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   elevation: 0,
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Constants.primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Money Expense Manager",
                        style: GoogleFonts.raleway(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                height: 24,
                          ),
                           Center(
                      child: Text(
                        "Enter Contact",
                        style: GoogleFonts.raleway(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Form(
              key: formKey,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: Container(
                                // alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(
                                  12.0,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    showCountryPicker(
                                        countryListTheme: CountryListThemeData(
                                            bottomSheetHeight: 550),
                                        context: context,
                                        onSelect: (value) {
                                          setState(() {
                                            country = value;
                                          });
                                        });
                                  },
                                  child: Text(
                                    "${country.flagEmoji} +${country.phoneCode}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              labelText: 'Contact Number',
                              // hintText: 'Email',
                              labelStyle: Constants.fontandcolor,
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    BorderSide(color: Constants.primaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    BorderSide(color: Constants.primaryColor),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a Contact Number';
                              }
                              if (value.length != 10) {
                                return 'Contact Number must be 10 Digits';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _contactNo = value!;
                            },
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          TextButton(
                            onPressed: () {
                              showSnackBar(context, "Please wait for a while");
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(),));
                              sendPhoneNumber();
                            },
                            child: Text(
                              "Get OTP",
                              style: Constants.fontandcolorandweight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
//   void showSnackBar(BuildContext context, String content) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
// }
void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context, "+${country.phoneCode}$phoneNumber");
  }
}
