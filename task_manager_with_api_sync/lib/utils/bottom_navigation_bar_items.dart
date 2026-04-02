import 'package:flutter/material.dart';

const List<Map<String, Object>> bottomNavigationBarItems =
    <Map<String, Object>>[
      <String, Object>{
        'icon': Icon(Icons.home),
        'label': 'Home',
        'path': '/',
      },
      <String, Object>{
        'icon': Icon(Icons.person),
        'label': 'Profile',
        'path': '/profile',
      },
      <String, Object>{
        'icon': Icon(Icons.task),
        'label': 'Task',
        'path': '/task',
      },
    ];
