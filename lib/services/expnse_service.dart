import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:expenz/models/expens_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseSercive {
  //Define the key for storing expenses in shared preferences
  static const String _expenseKey = 'expenses';

  //Save the expense to shared preferences
  Future<void> saveExpenses(Expense expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String>? existingExpenses = prefs.getStringList(_expenseKey);

      //Convert the existing expenses to a list of Expense objects
      List<Expense> existingExpenseObjects = [];

      if (existingExpenses != null) {
        existingExpenseObjects = existingExpenses
            .map((e) => Expense.fromJSON(json.decode(e)))
            .toList();
      }

      // Add the new expense to the list
      existingExpenseObjects.add(expense);

      // Convert the list of Expense objects back to a list of strings
      List<String> updatedExpenses =
          existingExpenseObjects.map((e) => json.encode(e.toJSON())).toList();

      // Save the updated list of expenses to shared preferences
      await prefs.setStringList(_expenseKey, updatedExpenses);

      //show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Expense added successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      //show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error on Adding Expense!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //Load the expenses from shared preferences
  Future<List<Expense>> loadExpenses() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingExpenses = pref.getStringList(_expenseKey);

    // Convert the existing expenses to a list of Expense objects
    List<Expense> loadedEpenses = [];
    if (existingExpenses != null) {
      loadedEpenses = existingExpenses
          .map((e) => Expense.fromJSON(json.decode(e)))
          .toList();
    }

    return loadedEpenses;
  }
}
