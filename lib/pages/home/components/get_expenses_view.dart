import 'package:expense/database/expense_database.dart';
import 'package:expense/pages/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:expense/models/expense.dart';
import 'package:provider/provider.dart';

// stateful widget
class GetExpensesView extends StatefulWidget {
  const GetExpensesView({super.key});

  @override
  State<GetExpensesView> createState() => _GetExpensesViewState();
}

// state
class _GetExpensesViewState extends State<GetExpensesView> {
  
  @override
  void initState() {
    Provider.of<ExpenseDatabase>(context, listen: false).getAllExpenses();

    super.initState();
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
                Expense expense = value.expenses[index];
                
                return ListTile(
                  title: Text(expense.title),
                  subtitle: Text(dateFormatter(expense.date)),
                  trailing: Text(amountFormatter(expense.amount, 0).toString()),
                );
              },
            ),
          ),
        )
      ),
    );
  }
}