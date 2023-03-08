import 'package:flutter/material.dart';

import '../Globals/Global.dart';

var list = <Map>[
  {"name": "Economy", "code": "econ"},
  {"name": "Mini Van", "code": "minVan"},
  {"name": "Mini Bus", "code": "minBus"}
];

class DropdownButtonType extends StatefulWidget {
  const DropdownButtonType({Key? key}) : super(key: key);
  @override
  State<DropdownButtonType> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonType> {
  String dropdownValue = list.first["code"];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black87),
      underline: Container(
        height: 10,
        color: Colors.black54,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          finalDropdownValue = dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((Map value) {
        return DropdownMenuItem<String>(
          value: value["code"],
          child: Text(value["name"]),
        );
      }).toList(),
    );
  }
}
