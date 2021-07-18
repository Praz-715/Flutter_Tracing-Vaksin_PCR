// @dart=2.9
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

class DataVaksin extends StatefulWidget {
  @override
  _DataVaksinState createState() => _DataVaksinState();
}

class _DataVaksinState extends State<DataVaksin> {
  String dropdownValue = '';
  List<String> _tanggal;
  List datanya = null;
  int totalsasaran = 0;
  int doctorv1 = 0;
  int doctorv2 = 0;
  int publikv1 = 0;
  int publikv2 = 0;
  int lansia1 = 0;
  int lansia2 = 0;

  Future<void> getData(String tanggal) async {
    final response = await http
        .get("https://rizkiwebdr.000webhostapp.com/pm/vaksin?tanggal=$tanggal");
    final extractedData = json.decode(response.body);
    List loadVaksin = extractedData;
    setState(() {
      datanya = jsonDecode(extractedData[0]['isi']);
      totalsasaran = int.parse(datanya[0]['vaksin1']) +
          int.parse(datanya[0]['vaksin2']) +
          int.parse(datanya[1]['vaksin1']) +
          int.parse(datanya[1]['vaksin2']) +
          int.parse(datanya[2]['vaksin1']) +
          int.parse(datanya[2]['vaksin2']);
      doctorv1 = int.parse(datanya[0]['vaksin1']);
      doctorv2 = int.parse(datanya[0]['vaksin2']);
      publikv1 = int.parse(datanya[1]['vaksin1']);
      publikv2 = int.parse(datanya[1]['vaksin2']);
      lansia1 = int.parse(datanya[2]['vaksin1']);
      lansia2 = int.parse(datanya[2]['vaksin2']);
      print(datanya);
    });
    // print(jsonDecode(extractedData[0]['isi'])[0]['namasasaran']);
  }

  Future<List<String>> getTanggal() async {
    final response = await http
        .get("https://rizkiwebdr.000webhostapp.com/pm/vaksin?saja=true");

    final extractedData = json.decode(response.body);
    List<String> a = new List<String>.from(extractedData);
    setState(() {
      _tanggal = a;
      dropdownValue = a[0];
      getData(a[0]);
    });
  }

