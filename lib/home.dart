import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double weight = 0;
  int tola = 0;
  int ana = 0;
  int laal = 0;
  int year = NepaliDateTime.now().year;
  int month = NepaliDateTime.now().month;
  int day = NepaliDateTime.now().day;

  double principle = 0;
  int days = 0;
  int amount = 0;

  calculateWeight() {
    double temp;
    temp = weight / 11.664;
    tola = temp.truncate();
    temp = ((temp - tola) * 11.664) / 0.72875;
    ana = temp.truncate();
    temp = ((temp - ana) * 0.72875) / 0.1166;
    laal = temp.truncate();
  }

  calculatediff() {
    var today = DateTime.utc(
        NepaliDateTime.now().year,
        month == 2
            ? NepaliDateTime.now().month + 1
            : NepaliDateTime.now().month,
        NepaliDateTime.now().day);
    setState(() {
      month = month == 2 ? month + 1 : month;
    });
    var temp = DateTime.utc(year, month, day);
    days = today.difference(temp).inDays;
    int tempdays = days;
    if (tempdays <= 365) {
      amount = (principle +
              ((principle * (principle <= 10000 ? 0.02 : 0.0175) / 30)) *
                  tempdays)
          .truncate();
    } else {
      double tempPrinciple = principle;
      tempPrinciple = (tempPrinciple +
          ((tempPrinciple * (tempPrinciple < 10000 ? 0.02 : 0.0175) / 30)) *
              365);
      tempdays = tempdays - 365;
      amount = (tempPrinciple +
              ((tempPrinciple * (tempPrinciple < 10000 ? 0.02 : 0.0175) / 30)) *
                  tempdays)
          .truncate();
    }
    setState(() {});
  }

  DateTime today = NepaliDateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(8),
                child: Column(children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      setState(() {
                        weight = double.parse(val);
                      });
                      calculateWeight();
                    },
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 12),
                  Text(
                    tola.toString() +
                        " Tola " +
                        " " +
                        ana.toString() +
                        " Ana " +
                        " " +
                        laal.toString() +
                        " Laal",
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(
                      "Rs " + ((weight / 11.664) * 60000).truncate().toString(),
                      style: TextStyle(fontSize: 22))
                ]),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                child: Column(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 100,
                            height: 40,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                setState(() {
                                  day = int.parse(val);
                                });
                                calculatediff();
                              },
                              decoration: InputDecoration(
                                  labelText: "Day",
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 40,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                setState(() {
                                  month = int.parse(val);
                                });
                                calculatediff();
                              },
                              decoration: InputDecoration(
                                  labelText: "Month",
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 40,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                setState(() {
                                  year = int.parse(val);
                                });
                                calculatediff();
                              },
                              decoration: InputDecoration(
                                  labelText: "Year",
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(days.toString() + " Days",
                      style: TextStyle(fontSize: 22)),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: 200,
                    height: 40,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        setState(() {
                          principle = double.parse(val);
                        });
                        calculatediff();
                      },
                      decoration: InputDecoration(
                          labelText: "Principle", border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 64,
                  ),
                  Text(
                    "Rs " + amount.toString(),
                    style: TextStyle(fontSize: 64),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
