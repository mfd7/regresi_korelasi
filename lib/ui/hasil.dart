import 'package:flutter/material.dart';
import 'home.dart';

class Hasil extends StatefulWidget {
  final String sigmaX;
  final String sigmaY;
  final String konstanta;
  final String koefisien;
  final String korelasi;
  final String skala;
  final String hubungan;
  final String determinasi;

  Hasil({Key key, this.sigmaX, this.sigmaY, this.konstanta, this.koefisien, this.korelasi, this.skala, this.hubungan, this.determinasi})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new HasilScreenState();
  }
}

class HasilScreenState extends State<Hasil> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: new Text('Hasil 152017116'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 5,
        children: [
          Center(
            child: Text('Total X ='),
          ),
          Center(
            child: Text('${widget.sigmaX}'),
          ),
          Center(
            child: Text('Total Y ='),
          ),
          Center(
            child: Text('${widget.sigmaY}'),
          ),
          Center(
            child: Text('Konstanta (a) ='),
          ),
          Center(
            child: Text('${widget.konstanta}'),
          ),
          Center(
            child: Text('Koefisien (b) ='),
          ),
          Center(
            child: Text('${widget.koefisien}'),
          ),
          Center(
            child: Text('Y ='),
          ),
          Center(
            child: Text('${widget.konstanta} + (${widget.koefisien}) X'),
          ),
          Center(
            child: Text('r ='),
          ),
          Center(
            child: Text('${widget.korelasi}'),
          ),
          Center(
            child: Text('Hubungan Korelasi ='),
          ),
          Center(
            child: Text('${widget.hubungan}'),
          ),
          Center(
            child: Text('Skala Korelasi ='),
          ),
          Center(
            child: Text('${widget.skala}'),
          ),
          Center(
            child: Text('Koefisien Determinasi ='),
          ),
          Center(
            child: Text('${widget.determinasi}%'),
          ),
        ],
      ),
    );
  }
}
