import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';


void main() async{

  testWidgets("lp", (WidgetTester widgetTester) async{
     widgetTester.pumpWidget(MaterialApp(home: Scaffold(
      body: ListView(
        children: [
          ...List.generate(10, (index) => ListTile(
            key: const Key("a"),
            title: Text("Item $index"),))
        ],
      ),
    ),));

    expect(find.text('Item 0'), findsOneWidget);
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
    expect(find.text('Item 3'), findsOneWidget);
    expect(find.text('Item 4'), findsOneWidget);

    // Verify that there are no other ListTiles present
    expect(find.byKey(Key('a')),
        findsNWidgets(5)); //
  });



}
