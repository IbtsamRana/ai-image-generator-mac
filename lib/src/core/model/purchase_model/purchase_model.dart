import '../../service/subscription_service.dart';

class PurchaseModel {
  final String? productId;
  final String? transactionDate;
  const PurchaseModel({this.productId, this.transactionDate});
  factory PurchaseModel.fromJson(Map<String, dynamic> json) => PurchaseModel(
      productId: json["productId"], transactionDate: json["transactionDate"]);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["transactionDate"] = transactionDate;
    data["productId"] = productId;
    return data;
  }

  bool get isPremium {
    if (transactionDate == null || productId == null) {
      return false;
    } else {
      final DateTime date =
          DateTime.fromMillisecondsSinceEpoch(int.parse(transactionDate!));

      // Assuming currentDate is the current date, you may need to replace it with the actual current date.
      final DateTime currentDate = DateTime.now();

      // Calculate the expiration date based on the product ID.
      final DateTime expirationDate =
          date.add(Duration(days: _extendDays(productId!)));

      // Check if the current date is before the expiration date to determine premium status.
      return currentDate.isBefore(expirationDate);
    }
  }

  int _extendDays(String id) {
    if (id == monthly) {
      return 7;
    } else if (id == yearly) {
      return 30;
    } else {
      return 0;
    }
  }
}
