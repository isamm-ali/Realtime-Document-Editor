import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import 'package:frontend/screens/document_screen.dart';
import 'package:frontend/screens/home_page.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/profilepic_screen.dart';
import 'package:frontend/screens/singup_screen.dart';
import 'package:frontend/widgets/loader.dart';

final loggedOutRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: LoginScreen()),
    '/signup': (_) => const MaterialPage(child: SignUpScreen()),
    '/profile': (_) => const MaterialPage(child: ProfilePic()),
  },
);

final loggedInRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: HomePage()),
    '/document/:id': (route) =>
        MaterialPage(child: DocumentScreen(id: route.pathParameters['id']!)),
  },
);

final loadingRoute = RouteMap(
  routes: {'/': (_) => const MaterialPage(child: Loader())},
);
