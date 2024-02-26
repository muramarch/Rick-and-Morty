import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanget;
  final String innerText;
  const SearchTextField({
    required this.controller,
    required this.onChanget,
    required this.innerText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        TextField(
          controller: controller,
          onChanged: onChanget,
          style: TextStyle(color: Colors.grey[300]),
          decoration: InputDecoration(
              hintText: innerText,
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(91, 105, 117, 1),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Color.fromRGBO(91, 105, 117, 1),
              ),
              filled: true,
              fillColor: Color.fromRGBO(21, 42, 58, 1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.all(10)),
        ),
      ],
    );
  }
}