  void initState() {
    // postResult = LoginPage().;
    super.initState();
    getTanggal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Data Vaksinasi"),
        ),
        body: _tanggal == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.all(5),
                child: ListView(
                  children: [
                    Center(
                      child: Text("Update Vaksinasi COVID-19",
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: "Sansation",
                              fontWeight: FontWeight.bold)),
                    ),
                    Center(
                      child: Text("Di Indonesia",
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: "Sansation",
                              fontWeight: FontWeight.bold)),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red[200]),
                        margin: EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Center(
                            child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black45, fontSize: 20),
                          // underline: Container(
                          //   height: 2,
                          //   color: Colors.deepPurpleAccent,
                          // ),
                          onChanged: (String newValue) {
                            setState(() {
                              // int a = _tanggal.indexWhere(
                              //     (element) => element.tanggal == newValue);
                              dropdownValue = newValue;
                              getData(newValue);
                            });
                          },
                          items: _tanggal.map((tanggal) {
                            return DropdownMenuItem(
                              child: new Text(tanggal),
                              value: tanggal,
                            );
                          }).toList(),
                        )),
                      ),
                    ),
                    Center(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue[300]),
                          margin: EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height * 0.11,
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage("images/vaksin.png"),
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                color: Colors.white60,
                              ),
                              Container(
                                // color: Colors.red,
                                // height: MediaQuery.of(context).size.height * 0.6,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Text("Total Sasaran Vaksinasi",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontFamily: "Sansation",
                                        fontWeight: FontWeight.bold)),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Container(
                                // color: Colors.red,
                                // height: MediaQuery.of(context).size.height * 0.6,
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Text(
                                    new NumberFormat("#,###")
                                        .format(totalsasaran),
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: "Sansation",
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          )),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width * 0.50,
                              // color: Colors.red,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.lightGreen[300]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image(
                                    image: AssetImage("images/doctor.png"),
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    color: Colors.white60,
                                  ),
                                  Text("SDM Kesehatan",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18,
                                          fontFamily: "Sansation",
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      new NumberFormat("#,###")
                                          .format((doctorv1 + doctorv2)),
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 30,
                                          fontFamily: "Sansation",
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(1),
                                  height: MediaQuery.of(context).size.height *
                                      0.124,
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  // color: Colors.red,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.lightGreen[400]),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(),
                                      Text("Vaksinasi 1",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18,
                                            fontFamily: "Sansation",
                                          )),
                                      Text(
                                          new NumberFormat("#,###")
                                              .format(doctorv1),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 20,
                                              fontFamily: "Sansation",
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          "(" +
                                              (doctorv1 / totalsasaran * 100)
                                                  .toStringAsFixed(2) +
                                              "%)",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15,
                                            fontFamily: "Sansation",
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(1),

                                  height: MediaQuery.of(context).size.height *
                                      0.124,
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  // color: Colors.red,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.lightGreen[400]),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(),
                                      Text("Vaksinasi 2",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18,
                                            fontFamily: "Sansation",
                                          )),
                                      Text(
                                          new NumberFormat("#,###")
                                              .format(doctorv2),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 20,
                                              fontFamily: "Sansation",
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          "(" +
                                              (doctorv2 / totalsasaran * 100)
                                                  .toStringAsFixed(2) +
                                              "%)",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15,
                                            fontFamily: "Sansation",
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width * 0.50,
                              // color: Colors.red,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.deepPurple[200]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image(
                                    image: AssetImage("images/public.png"),
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    color: Colors.white60,
                                  ),
                                  Text("Petugas Publik",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18,
                                          fontFamily: "Sansation",
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      new NumberFormat("#,###")
                                          .format((publikv1 + publikv2)),
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 30,
                                          fontFamily: "Sansation",
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(1),
                                  height: MediaQuery.of(context).size.height *
                                      0.124,
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  // color: Colors.red,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.deepPurple[300]),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(),
                                      Text("Vaksinasi 1",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18,
                                            fontFamily: "Sansation",
                                          )),
                                      Text(
                                          new NumberFormat("#,###")
                                              .format(publikv1),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 20,
                                              fontFamily: "Sansation",
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          "(" +
                                              (publikv1 / totalsasaran * 100)
                                                  .toStringAsFixed(2) +
                                              "%)",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15,
                                            fontFamily: "Sansation",
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(1),

                                  height: MediaQuery.of(context).size.height *
                                      0.124,
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  // color: Colors.red,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.deepPurple[300]),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(),
                                      Text("Vaksinasi 2",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18,
                                            fontFamily: "Sansation",
                                          )),
                                      Text(
                                          new NumberFormat("#,###")
                                              .format(publikv2),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 20,
                                              fontFamily: "Sansation",
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          "(" +
                                              (publikv2 / totalsasaran * 100)
                                                  .toStringAsFixed(2) +
                                              "%)",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15,
                                            fontFamily: "Sansation",
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width * 0.50,
                              // color: Colors.red,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.indigo[300]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image(
                                    image: AssetImage("images/lansia.png"),
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    color: Colors.white60,
                                  ),
                                  Text("Lansia",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18,
                                          fontFamily: "Sansation",
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      new NumberFormat("#,###")
                                          .format((lansia1 + lansia2)),
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 30,
                                          fontFamily: "Sansation",
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(1),
                                  height: MediaQuery.of(context).size.height *
                                      0.124,
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  // color: Colors.red,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.indigo[400]),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(),
                                      Text("Vaksinasi 1",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 18,
                                              fontFamily: "Sansation",
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          new NumberFormat("#,###")
                                              .format(lansia1),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 20,
                                              fontFamily: "Sansation",
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          "(" +
                                              (lansia1 / totalsasaran * 100)
                                                  .toStringAsFixed(2) +
                                              "%)",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15,
                                              fontFamily: "Sansation",
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(1),

                                  height: MediaQuery.of(context).size.height *
                                      0.124,
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  // color: Colors.red,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.indigo[400]),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(),
                                      Text("Vaksinasi 2",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 18,
                                              fontFamily: "Sansation",
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          new NumberFormat("#,###")
                                              .format(lansia2),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 20,
                                              fontFamily: "Sansation",
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          "(" +
                                              (lansia2 / totalsasaran * 100)
                                                  .toStringAsFixed(2) +
                                              "%)",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15,
                                              fontFamily: "Sansation",
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black),
                        height: MediaQuery.of(context).size.height * 0.008,
                        width: MediaQuery.of(context).size.width * 0.95,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.18,
                              width: MediaQuery.of(context).size.width * 0.45,
                              // color: Colors.red,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(),
                                  Text("Vaksinasi 1",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 18,
                                          fontFamily: "Sansation",
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      new NumberFormat("#,###").format(
                                          doctorv1 + publikv1 + lansia1),
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 20,
                                          fontFamily: "Sansation",
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "(" +
                                          ((doctorv1 + publikv1 + lansia1) /
                                                  totalsasaran *
                                                  100)
                                              .toStringAsFixed(2) +
                                          "%)",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 15,
                                          fontFamily: "Sansation",
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.18,
                              width: MediaQuery.of(context).size.width * 0.45,
                              // color: Colors.red,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(),
                                  Text("Vaksinasi 2",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 18,
                                          fontFamily: "Sansation",
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      new NumberFormat("#,###").format(
                                          doctorv2 + publikv2 + lansia2),
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 20,
                                          fontFamily: "Sansation",
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "(" +
                                          ((doctorv2 + publikv2 + lansia2) /
                                                  totalsasaran *
                                                  100)
                                              .toStringAsFixed(2) +
                                          "%)",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 15,
                                          fontFamily: "Sansation",
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
