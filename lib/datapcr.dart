// @dart=2.9

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

class DataPCR extends StatefulWidget {
  @override
  _DataPCRState createState() => _DataPCRState();
}

class _DataPCRState extends State<DataPCR> {
  String dropdownValue = '';

  List<String> _tanggal;
  List datanya = null;
  int totalhariini = 0;
  int jumlahspesimen = 0;
  int jumlahseminggu = 0;
  double persentasesepekan = 0;
  int persejuta = 0;
  double persentasetotal = 0;

  Future<void> getData(String tanggal) async {
    final response = await http
        .get("https://rizkiwebdr.000webhostapp.com/pm/pcr?tanggal=$tanggal");
    final extractedData = json.decode(response.body);
    List loadVaksin = extractedData;
    setState(() {
      totalhariini = int.parse(extractedData[0]['totalhariini']);
      jumlahspesimen = int.parse(extractedData[0]['jumlahspesimen']);
      jumlahseminggu = int.parse(extractedData[0]['jumlahseminggu']);
      persentasesepekan = double.parse(extractedData[0]['persentasesepekan']);
      persejuta = int.parse(extractedData[0]['persejuta']);
      persentasetotal = double.parse(extractedData[0]['persentasetotal']);
    });
    // print(jsonDecode(extractedData[0]['isi'])[0]['namasasaran']);
  }

  Future<List<String>> getTanggal() async {
    final response =
        await http.get("https://rizkiwebdr.000webhostapp.com/pm/pcr?saja=true");

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
        title: Text("Data Layanan PCR"),
      ),
      body: _tanggal == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(5.0),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFE2F0FA)),
                          child: Column(
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              Text(
                                "Jumlah \nOrang Dites \nPCR Hari ini",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Text(
                                new NumberFormat("#,###").format(totalhariini),
                                style: TextStyle(
                                    fontSize: 22, fontFamily: "Sansation"),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFE2F0FA)),
                          child: Column(
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              Text(
                                "Jumlah \nSpesimen \nDites PCR\nHari ini",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Text(
                                new NumberFormat("#,###")
                                    .format(jumlahspesimen),
                                style: TextStyle(
                                    fontSize: 22, fontFamily: "Sansation"),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFE2F0FA)),
                          child: Column(
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              Text(
                                "Jumlah\nOrang Dites\nPCR Sepekan\nTerakhir",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Text(
                                new NumberFormat("#,###")
                                    .format(jumlahseminggu),
                                style: TextStyle(
                                    fontSize: 22, fontFamily: "Sansation"),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFE2F0FA)),
                          child: Column(
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              Text(
                                "Persentase \nKasus Positif\nSecara total",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Text(
                                persentasesepekan.toStringAsFixed(2) + "%",
                                style: TextStyle(
                                    fontSize: 22, fontFamily: "Sansation"),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFE2F0FA)),
                          child: Column(
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              Text(
                                "Tes PCR\nTotal per\nSejuta\nPenduduk",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Text(
                                new NumberFormat("#,###").format(persejuta),
                                style: TextStyle(
                                    fontSize: 22, fontFamily: "Sansation"),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFE2F0FA)),
                          child: Column(
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              Text(
                                "Persentase\nKasus positif\nsecara total",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Text(
                                persentasetotal.toStringAsFixed(2) + "%",
                                style: TextStyle(
                                    fontSize: 22, fontFamily: "Sansation"),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
