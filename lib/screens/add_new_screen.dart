import 'package:expenz/models/expens_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/services/expnse_service.dart';
import 'package:expenz/services/income_service.dart';
import 'package:expenz/widgets/custum_button.dart';
import 'package:flutter/material.dart';

import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:intl/intl.dart';

class AddNewScreen extends StatefulWidget {
  final Function(Expense) addExpense;
  final Function(Income) addIncome;
  const AddNewScreen({
    super.key,
    required this.addExpense,
    required this.addIncome,
  });

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  //state to track the expence or income
  int _selectedMethode = 0;
  ExpenceCategory _expenceCategory = ExpenceCategory.health;
  IncomeCategory _incomeCategory = IncomeCategory.salary;
  final TextEditingController _titleControoller = TextEditingController();
  final TextEditingController _descriptionControoller = TextEditingController();
  final TextEditingController _amountControoller = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  @override
  void dispose() {
    _titleControoller.dispose();
    _amountControoller.dispose();
    _descriptionControoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethode == 0 ? kRed : kGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultpadding),
            child: Stack(
              children: [
                //expense and income toggle menu
                Padding(
                  padding: const EdgeInsets.all(kDefaultpadding),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethode = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethode == 0 ? kRed : kWhite,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 60,
                                vertical: 10,
                              ),
                              child: Text(
                                "Expense",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      _selectedMethode == 0 ? kWhite : kBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethode = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethode == 1 ? kGreen : kWhite,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 60,
                                vertical: 10,
                              ),
                              child: Text(
                                "Income",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      _selectedMethode == 1 ? kWhite : kBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //Amount feild
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultpadding),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "How Much?",
                          style: TextStyle(
                            color: kLightGrey.withOpacity(0.8),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const TextField(
                          style: TextStyle(
                            fontSize: 60,
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: "0",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: kWhite,
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //user data from
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3,
                  ),
                  decoration: const BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      child: Column(
                        children: [
                          //category selector dropdown
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultpadding,
                                horizontal: 20,
                              ),
                            ),
                            items: _selectedMethode == 0
                                ? ExpenceCategory.values.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name),
                                    );
                                  }).toList()
                                : IncomeCategory.values.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name),
                                    );
                                  }).toList(),
                            value: _selectedMethode == 0
                                ? _expenceCategory
                                : _incomeCategory,
                            onChanged: (value) {
                              setState(() {
                                _selectedMethode == 0
                                    ? _expenceCategory =
                                        value as ExpenceCategory
                                    : _incomeCategory = value as IncomeCategory;
                              });
                            },
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          //title feild
                          TextFormField(
                            controller: _titleControoller,
                            decoration: InputDecoration(
                              hintText: "Title",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultpadding,
                                horizontal: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //description feild
                          TextFormField(
                            controller: _descriptionControoller,
                            decoration: InputDecoration(
                              hintText: "Description",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultpadding,
                                horizontal: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //amount feild
                          TextFormField(
                            controller: _amountControoller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Amount",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultpadding,
                                horizontal: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //date picker
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2025),
                                  ).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        _selectedDate = value;
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: kMainColor,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          color: kWhite,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Select Date",
                                          style: TextStyle(
                                            color: kWhite,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.yMMMd().format(_selectedDate),
                                style: const TextStyle(
                                  color: kGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          //time picker
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        _selectedTime = DateTime(
                                          _selectedDate.year,
                                          _selectedDate.month,
                                          _selectedDate.day,
                                          value.hour,
                                          value.minute,
                                        );
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: kYellow,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          color: kWhite,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Select Time",
                                          style: TextStyle(
                                            color: kWhite,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.jm().format(_selectedTime),
                                style: const TextStyle(
                                  color: kGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            color: kLightGrey,
                            thickness: 5,
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          //submit button
                          GestureDetector(
                            onTap: () async {
                              //save the expense or the income data into shared pref
                              if (_selectedMethode == 0) {
                                //adding expense
                                List<Expense> loadedExpenses =
                                    await ExpenseSercive().loadExpenses();

                                //create the expense to store
                                Expense expense = Expense(
                                  id: loadedExpenses.length + 1,
                                  title: _titleControoller.text,
                                  amount: _amountControoller.text.isEmpty
                                      ? 0
                                      : double.parse(_amountControoller.text),
                                  category: _expenceCategory,
                                  date: _selectedDate,
                                  time: _selectedTime,
                                  description: _descriptionControoller.text,
                                );

                                //add expense
                                widget.addExpense(expense);

                                //clear the feilds
                                _titleControoller.clear();
                                _amountControoller.clear();
                                _descriptionControoller.clear();
                              } else {
                                //load incomes
                                List<Income> loadedIncomes =
                                    await IncomeService().loadIncomes();
                                //create the new income
                                Income income = Income(
                                  id: loadedIncomes.length + 1,
                                  title: _titleControoller.text,
                                  amount: _amountControoller.text.isEmpty
                                      ? 0
                                      : double.parse(_amountControoller.text),
                                  category: _incomeCategory,
                                  date: _selectedDate,
                                  time: _selectedTime,
                                  description: _descriptionControoller.text,
                                );

                                //add income
                                widget.addIncome(income);
                                //clear the feilds
                                _titleControoller.clear();
                                _amountControoller.clear();
                                _descriptionControoller.clear();
                              }
                            },
                            child: CustomButton(
                              buttonName: "Add",
                              buttonColor:
                                  _selectedMethode == 0 ? kRed : kGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
