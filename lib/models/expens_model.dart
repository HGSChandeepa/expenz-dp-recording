//enum for expense categories
import 'package:flutter/material.dart';

enum ExpenceCategory {
  food,
  transport,
  health,
  shopping,
  subscriptions,
}

//category images
final Map<ExpenceCategory, String> expenseCategoriesImages = {
  ExpenceCategory.food: "assets/images/restaurant.png",
  ExpenceCategory.transport: "assets/images/car.png",
  ExpenceCategory.health: "assets/images/health.png",
  ExpenceCategory.shopping: "assets/images/bag.png",
  ExpenceCategory.subscriptions: "assets/images/bill.png",
};

//category colors
final Map<ExpenceCategory, Color> expenseCategoriesColors = {
  ExpenceCategory.food: const Color(0xFFE57373),
  ExpenceCategory.transport: const Color(0xFF81C784),
  ExpenceCategory.health: const Color(0xFF64B5F6),
  ExpenceCategory.shopping: const Color(0xFFFFD54F),
  ExpenceCategory.subscriptions: const Color(0xFF9575CD),
};

//model
class Expense {
  final int id;
  final String title;
  final double amount;
  final ExpenceCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
    required this.description,
  });
}
