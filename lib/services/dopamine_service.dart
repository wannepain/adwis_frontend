import 'dart:math'; // Import for random chance
import 'package:adwis_frontend/services/chatbot_service.dart';
import 'package:adwis_frontend/utils/compliment_snack_bar.dart';

class DopamineService {
  final Random _random = Random(); // Create a random instance

  Future<void> showCompliment({required List history}) async {
    if (_random.nextDouble() < 0.4) {
      // 40% chance
      final String? compliment =
          await ChatbotService().getCompliment(history: history);
      print("compliment: $compliment");
      if (compliment != null) {
        showComplimentSnackBar(compliment);
      }
    } else {
      print("Skipping compliment this time.");
    }
  }
}
