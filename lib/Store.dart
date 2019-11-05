import 'package:flutter/material.dart';
import 'package:flutter_laceuphk/model/Product.dart';
import 'package:flutter_laceuphk/widgets/brandSelector.dart';
import 'package:flutter_laceuphk/widgets/productCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './profileClipper.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(40),
                  left: ScreenUtil().setWidth(40),
                  right: ScreenUtil().setWidth(40)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {},
                  ),
                  ClipOval(
                    clipper: ProfileClipper(),
                    child: Image.asset(
                      "lib/assets/images/portrait.png",
                      width: ScreenUtil().setWidth(160),
                      height: ScreenUtil().setHeight(160),
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(60),
                left: ScreenUtil().setWidth(70),
                bottom: ScreenUtil().setHeight(105),
              ),
              child: Text(
                "Explore",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            BrandSelector(
              brands: ["Nike", "Adidas", "Converse", "Vans"],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(50),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(1050),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: product.length,
                  itemBuilder: (context, index) {
                    Shoes shoes = product[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(30),
                      ),
                      child: ProductCard(shoes: shoes, cardNum: index),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
