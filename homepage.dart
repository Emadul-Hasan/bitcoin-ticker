import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coindata.dart';
import 'dart:io' show Platform;

class BitcoinConverter extends StatefulWidget {
  @override
  _BitcoinConverterState createState() => _BitcoinConverterState();
}

String rate;
var data;

class _BitcoinConverterState extends State<BitcoinConverter> {
  String currencySelector = 'USD';

  DropdownButton getAndroidmenu() {
    List<DropdownMenuItem<String>> dropdownMenulist = [];
    for (String currency in currenciesList) {
      var newitem = DropdownMenuItem(
        child: Text('$currency'),
        value: currency,
      );
      dropdownMenulist.add(newitem);
    }
    return DropdownButton<String>(
      dropdownColor: Colors.lightBlueAccent,
      style: TextStyle(color: Colors.white, fontSize: 18.0),
      value: currencySelector,
      items: dropdownMenulist,
      onChanged: (value) {
        setState(() {
          currencySelector = value;
        });
      },
    );
  }

  CupertinoPicker getiOspicker() {
    List<Text> currencyList = [];

    for (String currency in currenciesList) {
      var item = Text('$currency');
      currencyList.add(item);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (indexnumber) {
        print(indexnumber);
      },
      children: currencyList,
    );
  }

  String baseUrl = 'https://rest.coinapi.io/v1/exchangerate';

  void getCurrencyData() async {
    CoinData coinData = CoinData(baseUrl: baseUrl);
    data = await coinData.getCurrencyDatafromURl();
    setState(() {
      rate = data.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrencyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text('Bitcoin Converter'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Card(
              margin: EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
              color: Colors.lightBlueAccent,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 bitcoin =  $rate usd',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              height: 150.0,
              color: Colors.lightBlueAccent,
              child: Platform.isIOS ? getiOspicker() : getAndroidmenu(),
            )
          ],
        ));
  }
}
