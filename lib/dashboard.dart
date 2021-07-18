import 'package:flutter/material.dart';
import 'package:tugas10_vaksin_dan_pcr/datapcr.dart';
import 'package:tugas10_vaksin_dan_pcr/datavaksin.dart';
import 'package:tugas10_vaksin_dan_pcr/info.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InformatioOnly()));
              },
              child: Icon(Icons.info_outline),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(
            flex: 1,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DataVaksin()));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color(0xFFE2F0FA)),
                child: Column(
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    Image(
                      image: AssetImage("images/d1.png"),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                      "Data Vaksinasi",
                      style: TextStyle(fontSize: 24),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DataPCR()));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color(0xFFE2F0FA)),
                child: Column(
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    Image(
                      image: AssetImage("images/d2.png"),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                      "Data Layanan \nPCR",
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
