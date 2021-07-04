import 'package:flutter/material.dart';

class DeveloperInfoScreen extends StatelessWidget {
  static String developerInfoScreenRoute = '/dev';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Developer Image
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: Colors.cyan,
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/developer_pic.jpeg'),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            //Developer Name
            Text(
              'Karim E. Gaber',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(
              height: 10,
            ),

            contactInformation(
              mainColor: Colors.green,
              socialName: 'W',
              socialColor: Colors.greenAccent,
              infoColor: Colors.greenAccent,
              infoText: '+201030782412',
            ),

            SizedBox(
              height: 10,
            ),

            contactInformation(
              mainColor: Colors.blueAccent,
              socialName: 'F',
              socialColor: Colors.greenAccent,
              infoColor: Colors.blue,
              infoText: 'Karim E. Gaber',
            ),

            SizedBox(
              height: 50,
            ),

            Container(
              width: 270.0,
              height: 60,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Go back to app',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[100],
                      ),
                    ),
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.grey[100],
                      size: 25,
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget contactInformation({
  @required Color mainColor,
  @required String socialName,
  @required Color socialColor,
  @required Color infoColor,
  @required String infoText,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 70.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
          ),
        ),
        child: Center(
          child: Text(
            socialName,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: socialColor,
            ),
          ),
        ),
      ),
      Container(
        width: 200.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: infoColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
        child: Center(
          child: Text(
            infoText,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    ],
  );
}
