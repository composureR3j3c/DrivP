import 'package:driveridee/Models/language_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Text(
                AppLocalizations.of(context)!.labelWelcome,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ), 
              SizedBox(
                height: 30,
              ),
              
              // _createLanguageDropDown()
            ],
          ),
        ),
      );

  // _createLanguageDropDown() {
  //   return DropdownButton<LanguageData>(
  //     iconSize: 30,
  //     hint: Text("SelectLanguage"),
  //     // onChanged: (LanguageData? language) {
  //     //   changeLanguage(context, language!.languageCode);
  //     //   print("language" + language!.languageCode);
  //     },
  //     items: LanguageData.languageList()
  //         .map<DropdownMenuItem<LanguageData>>(
  //           (e) => DropdownMenuItem<LanguageData>(
  //             value: e,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: <Widget>[
  //                 Text(
  //                   e.flag,
  //                   style: TextStyle(fontSize: 30),
  //                 ),
  //                 Text(e.name)
  //               ],
  //             ),
  //           ),
  //         )
  //         .toList(),
  //   );
  // }
}
