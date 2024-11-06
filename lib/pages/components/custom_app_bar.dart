import 'package:expense/pages/budgets.dart';
import 'package:expense/pages/home_page.dart';
import 'package:expense/pages/settings.dart';
import 'package:expense/pages/transactions_page.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final double horizontalPadding = 1;
  final double verticalPadding = 1;
  final double iconSize = 30;
  final double fontSize = 12;

  int _currentIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    TransactionsPage(),
    BudgetsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          // padding: const EdgeInsets.all(5),
          child: Row(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  _currentIndex = 0;
                }),
                child: 
                Column(
                  children: [
                    Icon(
                      Icons.home,
                      size: iconSize,
                      color: _currentIndex == 0 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  _currentIndex = 1;
                }),
                child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.list,
                      size: iconSize,
                      color: _currentIndex == 1 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      "Transactions",
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  _currentIndex = 2;
                }),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_balance_wallet,
                      size: iconSize,
                      color: _currentIndex == 2 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      "Budgets",
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  _currentIndex = 3;
                }),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings,
                      size: iconSize,
                      color: _currentIndex == 3 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
