import 'package:adwis_frontend/pages/home/sub/Stages/circle.dart';
import 'package:adwis_frontend/pages/home/sub/Stages/line.dart';
import 'package:adwis_frontend/providers/stages_provider.dart';
import 'package:adwis_frontend/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Stages extends ConsumerStatefulWidget {
  const Stages({super.key});

  @override
  ConsumerState<Stages> createState() => _StagesState();
}

class _StagesState extends ConsumerState<Stages> {
  @override
  Widget build(BuildContext context) {
    final int currentStage = ref.watch(stagesProvider)["current_stage"];
    final bool isUnlimited = ref.watch(userProvider)["isUnlimited"];
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            // if (currentStage > 1) {
            //   ref.read(stagesProvider.notifier).set();
            // }
          },
          child: Circle(
            isCompleted: currentStage > 1,
            isUnlocked: true,
            inProgress: currentStage == 1,
            stage: 1,
          ),
        ),
        Line(
          isCompleted: currentStage > 1 && isUnlimited,
          inProgress: currentStage > 1 && !isUnlimited,
        ),
        GestureDetector(
          onTap: () {
            // if (currentStage > 1) {
            //   ref.read(stagesProvider.notifier).set();
            // }
          },
          child: Circle(
            isCompleted: currentStage > 2,
            isUnlocked: isUnlimited,
            inProgress: currentStage == 2,
            stage: 2,
          ),
        ),
        Line(
          isCompleted: currentStage > 2 && isUnlimited,
          inProgress: currentStage > 2 && !isUnlimited,
        ),
        GestureDetector(
          onTap: () {
            // if (currentStage > 1) {
            //   ref.read(stagesProvider.notifier).set();
            // }
          },
          child: Circle(
            isCompleted: currentStage > 3,
            isUnlocked: isUnlimited,
            inProgress: currentStage == 3,
            stage: 3,
          ),
        ),
      ],
    );
  }
}
