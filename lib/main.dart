import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Intereset Calculator',
      home: SimpleInterestCalculator(),
      theme: ThemeData(fontFamily: 'Roboto')));
}

class SimpleInterestCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SimpleInterestCalculatorState();
  }
}

class SimpleInterestCalculatorState extends State<SimpleInterestCalculator> {
  var formKey = GlobalKey<FormState>();

  List<String> currencies = ['Rupees', 'Dollar', 'Pound'];
  String selectedCurrency;
  String displayResults = "";

  TextEditingController principleController = new TextEditingController();
  TextEditingController rateController = new TextEditingController();
  TextEditingController termController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCurrency = currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Interest Calculator'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                ImageLogo(),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: principleController,
                    validator: (String value) {
                      if (value.isEmpty) return 'Please enter principle amount';
                    },
                    decoration: InputDecoration(
                        labelText: 'Principle',
                        hintText: 'Enter principle',
                        contentPadding: EdgeInsets.all(15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: rateController,
                    validator: (String value) {
                      if (value.isEmpty) return 'Please enter rate of interest';
                    },
                    decoration: InputDecoration(
                        labelText: 'Rate of Interest',
                        hintText: 'Enter rate of interest',
                        contentPadding: EdgeInsets.all(15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: termController,
                          validator: (String value) {
                            if (value.isEmpty) return 'Please enter term';
                          },
                          decoration: InputDecoration(
                              labelText: 'Term',
                              hintText: 'Enter term',
                              contentPadding: EdgeInsets.all(15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                        Container(width: 10.0),
                        Expanded(
                            child: DropdownButton<String>(
                          items: currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: selectedCurrency,
                          onChanged: (String newString) {
                            setState(() {
                              selectedCurrency = newString;
                            });
                          },
                        ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                                color: Colors.blueAccent,
                                child: Text(
                                  'CALCULATE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontFamily: 'Roboto'),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (formKey.currentState.validate()) {
                                      displayResults = _caclulate();
                                    }
                                  });
                                })),
                        Container(width: 10.0),
                        Expanded(
                            child: RaisedButton(
                                color: Colors.deepOrange,
                                child: Text(
                                  'RESET',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontFamily: 'Roboto'),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _ResetFunction();
                                  });
                                }))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(displayResults))
              ],
            )),
      ),
    );
  }

  String _caclulate() {
    double principle = double.parse(principleController.text);
    double interest = double.parse(rateController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principle + (principle * interest * term) / 100;

    return 'After $term years, your investment will be  $totalAmountPayable [amount in $selectedCurrency]';
  }

  void _ResetFunction() {
    principleController.clear();
    rateController.clear();
    termController.clear();

    displayResults = '';

    selectedCurrency = currencies[0];
  }
}

class ImageLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/bank.png');

    Image image = Image(
      image: assetImage,
      width: 200.0,
      height: 200,
    );

    return Container(
      alignment: Alignment.center,
      child: image,
    );
  }
}
