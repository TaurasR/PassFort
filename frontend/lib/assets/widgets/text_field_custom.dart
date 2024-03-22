import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom(
      {super.key,
      required this.descText,
      this.descFontSize = 15,
      this.hintText,
      this.controller,
      this.mandatoryField = true,
      this.hideFieldText = false});

  final String descText;
  final double? descFontSize;
  final String? hintText;
  final TextEditingController? controller;
  final bool mandatoryField;
  final bool hideFieldText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 35, bottom: 2),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: descText,
                  style: TextStyle(
                    fontSize: descFontSize,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: (mandatoryField) ? ' *' : '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: 350,
            child: TextField(
              obscureText: hideFieldText,
              controller: controller,
              cursorColor: Colors.white,
              cursorWidth: 2,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 190, 190, 190)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                contentPadding: const EdgeInsets.only(left: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
