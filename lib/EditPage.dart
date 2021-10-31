
import 'package:barcode/Home.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'main.dart';



class editpage extends StatelessWidget {
  final vf person;
  Position? _currentPosition;
  _getCurrentLocation(code) async{
    print('io');
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
        .then((Position position) async {

      _currentPosition = position;
      print(_currentPosition);
      List placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      print(placemarks);
      Placemark place = placemarks[0];
      var Address = '${place.postalCode}';
      print(Address.runtimeType);
      if (Address=='$code'){
        AlertDialog();
      }

        print(Address);


    }).catchError((e) {
      print(e);
    });
  }




  // In the constructor, require a Person
  editpage({Key? key, required this.person}) : super(key: key);

  get shape => null;

  @override
  Widget build(BuildContext context) {

TextEditingController code=TextEditingController();

    print("klkl"+'${person.name}');
    return WillPopScope(
      onWillPop: (){return Future(() => false);},
      child: Scaffold(
        appBar: AppBar(title: Text('Change Address'),backgroundColor: Colors.purple,),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              

              Container(


                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40)
                  ),
                  color: Color.lerp(Colors.purpleAccent, Colors.purpleAccent, 7),
                ),


                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(

                    //Not clickable and not editable
                    //Clickable and not editable
                    cursorColor: Theme
                        .of(context)
                        .cursorColor,

                    decoration: InputDecoration(

                      labelText: 'Provide Uid',
                      labelStyle: TextStyle(
                        color: Color(0xFFFFFFFF),
                      ),
                      suffixIcon: Icon(
                        Icons.check_circle,
                        color: Color(0xFF57CE16),
                      ),


                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF6F4F8)),
                      ),
                    ),
                  ),

                ),
              ),


              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.60,
                child: SingleChildScrollView(


                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(

                          initialValue:  '${person.house}',
                          cursorColor: Theme
                              .of(context)
                              .cursorColor,

                          decoration: const InputDecoration(
                            icon: Icon(Icons.door_back_door_outlined),
                            labelText: 'Door Number / Flat Number',
                            labelStyle: TextStyle(
                              color: Color(0xFF6200EE),
                            ),


                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF6200EE)),
                            ),
                          ),
                        ),

                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(
                          readOnly: true,
                          initialValue:  '${person.dist.toString()}',
                          cursorColor: Theme
                              .of(context)
                              .cursorColor,

                          decoration: InputDecoration(
                            icon: Icon(Icons.place),
                            labelText: 'street',
                            labelStyle: TextStyle(
                              color: Color(0xFF6200EE),
                            ),


                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF6200EE)),
                            ),
                          ),
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(

                          readOnly: true,
                          initialValue:  '${person.name}',
                          cursorColor: Theme
                              .of(context)
                              .cursorColor,

                          decoration: InputDecoration(
                            icon: Icon(Icons.place),
                            labelText: 'post',
                            labelStyle: TextStyle(
                              color: Color(0xFF6200EE),
                            ),


                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF6200EE)),
                            ),
                          ),
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(
                          readOnly: true,
                          initialValue:  '${person.street}',
                          cursorColor: Theme
                              .of(context)
                              .cursorColor,

                          decoration: InputDecoration(
                            icon: Icon(Icons.location_city),
                            labelText: 'district',
                            labelStyle: TextStyle(
                              color: Color(0xFF6200EE),
                            ),


                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF6200EE)),
                            ),
                          ),
                        ),


                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(
                          readOnly: true,
                          initialValue:  '${person.country}',
                          cursorColor: Theme
                              .of(context)
                              .cursorColor,

                          decoration: InputDecoration(
                            icon: Icon(Icons.map),
                            labelText: 'state',
                            labelStyle: TextStyle(
                              color: Color(0xFF6200EE),
                            ),


                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF6200EE)),
                            ),
                          ),
                        ),


                      ),


                      Padding(padding: const EdgeInsets.only(left: 0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          color: Colors.purpleAccent,
                          onPressed: () =>
                          {
                            _getCurrentLocation(code.text),
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) => MyApp(),
                                transitionDuration: Duration.zero,
                              ),
                            ),


                            //do something
                          },
                          child: new Text('update', style: TextStyle(
                            color: Colors.white,
                          ),),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Note : Successful update will redirect to home',style: TextStyle(color: Colors.green),)
                    ],
                  ),
                ),

              ),
            ],

          ),
        ),

      ),
    );
  }
}
