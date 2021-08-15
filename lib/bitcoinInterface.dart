import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class BitocinInterface extends StatefulWidget {
  @override
  _BitocinInterfaceState createState() => _BitocinInterfaceState();
}

class _BitocinInterfaceState extends State<BitocinInterface> {
  String _preco = '0';
  String _venda = '0';

  void _recuperarPreco() async {
    String url = 'https://blockchain.info/pt/ticker';
    http.Response response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);

    setState(() {
      _preco = retorno['BRL']['buy'].toString();
      _venda = retorno['BRL']['sell'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/bitcoin.png'),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'Compra R\$: ' + _preco,
                  style: TextStyle(fontSize: 35),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'Venda R\$: ' + _venda,
                  style: TextStyle(fontSize: 35),
                ),
              ),
              RaisedButton(
                onPressed: _recuperarPreco,
                child: Text(
                  'Atualizar',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                color: Colors.orange,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
