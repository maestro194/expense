double convertStringToDouble(String value) {
  double? result = double.tryParse(value);
  return result ?? 0;
}

double amountFormatter(double amount, int decimalPlaces) {
  return double.parse(amount.toStringAsFixed(decimalPlaces));
}

String dateFormatter(DateTime date) {
  // time with stating 0s
  String day = date.day.toString().padLeft(2, '0');
  String month = date.month.toString().padLeft(2, '0');
  String year = date.year.toString();
  String hour = date.hour.toString().padLeft(2, '0');
  String minute = date.minute.toString().padLeft(2, '0');

  return "$day/$month/$year $hour:$minute";
}