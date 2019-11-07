import 'package:flutter/material.dart';
import 'package:flutter_laceuphk/widgets/productCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 1125, height: 2436, allowFontScaling: true)
          ..init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
          child: new Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 25.0),
                  child:
                      Image.asset("lib/assets/images/logo.png", width: 62.0, height: 43.0),
                ),
              ),
              ProductCard(0xFFfaecfb, "lib/assets/images/shoes_01.png",
                  "Hybrid Rocket WNS", "\$999.00", "\$749"),
              SizedBox(
                height: 32.0,
              ),
              ProductCard(0xFFf8e1da, "lib/assets/images/shoes_02.png",
                  "Hybrid Runner ARS", "\$699", "\$599")
            ],
          ),
        ),
      ),
    );  
  }
}
