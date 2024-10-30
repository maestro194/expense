import 'package:expense/database/expense_database.dart';
import 'package:expense/pages/home/components/get_expenses_view.dart';
import 'package:flutter/material.dart';
import 'package:expense/pages/home/components/custom_app_bar.dart';
import 'package:provider/provider.dart';

import 'components/add_expense_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<ExpenseDatabase>(context, listen: false).getAllExpenses();

    super.initState();
  }
  
  void openExpenseForm() {
    // open the expense form
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddExpensePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openExpenseForm();
        },
        heroTag: "addExpense",
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: const SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            GetExpensesView(),
            CustomAppBar(),
          ],
        ),
      ),
    );
  }
}