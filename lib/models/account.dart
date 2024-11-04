import 'package:isar/isar.dart';

part 'account.g.dart';

@Collection()
class Account {
  Id id = Isar.autoIncrement;
  final String name;
  final double balance;

  Account({
    required this.name,
    required this.balance,
  });
}