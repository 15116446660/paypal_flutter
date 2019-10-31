import 'package:flutter/material.dart';
import 'package:paypal/utils.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Successful payment"),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text("Peyment was Successful", style: TextStyle(color: Colors.green, fontSize: 19),),
          ),
          Center(
            child: RaisedButton(
              child: Text("Confirm the Order"),
              onPressed: (){
                captureOrder();
              },
            ),
          )
        ],
      ),
    );
  }
}