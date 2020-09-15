import 'dart:core';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Resource {
  String description; //location name for the UI
  String heading; // time in that location
  String picture; //url to an asset flag icon
  String url; //location url for PAI endpoint
  String datePosted; //true or false if daytime or not

  Resource(
      {this.description,
      this.heading,
      this.picture,
      this.url,
      this.datePosted});

  Future<void> getResource() async {
    Map<String, String> resources = {
      'description': 'some useful info',
      'heading': 'healtcare worker',
      'url': 'www.google.com',
      'picture': 'assets/jitenge.png',
      'datePosted': 'June 24th 2020'
    };
    print(resources);
  }
}
