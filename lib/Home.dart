library example;
import 'dart:convert';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'EditPage.dart';

var t;
var vk;
var state;
var house;
var vtc;
var street;
var dist;
var country;
class vf extends StatefulWidget {
  late final String name;
  late final String state;
  late final String house;
  late final String vtc;
  late final String street;
  late final String dist;
  late final String country;


  vf(this.name,this.country,this.house,this.dist,this.state,this.street,this.vtc);
  @override
  _vfState createState() => _vfState();
}

class _vfState extends State<vf> {

  @override
  Widget build(context) {
    req(uid) async {
      print(uid);
      var uuid = Uuid();
      t=uuid.v4();
      var url = Uri.parse('https://stage1.uidai.gov.in/onlineekyc/getOtp');
      var data=json.encode({
        "uid": "${uid}",
        "txnId": "$t"
      });
      print(data);
      final response = await http.post(
        url,
        headers: { 'Content-Type': 'application/json'},
        body:data,
      );
      print(response.statusCode);
      print(response.body);
    }
    req1(otp1,uid1) async {
      print(otp1);

      /*var url = Uri.parse('https://stage1.uidai.gov.in/onlineekyc/getAuth');
      var data=json.encode({
        "uid": "${uid1}",
        "txnId": "$t",
        "otp": "${otp1}"
      });
      print(data);
      print(t);
      final response = await http.post(
        url,
        headers: {'Content-type':'application/json'},
        body:data,
      );
      print(response.statusCode);

      if(response.statusCode==200){*/
        print(otp1);
        var url1 = Uri.parse('https://stage1.uidai.gov.in/onlineekyc/getEkyc/');
        var data1=json.encode({
          "uid": "${uid1}",
          "txnId": "$t",
          "otp": "${otp1}"
        });
        print(data1);
        print(t);
        final response1 = await http.post(
          url1,
          headers: {'Content-type':'application/json'},
          body:data1,
        );
        print(response1.statusCode);
        var u=json.decode(response1.body);
        print(u);


        var storeXml = u['eKycString'];
        print(storeXml);
        var storeDocument = xml.parse(storeXml);
        print(storeDocument.findAllElements('Poa'));
        setState(() {
          vk=storeDocument.findAllElements('Poa').map((chekListElement) => chekListElement.getAttribute('lm'));
          state=storeDocument.findAllElements('Poa').map((chekListElement) => chekListElement.getAttribute('state'));
          house=storeDocument.findAllElements('Poa').map((chekListElement) => chekListElement.getAttribute('house'));vtc=storeDocument.findAllElements('Poa').map((chekListElement) => chekListElement.getAttribute('vtc'));
          vtc=storeDocument.findAllElements('Poa').map((chekListElement) => chekListElement.getAttribute('street'));
          dist=storeDocument.findAllElements('Poa').map((chekListElement) => chekListElement.getAttribute('dist'));
          country=storeDocument.findAllElements('Poa').map((chekListElement) => chekListElement.getAttribute('country'));
        });

     
        print(vk);


    }
    TextEditingController otp=TextEditingController();
    TextEditingController uid=TextEditingController();
    return WillPopScope(
      onWillPop: (){return Future(() => false);},
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Color(0xFF75B7E1),
          extendBody: true,
          body:

      Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.

        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:EdgeInsets.all(10),
              child:TextField(

                controller:uid ,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Aadhaar',
                ),



              ),),
              Padding(
                padding: const EdgeInsets.only(left:200),
                child: FlatButton(onPressed:(){ req(uid.text);}, child: Text('Generate otp'),),
              ),

        Padding(
          padding:EdgeInsets.all(10),
          child:TextField(
            controller:otp ,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
              labelText: 'Otp'
            ),),),

            FlatButton(child: Text('Request'),onPressed:(){ req1(otp.text,uid.text);Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => editpage(person:  vf(vk.toString(),state.toString(),house.toString(),vtc.toString(),street.toString(),dist.toString(),country.toString(),))),
              );}),

            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),

        ),
      ),
    );
  }
}
