import 'package:flutter/material.dart';

/// Doc : https://api.flutter.dev/flutter/material/TextTheme-class.html
class CustomTheme {
  // * * * * * * * * * * * * *** Light *** * * * * * * * * * * * *
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData.light().copyWith(
      appBarTheme:const AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          //fontFamily: GoogleFonts.aBeeZee().fontFamily,
        ),
      ),

      /// displayColor ~>  headline4, headline3, headline2, headline1, and caption
      /// bodyColor  ~> is applied to the remaining text styles.
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
            //fontFamily: GoogleFonts.aBeeZee().fontFamily,
          ),
    );
  }

  // * * * * * * * * * * * * *** Dark *** * * * * * * * * * * * *
  static ThemeData darkTheme(BuildContext context) {
    return ThemeData.dark().copyWith(
      textTheme: Theme.of(context).textTheme.apply(
            displayColor: Colors.white,
            bodyColor: Colors.white,
            //fontFamily: GoogleFonts.aBeeZee().fontFamily,
          ),
    );
  }
}
