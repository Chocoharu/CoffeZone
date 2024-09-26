import 'package:flutter/material.dart';

class Shop extends StatelessWidget{

  const Shop({super.key});

  @override
    Widget build(BuildContext context){
      return ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.white,
            child: const Center(child: Text('Entry A')),
          ),
          const SizedBox(width: 8),

          Container(
            height: 50,
            color: Colors.white,
            child: const Center(child: Text('Entry B')),
          ),
          const SizedBox(width: 8),

          Container(
            height: 50,
            color: Colors.white,
            child: const Center(child: Text('Entry C')),
          ),
      ],
    );
  }
}