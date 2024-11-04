import 'package:flutter/material.dart';

class BarGraph extends StatefulWidget {
  final List<double> monthlySummary;
  final int startDay;

  const BarGraph({
    super.key,
    required this.monthlySummary,
    required this.startDay,
  });

  @override
  State<BarGraph> createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> {
  // graph data
  List<IndividualBar> monthlySummary = [];

  void initGraphData() {
    monthlySummary = List.generate(widget.monthlySummary.length, 
      (index) => IndividualBar(
        amount: widget.monthlySummary[index],
        day: widget.startDay + index,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Bar Graph",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class IndividualBar {
  final double amount;
  final int day;

  IndividualBar({required this.amount, required this.day});
}