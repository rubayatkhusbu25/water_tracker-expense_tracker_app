import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/expense.dart';

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  final List<Expense> _expense = []; // model list
  final List<String> _categories = [
    // string of list
    'Food',
    'Transport',
    'Entertainment',
    'Bills'
  ];

  double _total = 0.0;

  double _credit = 1000; // single value updates

  // function-1 : Add function

  void _addExpense(
      String title, double amount, DateTime date, String category) {
    setState(() {
      _expense.add(Expense(
          // this is model class
          title: title, // this data are come from model called expense
          amount: amount,
          date: date,
          category: category));
      _total += (amount).clamp(0, _credit); // _total =_total + amount aki kotha
    });
  }

  // function-2 : Delete function

  void _deleteExpense(int index) {
    Expense deletedExpense = _expense[index]; // Save expense for undo option

    setState(() {
      _expense.removeAt(index);
      _total -= deletedExpense.amount;
    });

    // Delay to ensure the widget tree updates
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {});
    });
  }

  // function-3 : Update function

  void _updateExpense(int index, String titleN, double amountN, DateTime dateN,
      String categoryN) {
    setState(() {
      _total -= _expense[index].amount;

      _expense[index] = Expense(
          // this is model class
          title: titleN, // this data are come from model called expense
          amount: amountN,
          date: dateN,
          category: categoryN);
      _total += amountN;
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_total / _credit).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: Text(
          "Expense Tracker",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => _showCredit(context),
              icon: Icon(
                Icons.credit_card,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(.4),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "images/expense.png",
                      width: 300,
                      height: 150,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Your Daily Expanse Tracker",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              ),
            ),
            Divider(color: Colors.blue),
            Card(
              shape: RoundedRectangleBorder(
                  side:
                      BorderSide(color: Colors.blue, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Credit: \$ ${_credit.toString()}",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Wallet: \$ ${_credit - _total}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Expense: \$ ${_total}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: CircularProgressIndicator(
                            strokeAlign: 1,
                            backgroundColor: Colors.grey.shade200,
                            color: Colors.blue,
                            strokeWidth: 9,
                            value: progress,
                          ),
                        ),
                        Text(
                          "${(progress * 100).toInt()} %",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.blue),
            Expanded(
              child: ListView.builder(
                  itemCount: _expense.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(UniqueKey().toString()),
                      background: Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      secondaryBackground: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          _deleteExpense(index);
                        } else {
                          _showForm(context, index: index);
                        }
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ListTile(
                            hoverColor: Colors.red,
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              _expense[index].title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_expense[index].category),
                                Text(DateFormat.yMMMd()
                                    .format(_expense[index].date)),
                              ],
                            ),
                            trailing: Text(
                              "${_expense[index].amount.toString()} \$",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.blue,
        onPressed: () => _showForm(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showForm(BuildContext context, {int? index}) {
    TextEditingController titleController =
        TextEditingController(text: index != null ? _expense[index].title : "");
    TextEditingController amountController = TextEditingController(
        text: index != null ? _expense[index].amount.toString() : "");

    String selectedCategory =
        index != null ? _expense[index].category : _categories.first;

    DateTime selectedDate =
        index != null ? _expense[index].date : DateTime.now();

    showModalBottomSheet(
        backgroundColor: Colors.blue.withOpacity(.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 45,
                    height: 5,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        label: Text("Title"),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: amountController,
                    decoration: InputDecoration(
                        label: Text("Amount"),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.black.withOpacity(.5),
                    value: selectedCategory,
                    items: _categories
                        .map((category) => DropdownMenuItem(
                            value: category, child: Text(category)))
                        .toList(),
                    onChanged: (value) {
                      selectedCategory = value!;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      label: Text("Category"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (titleController.text.isEmpty ||
                                double.tryParse(amountController.text) ==
                                    null) {
                              return;
                            }
                            if (index == null) {
                              _addExpense(
                                  titleController.text,
                                  double.parse(amountController.text),
                                  selectedDate,
                                  selectedCategory);

                              titleController.clear();
                              amountController.clear();
                            } else {
                              _updateExpense(
                                index,
                                titleController.text,
                                double.parse(amountController.text),
                                selectedDate,
                                selectedCategory,
                              );
                            }

                            Navigator.pop(context);
                          },
                          child: Text(index == null
                              ? "Add Expense"
                              : "Update Expanse"))),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          );
        });
  }

  void _showCredit(BuildContext context) {
    TextEditingController creditController = TextEditingController();

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.blue.withOpacity(.5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        isScrollControlled: true,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: creditController,
                  decoration: InputDecoration(
                      label: Text("Enter your credit amount"),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (double.tryParse(creditController.text) == null) {
                          return;
                        }
                        setState(() {
                          _credit = double.parse(creditController.text);
                        });
                        creditController.clear();
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.green)),
                      child: Text("Add Credit"),
                    )),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        });
  }
}
