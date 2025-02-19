import 'package:flutter/material.dart';
import 'package:water_tracker_appp/widgets/button.dart';

class WaterTracker extends StatefulWidget {
  const WaterTracker({super.key});

  @override
  State<WaterTracker> createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker> {
  int _inTake = 0; // it is not final so its value is changeable
   final int _goal = 2000;  // final because in will not changed in future final fixed it
  List<int> history = [];  // list in and value is changeable


  // function 1: Add function

  void _addWater(int amount) {
    setState(() {
      if (_inTake < _goal) {
        _inTake = (_inTake + amount).clamp(0, _goal);  // condition==1  ; clamp range fixed kore ar besi ba kom hobena
        history.add(amount);   // condition==2 ;
      }
    });
  }

  // function 2: reset function

  void resetWater() {
    setState(() {
      _inTake = 0; // initial value
      history.clear();

    });
  }


  @override
  Widget build(BuildContext context) {
    double progress = (_inTake / _goal).clamp(0.0, 1.0);
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: Text(
          "Water Tracker",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 28),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: showWaterHistory,
            icon: Icon(Icons.history, color: Colors.white, size: 30),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.blue.withOpacity(.3), blurRadius: 10, spreadRadius: 2)
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "Today's Intake",
                    style: TextStyle(fontSize: 18, color: Colors.grey,fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '$_inTake ml',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey.shade400,
                    color: Colors.blueAccent,
                    strokeWidth: 10,
                  ),
                ),
                Text(
                  '${(progress * 100).toInt()} %',
                  style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 40),
            Wrap(
              spacing: 15,
              children: [
                ButtonAdd(ammount: "+200 ml", icon: Icons.local_cafe_outlined, onClick: () => _addWater(200)),
                ButtonAdd(ammount: "+500 ml", icon: Icons.water_drop, onClick: () => _addWater(500)),
                ButtonAdd(ammount: "+1000 ml", icon: Icons.local_drink_outlined, onClick: () => _addWater(1000)),
                SizedBox(height: 40),
                ButtonAdd(ammount: "Reset", onClick: resetWater),
              ],
            ),
          ],
        ),
      ),
    );
  }


  // function 3: history showing function

  Future<void> showWaterHistory() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue.shade100,
          title: Text("Water Intake History",style: TextStyle(color: Colors.black),),
          content: Container(
            width: double.maxFinite,
            child: history.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, color: Colors.black, size: 30),
                  SizedBox(height: 15),
                  Text("No history available."),
                ],
              ),
            )
                : ListView.builder(
                shrinkWrap: true, // show size according to the content
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      "${history[index]} ml",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                    leading: Text(
                      "${index + 1}",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                  );
                }),
          ),
          actions: [

            IconButton(onPressed: (){

              Navigator.pop(context);
            }, icon: Icon(Icons.clear,color: Colors.redAccent,)),
            IconButton(onPressed: (){
              setState(() {
                history.clear();
              });
              Navigator.pop(context);
            }, icon: Icon(Icons.delete_rounded,color: Colors.redAccent,)),

          ],
        

        );
      },
    );
  }
}
