import 'package:adwis_frontend/pages/home/sub/career/career_button.dart';
import 'package:adwis_frontend/providers/restart_provider.dart';
import 'package:adwis_frontend/utils/go_unlimited_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adwis_frontend/services/chatbot_service.dart';

class CareerCard extends ConsumerStatefulWidget {
  final List history;
  final double size;
  final Function onCareerAccept;
  final Function onCareerDecline;
  final bool? declined;
  CareerCard({
    super.key,
    required this.history,
    this.size = 200,
    required this.onCareerAccept,
    required this.onCareerDecline,
    this.declined = null,
  });

  @override
  ConsumerState<CareerCard> createState() => _CareerCardState();
}

class _CareerCardState extends ConsumerState<CareerCard> {
  List data = [];
  String salary = "";
  String title = "";
  String description = "";
  Map careerResult = {};
  late SnackBarController controller;

  double opacityLevel = 0.0; // Start hidden

  void setData() async {
    final response = await ChatbotService().getCareer(
      history: widget.history,
    );
    data.add(response);
    final startingSalary = response["Starting_Salary"];

    setState(() {
      salary = "$startingSalary";
      title = response["Career_Name"] ?? "";
      description = response["Description"] ?? "";
      careerResult = response;
    });

    //ref.read(historyProvider.notifier).addToFile(response);

    // Delay animation slightly to allow UI build
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        opacityLevel = 1.0;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setData();
    final int careerDeclines = ref.read(restartProvider)["career_declines"]!;
    Future(() async {
      if (careerDeclines > 1) {
        ref.read(restartProvider.notifier).seShowingSnackBar(true);
        controller = showGoUnlimitedSnackBar("for more career options");
        ref.read(restartProvider.notifier).seShowingSnackBar(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.6;
    int career_declines = ref.watch(restartProvider)["career_declines"]!;
    print("widget.declined ${widget.declined}");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: opacityLevel,
              child: Container(
                width: c_width,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(143, 198, 238, 0.5),
                      offset: Offset(0, 0),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage("assets/images/degree_2.jpg"),
                    colorFilter: ColorFilter.mode(
                      Colors.black.withAlpha(100),
                      BlendMode.srcATop,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(height: widget.size),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: ((c_width - 20) / 3) * 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Color.fromRGBO(252, 254, 255, 1),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          GoogleFonts.inter().fontFamily,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    description,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromRGBO(252, 254, 255, 0.7),
                                      fontFamily:
                                          GoogleFonts.inter().fontFamily,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: (c_width - 20) / 3,
                              alignment: Alignment.center,
                              child: Text(
                                "\$$salary",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromRGBO(252, 254, 255, 1),
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            widget.declined == null
                ? Row(
                    children: [
                      SizedBox(
                        child: CareerButton(
                          type: "yes",
                          onPressed: () {
                            if (careerResult.isEmpty) {
                              return;
                            }
                            if (career_declines > 1) {
                              controller.dismiss();
                              ref
                                  .read(restartProvider.notifier)
                                  .seShowingSnackBar(false);
                            }
                            widget.onCareerAccept(careerResult);
                          },
                        ),
                        width: career_declines < 2 ? c_width * 0.59 : c_width,
                      ),
                      if (career_declines < 2)
                        SizedBox(
                          width: c_width * 0.01,
                        ),
                      if (career_declines < 2)
                        SizedBox(
                          child: CareerButton(
                            type: "no",
                            onPressed: widget.onCareerDecline,
                          ),
                          width: c_width * 0.40,
                        ),
                    ],
                  )
                : widget.declined == true
                    ? Row(
                        children: [
                          SizedBox(
                            child: CareerButton(
                              type: "no",
                              onPressed: () {},
                              isDisabled: true,
                            ),
                            width: c_width,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          SizedBox(
                            child: CareerButton(
                              type: "yes",
                              onPressed: () {},
                              isDisabled: true,
                            ),
                            width: c_width,
                          ),
                        ],
                      ),
          ],
        ),
      ],
    );
  }
}
