import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adwis_frontend/providers/popup_providers.dart';

class CloseButtonTimer extends ConsumerStatefulWidget {
  const CloseButtonTimer({super.key});

  @override
  ConsumerState<CloseButtonTimer> createState() => _CloseButtonTimerState();
}

class _CloseButtonTimerState extends ConsumerState<CloseButtonTimer> {
  bool canClose = false;
  int secondsRemaining = 3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining > 1) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          canClose = true;
          _timer?.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: canClose
          ? () {
              ref.read(popupProvider.notifier).setTo(value: false);
              Navigator.pushReplacementNamed(context, "/homepage");
            }
          : null, // Disable the button when it's not clickable
      icon: canClose
          ? Icon(
              Icons.close_rounded,
              size: 48,
              color: Color.fromRGBO(8, 7, 5, 1),
            )
          : SizedBox(
              height: 48,
              width: 48,
              child: Center(
                child: Text(
                  '$secondsRemaining',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
    );
  }
}
