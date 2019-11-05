import 'package:flutter/material.dart';

class Shoes{
  final String name;
  final List<Color> colors;
  final imageURL;
  final price;

  Shoes(this.name, this.colors, this.imageURL, this.price){

  } 
}

Shoes s1 = new Shoes("Air Jordon 1", [Colors.white, Colors.red], "lib/assets/images/Air_Jordan_1_x_Off_White_Chicago_1024x1024.png", 499);
Shoes s2 = new Shoes("React Flyknit", [Colors.white, Colors.cyan], "", 599);
Shoes s3 = new Shoes("Nike Joyride", [Colors.cyan, Colors.purple], "", 199);

List<Shoes> product = [s1, s2, s3];