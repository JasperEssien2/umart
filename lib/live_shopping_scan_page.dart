import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';


class LiveShopping extends StatefulWidget {
  @override
  _LiveShoppingState createState() => new _LiveShoppingState();
}

class _LiveShoppingState extends State<LiveShopping> {

  String result = "No Items Added";


  void _openQrScan() async {

    try {
      String data = await BarcodeScanner.scan();
      setState(() {
        result = data;
      });
    }
    on PlatformException catch (ex) {
      if (ex == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Permission Denied";
        });
      } else {
        setState(() {
          result = "Unknow Error $ex";
        });
      }
    }on FormatException{

      setState(() {
        result = "Formart Eception";
      });
    }
    catch (ex){

      setState(() {
        result = "Unknow Error $ex";
      });

    }



  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(title: new Text("Scan Items To Cart"),),
      body: new Center(
        child: new Text(result),

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openQrScan,
        icon: new Icon(Icons.add_shopping_cart),
        label: new Text("Add to cart"),),


    );
  }
}
