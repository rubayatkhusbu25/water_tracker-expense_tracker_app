# water_tracker_appp

= new learned topics

   1.   ElevatedButton.icon(
        onPressed: onClick,
        label: Text(" $ammount",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
        icon: Icon(icon?? null,color: Colors.white,),
        style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll( Colors.blue),
        ),),

    2.  double progress=(_inTake/_goal).clamp(0.0, 1.0);
        
        In Flutter (Dart), the clamp method is used to restrict a value within a given range. The syntax is:

            value.clamp(min, max),

        If value is less than min, it returns min.
        If value is greater than max, it returns max.
        Otherwise, it returns value itself.
