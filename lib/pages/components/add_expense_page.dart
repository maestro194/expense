import 'package:expense/models/account.dart';
import 'package:expense/models/expense.dart';
import 'package:expense/pages/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/expense_database.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  // text edit controller
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "addExpense",
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Add Expense",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Title",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  controller: amountController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Amount",
                  ),
                ),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  ElevatedButton(
                    onPressed: addExpense,
                    child: const Text("Submit"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Discard"),
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addExpense() async {
    if (titleController.text.isEmpty 
    || amountController.text.isEmpty
    || convertStringToDouble(amountController.text) == 0) {
      // give a warning
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Warning"),
            content: const Text("Please fill in all fields"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          );
        });
    } else {
      Expense newExpense = Expense(
        title: titleController.text,
        amount: convertStringToDouble(amountController.text),
        date: DateTime.now(),
      );

      // add the expense
      await context.read<ExpenseDatabase>().addExpense(newExpense);

      Navigator.pop(context);
    }
  }

  void addAccount() async {
    Account account = Account(
      name: titleController.text,
      balance: convertStringToDouble(amountController.text),
    );

    // add the account
    await context.read<ExpenseDatabase>().addAccount(account);
  }
}
