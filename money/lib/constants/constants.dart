import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants{
  static Color primaryColor = Color.fromARGB(255, 3, 38, 91);
  static TextStyle fonts = GoogleFonts.raleway(); 
  static TextStyle fontandcolor = GoogleFonts.raleway(color: Constants.primaryColor);
  static TextStyle fontandcolorandweight = GoogleFonts.raleway(color: Constants.primaryColor,fontWeight: FontWeight.bold);
  static TextStyle fontandcolorandweightandsize = GoogleFonts.raleway(color: Constants.primaryColor,fontWeight: FontWeight.bold,fontSize: 36);
  static TextStyle fontandwhiteandweight = GoogleFonts.raleway(color: Colors.white,fontWeight: FontWeight.bold);
}