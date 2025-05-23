import 'package:flutter/material.dart';
import 'quote.dart';

void main() {
  runApp(MaterialApp(home: Quotelist()));
}

class Quotelist extends StatefulWidget {
  const Quotelist({super.key});

  @override
  State<Quotelist> createState() => _QuotelistState();
}

class _QuotelistState extends State<Quotelist> {
  List<Quotes> quotes = [
    Quotes(
      author: 'Stevin',
      text: 'Be yourself, everyone else is already taken',
    ),
    Quotes(author: 'Mark', text: 'I have nothing to declare except my genius'),
    Quotes(author: 'Carl', text: 'The truth is rarely pure and never simple'),
  ];
  Widget quotetemplate( quote) {
    
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
       
        child: Column(
                              
          children: <Widget>[
            Text(quote.text, style: TextStyle(fontSize: 18)),
            Text(quote.author, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Quote list', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Column(
        
        children: quotes.map((quote) => quotetemplate(quote)).toList(),
      ),
    );
  }
}

/*
        quotes.map((quote){
         return Text('${quote.text}-${quote.author}')).toList();
         } */
