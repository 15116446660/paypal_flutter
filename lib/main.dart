import 'package:flutter/material.dart';
import 'package:paypal/paypal.dart';
import 'package:paypal/success_screen.dart';
import 'package:uni_links/uni_links.dart';
import './utils.dart';
import 'package:flutter/services.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  Future<Null> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      String initialLink = await getInitialLink();
      
      if(initialLink == 'vpnsurf://my.app'){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SuccessScreen()));
      }
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

  @override
  void initState() {
    initUniLinks();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    void _payment() async {
      AuthModel authModel;
      OrderDetail orderDetail;

      authModel = await authWithPaypal();
      orderDetail = await makeOrder(authModel.access_token, "10.50");

      String approveLink =  orderDetail.links.where((Link link){
        return link.rel == 'approve';
      }).first.href;


     

      launchURL(approveLink);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Paypal peymnet"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Text(
            "Buy this Product",
            style: TextStyle(fontSize: 19, color: Colors.purple),
          )),
          Center(
              child: Text(
            "18.99\$",
            style: TextStyle(fontSize: 17, color: Colors.purple),
          )),
          Center(
            child: RaisedButton(
              onPressed: () {
                _payment();
              },
              child: Text("Pay with Paypal"),
            ),
          )
        ],
      ),
    );
  }
}
