import 'package:flutter/material.dart';

import 'ui/home_application.dart';

void main() => runApp(
      MaterialApp(
        home: HomeApplication(),
        theme: ThemeData(
          primaryColor: Colors.white,
          hintColor: Colors.amber,
        ),
      ),
    );
