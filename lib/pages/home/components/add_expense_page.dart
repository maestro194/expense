import 'package:expense/models/expense.dart';
import 'package:expense/pages/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database/expense_database.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Title", 
                  border: OutlineInputBorder()
                ),
              ),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  hintText: "Amount", 
                  border: OutlineInputBorder()
                ),
              ),
              // submit button
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton(
                  onPressed: () async {
                    if (titleController.text.isEmpty ||
                        amountController.text.isEmpty) {
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
                        date: DateTime.now()
                      );

                      // add the expense
                      await context.read<ExpenseDatabase>().addExpense(newExpense);

                      Navigator.pop(context);
                    }
                  },
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
    );
  }
}
