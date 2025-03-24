import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Quotelist(),));
}

class Quotelist extends StatefulWidget {
  const Quotelist({super.key});

  @override
  State<Quotelist> createState() => _QuotelistState();
}

class _QuotelistState extends State<Quotelist> {
  List<String> quotes = [
    'Be yourself; everyone else is already taken',
    'I have nothing to declare except my genius',
    'The truth is rarely pure and never simple'

  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Quote list',style:TextStyle(color: Colors.white) ,),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Column(
        children: quotes.map((quote)=> Text(quote)).toList(),



      ),

    );
  }
}
