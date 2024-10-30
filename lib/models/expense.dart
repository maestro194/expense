import 'package:isar/isar.dart';

// line needed to generate isar file
// cmd: dart run build_runner build
part 'expense.g.dart';

@Collection()
class Expense {
  Id id = Isar.autoIncrement;
  final String title;
  final double amount;
  final DateTime date;

  Expense({
    required this.title, 
    required this.amount, 
    required this.date
  });
}