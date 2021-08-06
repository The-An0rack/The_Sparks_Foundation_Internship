import 'package:flutter/material.dart';

import './alluserdetails.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: LogoImage(),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AllUsers()));
              },
              child: Text(
                "All Customer Database",
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Add New Transaction"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetImage pizzaAsset = AssetImage('img/logo0.jpg');
    Image image = Image(image: pizzaAsset, width: 400, height: 400);

    return Container(
      child: image,
    );
  }
}
