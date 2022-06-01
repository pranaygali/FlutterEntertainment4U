import 'package:flutter/material.dart';

class contactus extends StatelessWidget {
  const contactus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact us'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Center(
        //padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Text(
              'For any kind of queries:',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 50,),
            Row(
              children: [
                Icon(Icons.mail),
                Text(
              ': nobodycares.never@gmail.com',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
              ],
            ),
            SizedBox(height: 50,),
            
            Row(
              children: [
                Icon(Icons.call),
                Text(
              ': +1 00000000000',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
