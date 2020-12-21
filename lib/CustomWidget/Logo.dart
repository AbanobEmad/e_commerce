import 'package:flutter/material.dart';
class Logo extends StatelessWidget {
  const Logo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        height: MediaQuery.of(context).size.height * .2,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("images/icons/Buy1.png"),
            ),
            Positioned(
              bottom: 0,
              child: Text(
                "buy it",
                style: TextStyle(fontFamily: 'pacifico', fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}