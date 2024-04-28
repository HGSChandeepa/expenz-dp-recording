import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:expenz/models/income_model.dart';

class IncomeService {
  // Define the key for storing incomes in shared preferences
  static const String _incomeKey = 'income';

  // Save the income to shared preferences

  Future<void> saveIncome(Income income, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      // Convert the existing incomes to a list of Income objects
      List<Income> existingIncomeObjects = [];

      if (existingIncomes != null) {
        existingIncomeObjects = existingIncomes
            .map((e) => Income.fromJSON(json.decode(e)))
            .toList();
      }

      // Add the new income to the list
      existingIncomeObjects.add(income);

      // Convert the list of Income objects back to a list of strings
      List<String> updatedIncome =
          existingIncomeObjects.map((e) => json.encode(e.toJSON())).toList();

      // Save the updated list of incomes to shared preferences
      await prefs.setStringList(_incomeKey, updatedIncome);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Income added Successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error on Adding Income!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //Load the income from shared preferences
  Future<List<Income>> loadIncomes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingIncomes = pref.getStringList(_incomeKey);

    // Convert the existing incomes to a list of income objects
    List<Income> loadedIcomes = [];
    if (existingIncomes != null) {
      loadedIcomes =
          existingIncomes.map((e) => Income.fromJSON(json.decode(e))).toList();
    }

    return loadedIcomes;
  }

  // Function to delete an income
  Future<void> deleteIncome(int id, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      // Convert the existing incomes to a list of Income objects
      List<Income> existingIncomeObjects = [];
      if (existingIncomes != null) {
        existingIncomeObjects = existingIncomes
            .map((e) => Income.fromJSON(json.decode(e)))
            .toList();
      }

      // Remove the income with the given id from the list
      existingIncomeObjects.removeWhere((income) => income.id == id);

      // Convert the list of Income objects back to a list of strings
      List<String> updatedIncomes =
          existingIncomeObjects.map((e) => json.encode(e.toJSON())).toList();

      // Save the updated list of incomes to shared preferences
      await prefs.setStringList(_incomeKey, updatedIncomes);

      //show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Income deleted successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      //show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error Deleting Income!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //delete all income from shared preferences

  Future<void> deleteAllIncomes(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove(_incomeKey);

      //show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("All Incomes Deleted!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error Deleting Incomes!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
