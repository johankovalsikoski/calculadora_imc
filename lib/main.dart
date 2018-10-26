import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = "Informe seus dados !";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados !";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 17.0) {
        _infoText = "Muito abaixo do peso: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 17.0 && imc < 18.49) {
        _infoText = "Abaixo do peso: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 18.49 && imc < 24.99) {
        _infoText = "Peso normal: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 24.99 && imc < 29.99) {
        _infoText = "Acima do peso: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 29.99 && imc < 34.99) {
        _infoText = "Obesidade I: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 34.99 && imc < 39.99) {
        _infoText = "Obesidade II: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 39.99) {
        _infoText = "Obesidade III: ${imc.toStringAsPrecision(4)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: <Widget>[

          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Icon(Icons.person_outline, size: 120.0, color: Colors.purple),

            TextFormField(keyboardType: TextInputType.number,
              controller: weightController,
              textAlign: TextAlign.center,
              validator: (value){
                if(value.isEmpty){
                  return "Insira seu peso";
                }

                if(value.length < 2 || value.length > 3){
                  return "Preencha seu peso corretamente";
                }
              },
              style: TextStyle(color: Colors.purple, fontSize: 18.0),
              decoration: InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(color: Colors.purple)),
            ),

            TextFormField(keyboardType: TextInputType.number,
              controller: heightController,
              textAlign: TextAlign.center,
              validator: (value){
                if(value.isEmpty){
                  return "Insira sua altura";
                }

                if(value.length < 2 && value.length > 3) {
                  return "Preencha sua altura corretamente";
                }
              },
              style: TextStyle(color: Colors.purple, fontSize: 18.0),
              decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.purple)),
            ),

            Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Container(
                  height: 40.0,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text("Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 18.0)),
                    color: Colors.purple,
                  )
              ),
            ),

            Text(_infoText, textAlign: TextAlign.center, style: TextStyle(color: Colors.purple, fontSize: 22.0))

          ],
        ),
        )
      )

    );
  }
}

