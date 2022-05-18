import 'package:app/functions/fetchrates.dart';
import 'package:app/models/ratesmodel.dart';
import 'package:flutter/material.dart';
import 'package:app/components/AnyToAny.dart';
import 'package:flutter/rendering.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Initial Variables

  late Future<RatesModel> result;
  late Future<Map> allcurrencies;
  final formkey = GlobalKey<FormState>();

  //Getting RatesModel and All Currencies
  @override
  void initState() {
    super.initState();
    setState(() {
      result = fetchrates();
      allcurrencies = fetchcurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: Text('Currency convertor') , centerTitle: true,),

        //Future Builder for Getting Exchange Rates
        body: Container(
          height: h,
          width: w,
        padding: EdgeInsets.all(10),

          child: Container(
            height: 30,
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: FutureBuilder<RatesModel>(
                  future: result,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Container(
                      child: FutureBuilder<Map>(
                          future: allcurrencies,
                          builder: (context, currSnapshot) {
                            if (currSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return Currency(
                                  currencies: currSnapshot.data!,
                                  rates: snapshot.data!.rates,
                                );
                             
                          }),
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }
}