import 'package:flutter/material.dart';

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {

  int _tipPercentage=0;
  double _tipAmount=0;
  int _personCounter=1;
  double _billAmount=0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

           body: Container(
             margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
             alignment: Alignment.center,
             color: Colors.white,
             child: ListView(
               scrollDirection: Axis.vertical,
               padding: EdgeInsets.all(20.5),
               children: <Widget>[
                      Container(
                        width: 150,
                          height: 150,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text('Amount per Person', style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('\$ ${calculateBillAmount(_billAmount, _tipAmount, _personCounter)}', style: TextStyle(
                                  color: Colors.blueAccent.shade700,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),

                            ],),
                        )
                      ),

                 Container(
                   margin: EdgeInsets.only(top: 20.0),
                   padding: EdgeInsets.all(20.0),



                   child: Column(
                     children: [

                       TextField( keyboardType: TextInputType.numberWithOptions(decimal: true),
                         style: TextStyle( color: Colors.blueAccent),
                         decoration: InputDecoration(
                           prefix: Text('Bill Amount '),
                           prefixIcon: Icon(Icons.attach_money_sharp),

                         ),
                         onChanged: (String value){
                         try{
                     _billAmount = double.parse(value);
    } catch(expection){
               _billAmount=0.0;
    }}
                       ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Split", style: TextStyle(
                        color: Colors.blue
                      ),),
                      Row(
                        children: [
                          InkWell( onTap:(){
                            setState(() {
                              if (_personCounter>1){
                                _personCounter--;
                              }
                            });},
                        child: Container(

                          width: 35.0,
                            height: 35.0,
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration( color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10.0)),
                          child: Center(child: Text("-", style: TextStyle(
                            fontSize: 30.0, color: Colors.black54,
                          ),)),

                        ),  ),

                          Text("$_personCounter", style: TextStyle( color: Colors.blueAccent, fontSize: 20.0),),



                          InkWell( onTap:(){
                            setState(() {

                                _personCounter++;


                            });},
                            child: Container(

                              width: 35.0,
                              height: 35.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration( color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Center(child: Text("+", style: TextStyle(
                                fontSize: 30.0, color: Colors.black54,
                              ),)),

                            ),  ),

                        ],
                      ),

                    ],
                  ),
                       Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,

                           children: [
                      Text("Tip", style: TextStyle( color: Colors.blueAccent, fontSize: 15.0),),
                          Text("\$ ${calculateTip(_billAmount, _tipPercentage)}", style: TextStyle( color: Colors.blueAccent, fontSize: 20.0,
                          ),
                          )
                       ]
                       ),

                       //SLIDER

                       Column(
                         children: [
                           Text("$_tipPercentage%", style: TextStyle( color: Colors.blueAccent, fontSize: 20.0, fontWeight: FontWeight.bold),
                                ),
                           Slider(
                             min: 0,
                               max: 100,
                               divisions: 20,
                               activeColor: Colors.blue,
                               inactiveColor: Colors.grey,
                               value: _tipPercentage.toDouble(), onChanged: (double value){

                             setState(() {
                               _tipPercentage= value.round();
                             });
                           })

                         ],
                       )







                     ],
                   ),

                  decoration: BoxDecoration(
                   color: Colors.transparent,
                    border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 2.0),

                    borderRadius: BorderRadius.circular(10.0),
                  )

                )

               ],


             ),
           ),

    );


  }

  //functions
calculateBillAmount( double billAmount, double tip, int person){

    double total= billAmount + tip;

    double perPerson= total/person;
    return perPerson.toStringAsFixed(2);
}

calculateTip( double billAmount, int tipPercent){
    double tip= (billAmount*_tipPercentage)/100;
    _tipAmount= tip;

    return tip;


}
}
