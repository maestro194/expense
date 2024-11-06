import "package:expense/pages/components/custom_app_bar.dart";
import "package:flutter/material.dart";
import "package:expense/database/expense_database.dart";
import "package:provider/provider.dart";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // database initialization
  await ExpenseDatabase.init();

  runApp(ChangeNotifierProvider(
    create: (context) => ExpenseDatabase(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomAppBar(),
    );
  }
}