import 'package:expense/models/account.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class AccountDatabase extends ChangeNotifier {
  static late Isar _isar;

  List<Account> _accounts = [];

  /*
    SETUP
  */

  // initialize the database
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([AccountSchema], directory: dir.path);
  }

  /*
    GETTERS
  */

  List<Account> get accounts => _accounts;

  /*
    OPERATIONS
  */

  // add a new account
  Future<void> addAccount(Account newAccount) async {
    await _isar.writeTxn(() => _isar.accounts.put(newAccount));

    // update the list of accounts
    await getAllAccounts();
  }

  // get all accounts
  Future<void> getAllAccounts() async {
    List<Account> accounts = await _isar.accounts.where().findAll();

    _accounts = accounts;

    // UI update
    notifyListeners();
  }

  // update an account
  Future<void> updateAccount(Account updatedAccount) async {
    await _isar.writeTxn(() => _isar.accounts.put(updatedAccount));

    // update the list of accounts
    await getAllAccounts();
  }
}