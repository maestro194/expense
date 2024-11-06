import 'package:expense/database/expense_database.dart';
// import 'package:expense/pages/components/bar_graph.dart';
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Hello,",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Welcome back!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 200,
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              )
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 200,
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              )
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 200,
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              )
            ),
          ],
        ),
        // children: [
        //   // Bar graph
        //   SizedBox(
        //     height: 250,
        //     // child: FutureBuilder(
        //     //   future: ,
        //     //   builder: (context, snapshot) {
        //     //     if (snapshot.connectionState == ConnectionState.done) {
        //     //       final MonthlyTotals = snapshot.data ?? {};

        //     //       List<double> MonthlySummary = List.generate(weekCount, (index) => MonthlyTotals[index] ?? 0.0);
        //     //     }
        //     //   }
        //     // ),
        //   ),
        //   GetExpensesList(),
        //   // CustomAppBar(),
        // ],
      ),
    );
  }
}
