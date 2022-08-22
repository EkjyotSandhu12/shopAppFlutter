import 'dart:math';

import 'package:flutter/material.dart';

class RandomData {

  static var adjective = [
    "Excited",
    "Anxious",
    "Overweight",
    "Demonic",
    "Jumpy",
    "Misunderstood",
    "Squashed",
    "Gargantuan",
    "Broad",
    "Crooked",
    "Curved",
    "Deep",
    "Even",
    "Excited",
    "Anxious",
    "Overweight",
    "Demonic",
    "Jumpy",
    "Misunderstood",
    "Squashed",
    "Gargantuan",
    "Broad",
    "Crooked",
    "Curved",
    "Deep",
    "Even",
    "Flat",
    "Hilly",
    "Jagged",
    "Round",
    "Shallow",
    "Square",
    "Steep",
    "Straight",
    "Thick",
    "Thin",
    "Cooing",
    "Deafening",
    "Faint",
    "Harsh",
    "High-pitched",
    "Hissing",
    "Hushed",
    "Husky",
    "Loud",
    "Melodic",
    "Mute",
    "Noisy",
    "Purring",
    "Quiet",
    "Raspy",
    "Screeching",
    "Shrill",
    "Silent",
    "Soft",
    "Squeaky",
    "Squealing",
    "Thundering",
    "Voiceless",
    "Whispering"
  ];

  static var object = [
    "Taco",
    "Operating System",
    "Sphere",
    "Water melon",
    "Cheese burger",
    "Apple Pie",
    "Spider",
    "Dragon",
    "Remote Control",
    "Soda",
    "Barbie Doll",
    "Watch",
    "Purple Pen",
    "Dollar Bill",
    "Stuffed Animal",
    "Hair Clip",
    "Sunglasses",
    "T-shirt",
    "Purse",
    "Towel",
    "Hat",
    "Camera",
    "Hand Sanitizer Bottle",
    "Photo",
    "Dog Bone",
    "Hair Brush",
    "Birthday Card"
  ];

  static String randomTitle(){
    return adjective[Random().nextInt(adjective.length)] + " " + object[Random().nextInt(object.length)];
  }

  static String randomUrl(){
    return "https://picsum.photos/id/${Random().nextInt(100)}/200/300.jpg";
  }

}