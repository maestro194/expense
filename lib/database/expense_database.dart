import 'package:flutter/material.dart';

import 'package:expense/models/expense.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class ExpenseDatabase extends ChangeNotifier {
  static late Isar _isar;
  List<Expense> _expenses = [];
  /*
    SETUP
  */

  // initialize the database
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([ExpenseSchema], directory: dir.path);
  }

  /*
    GETTERS
  */

  List<Expense> get expenses => _expenses;

  /*
    OPERATIONS
  */

  // add a new expense
  Future<void> addExpense(Expense newExpense) async {
    await _isar.writeTxn(() => _isar.expenses.put(newExpense));

    // update the list of expenses
    await getAllExpenses();
  }

  // read all expenses
  Future<void> getAllExpenses() async {
    List<Expense> expenses = await _isar.expenses.where().findAll();

    _expenses = expenses;

    // UI update
    notifyListeners();
  }

  // update
  Future<void> updateExpense(Id id, Expense updatedExpense) async {
    // id check
    if (id != updatedExpense.id) {
      throw Exception('ID mismatch');
    }

    // update the expense
    await _isar.writeTxn(() => _isar.expenses.put(updatedExpense));

    // update the list of expenses
    await getAllExpenses();
  }

  // delete
  Future<void> deleteExpense(Expense expense) async {
    await _isar.writeTxn(() => _isar.expenses.delete(expense.id));

    // update the list of expenses
    await getAllExpenses();
  }

  /*
    HELPERS
  */
}