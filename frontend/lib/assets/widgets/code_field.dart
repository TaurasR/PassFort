import 'package:flutter/material.dart';

class CodeField extends StatelessWidget {
  CodeField({super.key});

  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 6; i++)
          Container(
            width: 50,
            height: 90,
            // color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(45)),
            ),
            child: TextField(
              focusNode: focusNodes[i],
              maxLines: null,
              expands: true,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              maxLength: 1,
              style: const TextStyle(
                fontSize: 30,
              ),
              decoration: const InputDecoration(
                counter: SizedBox.shrink(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                if (value.characters.isEmpty) {
                  if (i != 0) {
                    FocusScope.of(context).requestFocus(focusNodes[i - 1]);
                  }
                } else {
                  if (i != 5) {
                    FocusScope.of(context).requestFocus(focusNodes[i + 1]);
                  }
                }

                if (i == 5 && value.characters.isNotEmpty) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
            ),
          )
      ],
    );
  }
}
