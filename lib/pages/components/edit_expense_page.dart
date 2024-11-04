import 'package:expense/models/expense.dart';
import 'package:expense/pages/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

import '../../database/expense_database.dart';

class EditExpensePage extends StatefulWidget {
  final Expense expense;
  const EditExpensePage({super.key, required this.expense});

  @override
  State<EditExpensePage> createState() => _EditExpensePageState();
}

class _EditExpensePageState extends State<EditExpensePage> {
  // text edit controller
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.expense.title;
    amountController.text = widget.expense.amount.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "editExpense",
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Edit Expense",
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
                  controller: amountController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Amount",
                  ),
                ),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  ElevatedButton(
                    onPressed: updateExpense,
                    child: const Text("Edit"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: deleteExpense,
                    child: const Text("Delete"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
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

  void updateExpense() async {
    Expense editedExpense = Expense(
      title: titleController.text.isNotEmpty
          ? titleController.text
          : widget.expense.title,
      amount: amountController.text.isNotEmpty
          ? convertStringToDouble(amountController.text)
          : widget.expense.amount,
      date: widget.expense.date,
    );

    Id id = widget.expense.id;

    // add the expense
    await context.read<ExpenseDatabase>().updateExpense(id, editedExpense);

    Navigator.pop(context);
  }

  void deleteExpense() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete"),
          content: const Text("Are you sure you want to delete this expense?"),
          actions: [
            ElevatedButton(
              onPressed: () async {
                // delete the expense
                await context
                    .read<ExpenseDatabase>()
                    .deleteExpense(widget.expense);

                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Delete"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Discard"),
            )
          ],
        );
      },
    );
  }
}
