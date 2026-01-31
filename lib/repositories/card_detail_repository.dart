import 'package:trilhaapp/models/card_details_model.dart';

class CardDetailRepository {
  Future<CardDetailsModel> get() async {
    await Future.delayed(Duration(milliseconds: 500));
    return CardDetailsModel(
      1,
      "Meu Card",
      'lib/assets/images/LPU.jpg',
      "Fusce sed maximus lorem. Aliquam volutpat, magna vitae porttitor sodales, mauris ex pharetra massa, et imperdiet tellus erat sit amet nibh. Duis finibus gravida scelerisque. Sed rhoncus vestibulum imperdiet. Curabitur non aliquet ipsum.",
    );
  }
}