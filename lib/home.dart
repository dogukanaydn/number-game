import 'package:flutter/material.dart';
import 'widgets/table.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Schuttle Table'),
      ),
      body: Center(
        child: TablePart(),
      ),
    );
  }
}
