import 'package:expenz/constants/colors.dart';
import 'package:expenz/models/expens_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/screens/add_new_screen.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profile_screen.dart';
import 'package:expenz/screens/transactions_screen.dart';
import 'package:expenz/services/expnse_service.dart';
import 'package:expenz/services/income_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //current page index
  int _currentPageIndex = 0;

  List<Expense> expenseList = [];
  List<Income> incomeList = [];

  @override
  void initState() {
    super.initState();
    fetchAllExpenses();
    fetchAllIncomes();
  }

  //Function to fetch expenses
  void fetchAllExpenses() async {
    List<Expense> loadedExpenses = await ExpenseSercive().loadExpenses();
    setState(() {
      expenseList = loadedExpenses;
    });
  }

  //Function to fetch all Incomes
  void fetchAllIncomes() async {
    List<Income> loadedIncomes = await IncomeService().loadIncomes();
    setState(() {
      incomeList = loadedIncomes;
    });
  }

  // Function to add a new expense
  void addNewExpense(Expense newExpense) async {
    await ExpenseSercive().saveExpenses(newExpense, context);

    // Update the list of expenses
    setState(() {
      expenseList.add(newExpense);
    });
  }

  // function to add new income
  void addNewIncome(Income newIncome) async {
    await IncomeService().saveIncome(newIncome, context);

    //upadted the income list
    setState(() {
      incomeList.add(newIncome);
    });
  }

  // function to remove an expense
  void removeExpense(Expense expense) {
    ExpenseSercive().deleteExpense(expense.id, context);
    setState(() {
      expenseList.remove(expense);
    });
  }

  //function to remove an income
  void removeIncome(Income income) {
    IncomeService().deleteIncome(income.id, context);
    setState(() {
      incomeList.remove(income);
    });
  }

  @override
  Widget build(BuildContext context) {
    //screens list
    final List<Widget> pages = [
      const HomeScreen(),
      TranscatiosScreen(
        expensesList: expenseList,
        incomesList: incomeList,
        onDismissedExpense: removeExpense,
        onDismissedIncome: removeIncome,
      ),
      AddNewScreen(
        addExpense: addNewExpense,
        addIncome: addNewIncome,
      ),
      const BudgetScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: kWhite,
                size: 30,
              ),
            ),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: "Budget",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}
