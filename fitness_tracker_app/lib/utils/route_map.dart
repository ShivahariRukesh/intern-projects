import 'package:flutter/material.dart';

/// List of bottom navigation routes used throughout the app.
/// Each route contains:
/// - `name`: The display name of the screen.
/// - `route`: The route path used for navigation.
/// - `icon`: The icon shown in the `BottomNavigationBar`.
List<Map<String, Object>> routes = <Map<String, Object>>[
  <String, Object>{
    'name': 'Dashboard',
    'route': '/dashboard',
    'icon': const Icon(Icons.grid_view_rounded),
  },
  <String, Object>{
    'name': 'Log',
    'route': '/log',
    'icon': const Icon(Icons.add_box_outlined),
  },
  <String, Object>{
    'name': 'History',
    'route': '/history',
    'icon': const Icon(Icons.history),
  },
  <String, Object>{
    'name': 'Goal',
    'route': '/goal',
    'icon': const Icon(Icons.ballot),
  },
];
