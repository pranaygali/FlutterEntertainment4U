//This file deals with the screen that displays date and time to book the movie

import 'package:flutter/material.dart';
import 'package:flutterproject/seatbooking/seatlayout.dart';

class SelectSchedule extends StatefulWidget {
  const SelectSchedule({Key? key}) : super(key: key);

  @override
  State<SelectSchedule> createState() => _SelectScheduleState();
}

class _SelectScheduleState extends State<SelectSchedule> {
  late DateTime _dateTime;
  String time = DateTime.now().toString();
  int dating = 0; // used for the number of tickets counter
  int ticketPrice = 15;
  int totalTicketPrice = 0; // used to calculate the total tickets price
  int selectedDate = 0; // to navigate to the next page
  bool selectedSeats = false; // to navigate to the next page
  String note = "";
  int paymentTotal = 0;

  int sendMoney() {
    setState(() {
      paymentTotal = totalTicketPrice;
    });
    return paymentTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Select date and time'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              'Sai Ranga A/C DTS',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              'Rojuki 4 aatalu',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 80,
            ),
            MaterialButton(
              onPressed: () async {
                _dateTime = (await (showDatePicker(
                    context: context,
                    // User can only select the date for upto 7 days, as the schedule changes everyweek.
                    initialDate: DateTime.now().add(Duration(days: 0)),
                    firstDate: DateTime.now().add(Duration(days: 0)),
                    lastDate: DateTime.now().add(Duration(days: 7)))))!;
                setState(() {
                  //  final now = DateTime.now();

                  time = _dateTime.toString();
                  selectedDate = 1;
                });
              },
              child: Text(
                'Select a date',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              color: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              height: 60,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "${time}".split(' ')[0],
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 20,
                child: Divider(
                  height: 20,
                  color: Colors.red,
                ),
              ),
            ),
            Text(
              'Select number of Tickets',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 50,
              width: 150,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (dating != 0) {
                            dating -= 1;
                            totalTicketPrice = dating * ticketPrice;
                            selectedSeats = true;
                          }
                        });
                      },
                      icon: Icon(Icons.remove)),
                  Text(
                    '${dating}',
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (dating != 10) {
                            dating += 1;
                            totalTicketPrice = dating * ticketPrice;

                            selectedSeats = true;
                          }
                        });
                      },
                      icon: Icon(Icons.add)),
                ],
              ),
            ),
            Text(
              'Total Ticket Price: ${totalTicketPrice} CAD',
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 20,
                child: Divider(
                  height: 20,
                  color: Colors.red,
                ),
              ),
            ),
            Text(
              'Select show timings',
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    if (selectedSeats == true &&
                        selectedDate == 1 &&
                        totalTicketPrice != 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SeatLayout()),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('SORRY'),
                            ),
                          ],
                          title: Text('WARNING'),
                          contentPadding: EdgeInsets.all(20),
                          content:
                              Text('PLEASE SELECT DATE AND NUMBER OF SEATS'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    '06:00 PM',
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (selectedSeats == true &&
                        selectedDate == 1 &&
                        totalTicketPrice != 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SeatLayout()),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('SORRY'),
                            ),
                          ],
                          title: Text('WARNING'),
                          contentPadding: EdgeInsets.all(20),
                          content:
                              Text('PLEASE SELECT DATE AND NUMBER OF SEATS'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    '07:00 PM',
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (selectedSeats == true &&
                        selectedDate == 1 &&
                        totalTicketPrice != 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SeatLayout()),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('SORRY'),
                            ),
                          ],
                          title: Text('WARNING'),
                          contentPadding: EdgeInsets.all(20),
                          content:
                              Text('PLEASE SELECT DATE AND NUMBER OF SEATS'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    '08:00 PM',
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (selectedSeats == true &&
                        selectedDate == 1 &&
                        totalTicketPrice != 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SeatLayout()),
                      );
                    } else {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('SORRY'),
                              ),
                            ],
                            title: Text('WARNING'),
                            contentPadding: EdgeInsets.all(20),
                            content:
                                Text('PLEASE SELECT DATE AND NUMBER OF SEATS'),
                          ),
                        );
                      });
                    }
                  },
                  child: Text(
                    '09:00 PM',
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              note,
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
