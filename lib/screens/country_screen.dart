// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, avoid_types_as_parameter_names, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:whatsapp/models/country_model.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key, required this.setCountryData});
  final Function setCountryData;

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  List<CountryModel> countries = [
    CountryModel(name: "India", code: "+91", flag: "🇮🇳"),
    CountryModel(name: "Pakistan", code: "+92", flag: "🇵🇰"),
    CountryModel(name: "United States", code: "+1", flag: "🇺🇸"),
    CountryModel(name: "South Africa", code: "+27", flag: "🇿🇦"),
    CountryModel(name: "Afghanistan", code: "+93", flag: "🇦🇫"),
    CountryModel(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
    CountryModel(name: "Italy", code: "+39", flag: "🇮🇹"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.teal,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Choose a Country',
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w200,
            fontSize: 18,
            wordSpacing: 1,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.teal,
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) => card(countries[index]),
      ),
    );
  }

  Widget card(CountryModel country) {
    return InkWell(
      onTap: () {
        widget.setCountryData(country);
      },
      child: Card(
        margin: EdgeInsets.all(0.15),
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            children: [
              Text((country.flag).toString()),
              SizedBox(width: 15),
              Text((country.name).toString()),
              Expanded(
                child: Container(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        (country.code).toString(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
