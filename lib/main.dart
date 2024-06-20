import 'package:flutter/material.dart';
import 'package:myweb/pageFour.dart';
import 'package:myweb/pageOne.dart';
import 'package:myweb/pageThree.dart';
import 'package:myweb/pageTwo.dart';
import 'package:myweb/MetaProvider.dart'; 
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MetaProvider(),
      child: MaterialApp(
        title: 'Minhas Metas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vida Saudavel do Denis'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Vida Saudavel do Denis',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageOne()),
                );
              },
              child: Text('Saude Corporal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageTwo()),
                );
              },
              child: Text('Saude Financeira'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageThree()),
                );
              },
              child: Text('Estudos'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageFour()),
                );
              },
              child: Text('Metas'),
            ),
          ],
        ),
      ),
    );
  }
}
