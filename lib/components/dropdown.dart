import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final List<String> options;
  final String? selectedValue;
  final Function(String?)? onChanged; // Update the type here

  Dropdown({
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selectedValue,
      onChanged: widget.onChanged,
      items: widget.options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontWeight: FontWeight.w400),),
        );
      }).toList(),
    );
  }
}
