import 'package:converso/converter/converter.dart';
import 'package:converso/request/response.dart';
import 'package:flutter/material.dart';

class HomeApplication extends StatefulWidget {
  @override
  _HomeApplicationState createState() => _HomeApplicationState();
}

class _HomeApplicationState extends State<HomeApplication> {
  final converter = MoedasConverter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _homeAppBar(),
      backgroundColor: Colors.black,
      body: _futureBuilder(),
    );
  }

  Widget _homeAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text("Conversor"),
      backgroundColor: Colors.amber,
    );
  }

  Widget _futureBuilder() {
    ResponseRequest request = ResponseRequest();

    return FutureBuilder<Map>(
      future: request.getMoedas(moedasUrlReques),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return _loading();
          default:
            if (snapshot.hasError) {
              return _snapshotService("Falha no carregamento");
            }
            converter.apply(snapshot.data);
            return _homeBody();
        }
      },
    );
  }

  Widget _loading() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            backgroundColor: Colors.deepOrangeAccent,
          ),
        ],
      );

  Widget _snapshotService(String message) => Center(
        child: Text(
          message,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.amber,
          ),
          textAlign: TextAlign.center,
        ),
      );

  Widget _homeBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _homeIcon(),
          Divider(),
          _textFormField(
              converter.realController, "Reais", "R\$ ", converter.realChanged),
          Divider(),
          _textFormField(converter.dollarController, "Dólares", "RS\$ ",
              converter.dollarChanged),
          Divider(),
          _textFormField(
              converter.euroController, "Euros", "€ ", converter.euroChanged),
          Divider(),
        ],
      ),
    );
  }

  Widget _textFormField(TextEditingController controller, String label,
      String prefixText, Function function) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        fillColor: Colors.amber,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        prefixText: prefixText,
      ),
      style: TextStyle(color: Colors.amber, fontSize: 16.0),
      onChanged: function,
    );
  }

  Widget _homeIcon() {
    return Icon(
      Icons.monetization_on,
      color: Colors.amber,
      size: 100,
    );
  }
}
