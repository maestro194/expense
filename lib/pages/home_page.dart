import 'package:expense/database/expense_database.dart';
import 'package:expense/pages/components/bar_graph.dart';
import 'package:expense/pages/components/custom_app_bar.dart';
import 'package:expense/pages/components/get_expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/add_expense_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // graph data future
  // Future<Map<int, double>>? _MonthlyTotalsFuture;


  @override
  void initState() {
    Provider.of<ExpenseDatabase>(context, listen: false).getAllExpenses();

    // load future
    // _MonthlyTotalsFuture = Provider.of <ExpenseDatabase>(context, listen: false).getMonthlyTotals();

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
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: const SafeArea(
        child: Column(
          children: [ 
            // Bar graph
            SizedBox(
              height: 250,
              // child: FutureBuilder(
              //   future: , 
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.done) {
              //       final MonthlyTotals = snapshot.data ?? {};

              //       List<double> MonthlySummary = List.generate(weekCount, (index) => MonthlyTotals[index] ?? 0.0);
              //     }
              //   }
              // ),
            ),
            GetExpensesList(),
            // CustomAppBar(),
          ],
        ),
      ),
    );
  }
}