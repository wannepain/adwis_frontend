import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoaderCenter extends StatefulWidget {
  const LoaderCenter({super.key});

  @override
  State<LoaderCenter> createState() => _LoaderCenter();
}

class _LoaderCenter extends State<LoaderCenter> {
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showOverlay();
    });
  }

  void _showOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0, // Adjust as needed
        left: 0,
        right: 0,
        bottom: 0,
        child: Center(
          child: LoadingAnimationWidget.inkDrop(
              color: Color.fromRGBO(51, 101, 138, 1), size: 50),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(); // Empty widget since overlay is separate
  }
}
