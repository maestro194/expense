import 'package:expense/database/expense_database.dart';
import 'package:expense/models/account.dart';
import 'package:expense/models/expense.dart';
import 'package:expense/pages/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

class ExpenseInfo extends StatefulWidget {
  final Expense expense;
  final String actionType;

  const ExpenseInfo(
      {super.key, required this.expense, required this.actionType});

  @override
  State<ExpenseInfo> createState() => _ExpenseInfoState();
}

class _ExpenseInfoState extends State<ExpenseInfo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController accountController = TextEditingController();

  List<Account> accounts = [];

  @override
  void initState() {
    titleController.text = widget.expense.title;
    amountController.text = widget.expense.amount.toString();
    accountController.text = widget.expense.account.toString();

    // get accounts
    context.read<ExpenseDatabase>().getAllAccounts();
    accounts = context.read<ExpenseDatabase>().accounts;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.actionType == "edit" ? "Edit Expense" : "Add Expense",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold)),
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
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: amountController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Amount",
                ),
              ),
              const SizedBox(height: 10),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: accounts.map((account) {
                    return ElevatedButton(
											style: ElevatedButton.styleFrom(
												backgroundColor: accountController.text == account.name ? Colors.grey[400] : null,
											),
                      onPressed: () => setState(() {
												accountController.text = account.name;
											}),
                      
                      child: Text(account.name),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 10),

              // Expanded(
              //   child: Consumer<ExpenseDatabase>(
              //     builder: (context, value, child) => Scaffold(
              //       body: SafeArea(
              //         child: ListView.builder(
              //           itemCount: value.accounts.length,
              //           itemBuilder: (context, index) {
              //             Account account = value.accounts[index];
              //             return ListTile(
              //               title: Text(account.name),
              //               onTap: () {
              //                 accountController.text = account.name;
              //               },
              //             );
              //           }
              //         ),
              //     )),
              //   ),
              // ),
              // const SizedBox(height: 10),

              TextField(
                controller: accountController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Account",
                ),
              ),

              const SizedBox(height: 10),

              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                if (widget.actionType == "add")
                  ElevatedButton(
                    onPressed: addExpense,
                    child: const Text("Add"),
                  ),
                const SizedBox(width: 10),
                if (widget.actionType == "edit")
                  ElevatedButton(
                    onPressed: updateExpense,
                    child: const Text("Edit"),
                  ),
                const SizedBox(width: 10),
                if (widget.actionType == "edit")
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
    );
  }

  void addExpense() async {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        convertStringToDouble(amountController.text) == 0) {
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
