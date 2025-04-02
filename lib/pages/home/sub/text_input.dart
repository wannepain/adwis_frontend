import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/home/sub/textfield_with_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextInput extends ConsumerWidget {
  const TextInput(
      {super.key, this.isDisabled = false, required this.returnText});
  final Function returnText;
  final bool isDisabled;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("is TextInput disabled: $isDisabled");
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isDisabled
                ? HexToRgba().convert("33658A", 0.50)
                : HexToRgba().convert("33658A", 1),
            width: 1,
          ),
          color: isDisabled
              ? HexToRgba().convert("EDF3F8", 0.5)
              : HexToRgba().convert("EDF3F8", 1),
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: isDisabled
                  ? HexToRgba().convert("33658A", 0.30)
                  : HexToRgba().convert("33658A", 0.7),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: TextFieldWithIcon(
          returnText: returnText,
          isDisabled: isDisabled,
        ),
      ),
    );
  }
}
