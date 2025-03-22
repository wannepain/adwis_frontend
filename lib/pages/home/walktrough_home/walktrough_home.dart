// import 'package:adwis_frontend/providers/utils/walktrough_provider.dart';
// import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';

// class WalkthroughHome extends ConsumerWidget {
//   final String text;
//   final String orientation;

//   WalkthroughHome({
//     super.key,
//     required this.text,
//     this.orientation = "bottom",
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     bool isVertical = orientation == "bottom" || orientation == "top";

//     List<Widget> _widgetList = [
//       Container(
//         decoration: BoxDecoration(
//           color: HexToRgba().convert("080705", 1),
//           borderRadius: BorderRadius.all(Radius.circular(9)),
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 12),
//         child: IntrinsicWidth(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 constraints: BoxConstraints(minWidth: 50, maxWidth: 150),
//                 child: Text(
//                   text,
//                   style: TextStyle(
//                     fontFamily: GoogleFonts.inter().fontFamily,
//                     fontSize: 14,
//                     color: HexToRgba().convert("FCFEFF", 0.9),
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   ref.read(walkthroughProvider.notifier).increment();
//                 },
//                 child: Text(
//                   "next",
//                   style: TextStyle(
//                     fontFamily: GoogleFonts.inter().fontFamily,
//                     fontSize: 14,
//                     color: HexToRgba().convert("B8E1FF", 0.9),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       Container(
//         transform: Matrix4.translationValues(
//           !isVertical
//               ? orientation == "right"
//                   ? -8
//                   : 8
//               : 0,
//           isVertical
//               ? orientation == "bottom"
//                   ? -8
//                   : 8
//               : 0,
//           0,
//         ),
//         child: CustomPaint(
//           size: Size(36, 36),
//           painter: RoundedTipTrianglePainter(
//             bottomCornerRadius: 4,
//             color: HexToRgba().convert("080705", 1),
//             orientation: orientation,
//           ),
//         ),
//       )
//     ];
//     return Container(
//       child: isVertical
//           ? Column(
//               children: [
//                 if (orientation == "bottom")
//                   for (int i = 0; i < _widgetList.length; i++) _widgetList[i],
//                 if (orientation == "top")
//                   for (int i = 0; i < _widgetList.length; i++)
//                     _widgetList.reversed.toList()[i]
//               ],
//             )
//           : Row(
//               children: [
//                 if (orientation == "right")
//                   for (int i = 0; i < _widgetList.length; i++) _widgetList[i],
//                 if (orientation == "left")
//                   for (int i = 0; i < _widgetList.length; i++)
//                     _widgetList.reversed.toList()[i]
//               ],
//             ),
//     );
//   }
// }

// class RoundedTipTrianglePainter extends CustomPainter {
//   final double bottomCornerRadius;
//   final Color color;
//   final String orientation;

//   RoundedTipTrianglePainter({
//     this.bottomCornerRadius = 20.0,
//     this.color = Colors.black,
//     this.orientation = "bottom",
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;

//     final double x = size.width;
//     final double y = size.height;
//     Path path = Path();

//     if (orientation == "bottom") {
//       path.moveTo(0, 0);
//       path.lineTo(x, 0);
//       path.lineTo(x / 2 + bottomCornerRadius, y - bottomCornerRadius);
//       path.quadraticBezierTo(
//           x / 2, y, x / 2 - bottomCornerRadius, y - bottomCornerRadius);
//       path.close();
//     } else if (orientation == "top") {
//       path.moveTo(x / 2 - bottomCornerRadius, bottomCornerRadius);
//       path.quadraticBezierTo(
//           x / 2, 0, x / 2 + bottomCornerRadius, bottomCornerRadius);
//       path.lineTo(x, y);
//       path.lineTo(0, y);
//       path.close();
//     } else if (orientation == "left") {
//       path.moveTo(x, 0);
//       path.lineTo(x, y);
//       path.lineTo(bottomCornerRadius, y / 2 + bottomCornerRadius);
//       path.quadraticBezierTo(
//           0, y / 2, bottomCornerRadius, y / 2 - bottomCornerRadius);
//       path.close();
//     } else if (orientation == "right") {
//       path.moveTo(0, 0);
//       path.lineTo(0, y);
//       path.lineTo(x - bottomCornerRadius, y / 2 + bottomCornerRadius);
//       path.quadraticBezierTo(
//           x, y / 2, x - bottomCornerRadius, y / 2 - bottomCornerRadius);
//       path.close();
//     }

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
import 'package:adwis_frontend/providers/utils/walktrough_provider.dart';
import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class WalkthroughHome extends ConsumerStatefulWidget {
  final String text;
  final String orientation;
  final int totalIncrements;

  WalkthroughHome({
    super.key,
    required this.text,
    this.totalIncrements = 1,
    this.orientation = "bottom",
  });

  @override
  _WalkthroughHomeState createState() => _WalkthroughHomeState();
}

