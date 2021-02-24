import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'hasil.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<Home> {
  String input = '0';
  List<TextEditingController> _controllers = new List();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: new Text('Regresi & Korelasi'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new TextField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Berapa banyak data yang akan diinputkan?'),
                onSubmitted: (String str) {
                  setState(() {
                    input = str;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 5,
                children: [Center(child: Text('X')), Center(child: Text('Y'))],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: int.parse(input) * 2,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    crossAxisCount: 2,
                    childAspectRatio: 4),
                itemBuilder: (context, index) {
                  _controllers.add(new TextEditingController());
                  return new TextField(
                    controller: _controllers[index],
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: RaisedButton(
          color: Colors.blueGrey[900],
          textColor: Colors.white,
          onPressed: () {
            double sigmaX = 0;
            double sigmaY = 0;
            double sigmaY2 = 0;
            double sigmaX2 = 0;
            double sigmaXY = 0;
            for (var i = 0; i < int.parse(input)*2; i++) {
              if (i % 2 == 0) {
                sigmaX = sigmaX + double.parse(_controllers[i].text);
                sigmaX2 = sigmaX2 + double.parse(_controllers[i].text) * double.parse(_controllers[i].text);
                sigmaXY = sigmaXY + double.parse(_controllers[i].text) * double.parse(_controllers[i+1].text);
              }else{
                sigmaY = sigmaY + double.parse(_controllers[i].text);
                sigmaY2 = sigmaY2 + double.parse(_controllers[i].text) * double.parse(_controllers[i].text);
              }
            }

            double konstantaPaket1 = 0;
            double konstantaPaket2 = 0;
            double konstantaPaket3 = 0;
            double konstantaPaket4 = 0;
            double koefisienPaket1 = 0;
            double koefisienPaket2 = 0;
            double koefisienPaket3 = 0;
            double koefisienPaket4 = 0;
            double korelasiPaket1 = 0;
            double korelasiPaket2 = 0;
            double korelasiPaket3 = 0;
            double korelasiPaket4 = 0;
            double korelasiPaket5 = 0;

            double konstantaAtas = 0;
            double konstantaBawah = 0;
            double koefisienAtas = 0;
            double koefisienBawah = 0;
            double korelasiAtas = 0;
            double korelasiBawah = 0;

            double konstanta = 0;
            double koefisen = 0;
            double korelasi = 0;
            double determinasi = 0;

            String skala = '';
            String hubungan = '';

            konstantaPaket1 = sigmaY * sigmaX2;
            konstantaPaket2 = sigmaX * sigmaXY;
            konstantaPaket3 = int.parse(input) * sigmaX2;
            konstantaPaket4 = sigmaX * sigmaX;

            koefisienPaket1 = int.parse(input) * sigmaXY;
            koefisienPaket2 = sigmaX * sigmaY;
            koefisienPaket3 = int.parse(input) * sigmaX;
            koefisienPaket4 = sigmaX * sigmaX;

            korelasiPaket1 = int.parse(input) * sigmaXY;
            korelasiPaket2 = sigmaX * sigmaY;
            korelasiPaket3 = int.parse(input) * sigmaX2 - (sigmaX * sigmaX);
            korelasiPaket4 = int.parse(input) * sigmaY2 - (sigmaY * sigmaY);
            korelasiPaket5 = korelasiPaket3 * korelasiPaket4;

            konstantaAtas = konstantaPaket1 - konstantaPaket2;
            konstantaBawah = konstantaPaket3 - konstantaPaket4;
            koefisienAtas = koefisienPaket1 - koefisienPaket2;
            koefisienBawah = koefisienPaket3 - koefisienPaket4;
            korelasiAtas = korelasiPaket1 - korelasiPaket2;
            korelasiBawah = sqrt(korelasiPaket5);

            konstanta = double.parse((konstantaAtas/konstantaBawah).toStringAsFixed(3));
            koefisen = double.parse((koefisienAtas/koefisienBawah).toStringAsFixed(3));
            korelasi = double.parse((korelasiAtas/korelasiBawah).toStringAsFixed(3));

            determinasi = korelasi * korelasi * 100;

            if(korelasi < 0){
              hubungan = 'Hubungan terbalik';
              korelasi = korelasi + korelasi*-2;
            }else{
              hubungan = 'Hubungan Linear';
            }

            if(korelasi >= 0 && korelasi < 0.2){
              skala = 'Sangat Lemah';
            }else if(korelasi >= 0.2 && korelasi < 0.4){
              skala = 'Lemah';
            }else if(korelasi >= 0.4 && korelasi < 0.6){
              skala = 'Sedang';
            }else if(korelasi >= 0.6 && korelasi < 0.8){
              skala = 'Kuat';
            }else if(korelasi >= 0.8 && korelasi <= 1){
              skala = "Sangat Kuat";
            }

            var route = new MaterialPageRoute(
              builder: (BuildContext context) => new Hasil(
                sigmaX: double.parse((sigmaX).toStringAsFixed(3)).toString(),
                sigmaY: double.parse((sigmaY).toStringAsFixed(3)).toString(),
                konstanta: konstanta.toString(),
                koefisien: koefisen.toString(),
                korelasi: korelasi.toString(),
                skala: skala,
                hubungan: hubungan,
                determinasi: determinasi.toString(),
              ),
            );
            Navigator.of(context).push(route);
          },
          child: Text('Next'),
        ));
  }
}
