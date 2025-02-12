import 'package:flutter/material.dart';

class ButtonAdd extends StatelessWidget {
  final dynamic ammount;
  IconData ? icon;
  final VoidCallback onClick;

   ButtonAdd({super.key, required this.ammount, this.icon,required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        width: double.infinity,

        child: ElevatedButton.icon(
          onPressed: onClick,
          label: Text(" $ammount",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
          icon: Icon(icon?? null,color: Colors.white,),
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll( Colors.blue),

        ),
        ),


      ),
    );
  }
}
