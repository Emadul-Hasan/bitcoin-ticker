import 'dart:convert';

import 'package:http/http.dart' as http;

const apikey = 'C4C2E6E9-D97C-40E0-8EB7-8702EE3C9B9D';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String baseUrl;
  CoinData({this.baseUrl});

  Future getCurrencyDatafromURl() async {
    try {
      http.Response response = await http
          .get('$baseUrl/BTC/USD?apikey=$apikey');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['rate'];
        return data;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
