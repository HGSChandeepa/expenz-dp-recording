import 'package:expenz/models/expens_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/widgets/expense_card.dart';
import 'package:expenz/widgets/income_card.dart';
import 'package:flutter/material.dart';

import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';

class TranscatiosScreen extends StatefulWidget {
  final List<Expense> expensesList;
  final List<Income> incomesList;
  final void Function(Expense) onDismissedExpense;
  final void Function(Income) onDismissedIncome;
  const TranscatiosScreen({
    super.key,
    required this.expensesList,
    required this.onDismissedExpense,
    required this.incomesList,
    required this.onDismissedIncome,
  });

  @override
  State<TranscatiosScreen> createState() => _TranscatiosScreenState();
}

class _TranscatiosScreenState extends State<TranscatiosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultpadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "See your financial report",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kMainColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Expenses",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //show all the expenses
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.expensesList.length,
                        itemBuilder: (context, index) {
                          final expense = widget.expensesList[index];

                          return Dismissible(
                            key: ValueKey(expense),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              setState(() {
                                widget.onDismissedExpense(expense);
                              });
                            },
                            child: ExpenseCard(
                              title: expense.title,
                              date: expense.date,
                              amount: expense.amount,
                              category: expense.category,
                              description: expense.description,
                              time: expense.time,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Incomes",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //show all the incomes
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.incomesList.length,
                        itemBuilder: (context, index) {
                          final income = widget.incomesList[index];

                          return Dismissible(
                            key: ValueKey(income),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              setState(() {
                                widget.onDismissedIncome(income);
                              });
                            },
                            child: IncomeCard(
                              title: income.title,
                              date: income.date,
                              amount: income.amount,
                              category: income.category,
                              description: income.description,
                              time: income.time,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
