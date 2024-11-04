import 'package:expense/database/expense_database.dart';
import 'package:expense/pages/components/expense_info.dart';
import 'package:expense/pages/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:expense/models/expense.dart';
import 'package:provider/provider.dart';

// stateful widget
class GetExpensesList extends StatefulWidget {
  const GetExpensesList({super.key});

  @override
  State<GetExpensesList> createState() => _GetExpensesListState();
}

// state
class _GetExpensesListState extends State<GetExpensesList> {
  
  @override
  void initState() {
    Provider.of<ExpenseDatabase>(context, listen: false).getAllExpenses();

    super.initState();
  }

  Widget tile(Expense expense) {
    return ListTile(
      onTap: () {
        openEditExpense(expense, "edit");
      },
      title: Text(expense.title),
      subtitle: Text(dateFormatter(expense.date)),
      trailing: Text(amountFormatter(expense.amount, 0).toString()),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ExpenseDatabase>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey[300],
          body: SafeArea(
            child: ListView.builder(
              itemCount: value.expenses.length,
              itemBuilder: (context, index) {
                Expense expense = value.expenses[value.expenses.length - index - 1];
                return tile(expense);
              },
            ),
          ),
        )
      ),
    );
  }

  void openEditExpense(Expense expense, String actionType) {
    // open the expense form
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseInfo(expense: expense, actionType: actionType),
      ),
    );
  }
}