class _WalkthroughHomeState extends ConsumerState<WalkthroughHome> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final increments = ref.watch(walkthroughProvider);
    bool isVertical =
        widget.orientation == "bottom" || widget.orientation == "top";

    List<Widget> _widgetList = [
      Container(
        decoration: BoxDecoration(
          color: HexToRgba().convert("080705", 1),
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: IntrinsicWidth(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                constraints: BoxConstraints(minWidth: 50, maxWidth: 150),
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontSize: 14,
                    color: HexToRgba().convert("FCFEFF", 0.9),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.read(walkthroughProvider.notifier).increment();
                },
                child: Text(
                  increments + 1 == widget.totalIncrements ? "finish" : "next",
                  style: TextStyle(
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontSize: 14,
                    color: HexToRgba().convert("B8E1FF", 0.9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        transform: Matrix4.translationValues(
          !isVertical
              ? widget.orientation == "right"
                  ? -8
                  : 8
              : 0,
          isVertical
              ? widget.orientation == "bottom"
                  ? -8
                  : 8
              : 0,
          0,
        ),
        child: CustomPaint(
          size: Size(36, 36),
          painter: RoundedTipTrianglePainter(
            bottomCornerRadius: 4,
            color: HexToRgba().convert("080705", 1),
            orientation: widget.orientation,
          ),
        ),
      )
    ];

    return AnimatedOpacity(
      opacity: _opacity,
      duration: Duration(milliseconds: 500),
      child: Container(
        child: isVertical
            ? Column(
                children: [
                  if (widget.orientation == "bottom")
                    for (int i = 0; i < _widgetList.length; i++) _widgetList[i],
                  if (widget.orientation == "top")
                    for (int i = 0; i < _widgetList.length; i++)
                      _widgetList.reversed.toList()[i]
                ],
              )
            : Row(
                children: [
                  if (widget.orientation == "right")
                    for (int i = 0; i < _widgetList.length; i++) _widgetList[i],
                  if (widget.orientation == "left")
                    for (int i = 0; i < _widgetList.length; i++)
                      _widgetList.reversed.toList()[i]
                ],
              ),
      ),
    );
  }
}

class RoundedTipTrianglePainter extends CustomPainter {
  final double bottomCornerRadius;
  final Color color;
  final String orientation;

  RoundedTipTrianglePainter({
    this.bottomCornerRadius = 20.0,
    this.color = Colors.black,
    this.orientation = "bottom",
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double x = size.width;
    final double y = size.height;
    Path path = Path();

    if (orientation == "bottom") {
      path.moveTo(0, 0);
      path.lineTo(x, 0);
      path.lineTo(x / 2 + bottomCornerRadius, y - bottomCornerRadius);
      path.quadraticBezierTo(
          x / 2, y, x / 2 - bottomCornerRadius, y - bottomCornerRadius);
      path.close();
    } else if (orientation == "top") {
      path.moveTo(x / 2 - bottomCornerRadius, bottomCornerRadius);
      path.quadraticBezierTo(
          x / 2, 0, x / 2 + bottomCornerRadius, bottomCornerRadius);
      path.lineTo(x, y);
      path.lineTo(0, y);
      path.close();
    } else if (orientation == "left") {
      path.moveTo(x, 0);
      path.lineTo(x, y);
      path.lineTo(bottomCornerRadius, y / 2 + bottomCornerRadius);
      path.quadraticBezierTo(
          0, y / 2, bottomCornerRadius, y / 2 - bottomCornerRadius);
      path.close();
    } else if (orientation == "right") {
      path.moveTo(0, 0);
      path.lineTo(0, y);
      path.lineTo(x - bottomCornerRadius, y / 2 + bottomCornerRadius);
      path.quadraticBezierTo(
          x, y / 2, x - bottomCornerRadius, y / 2 - bottomCornerRadius);
      path.close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
