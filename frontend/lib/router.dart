// import 'package:frontend/screens/document_screen.dart';
// import 'package:frontend/screens/home_page.dart';
// import 'package:frontend/screens/login_screen.dart';
// import 'package:frontend/screens/singup_screen.dart';
// import 'package:frontend/widgets/loader.dart';
// import 'package:routemaster/routemaster.dart';
// import 'package:flutter/material.dart';
// import 'package:frontend/screens/profilepic_screen.dart';

// final loggedOutRoute = RouteMap(
//   routes: {
//     '/': (route) => const MaterialPage(
//       child: LoginScreen(),
//     ),
//     '/signup': (route) => const MaterialPage(
//       child: SignUpScreen(),
//     ),
//     '/profile': (route) => const MaterialPage(
//       child: ProfilePic(),
//     ),
//   },
// );

// final loggedInRoute = RouteMap(
//   routes: {
//     '/': (route) => const MaterialPage(child: HomePage()),
//     '/document/:id': (route) =>
//         MaterialPage(child: DocumentScreen(id: route.pathParameters['id']!)),
//   },
// );

// final loadingRoute = RouteMap(
//   routes: {'/': (route) => const MaterialPage(child: Loader())},
// );

//FOR TESTING ILL USE THIS
import 'package:frontend/screens/document_screen.dart';
import 'package:frontend/screens/home_page.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/singup_screen.dart';
import 'package:frontend/widgets/loader.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/profilepic_screen.dart';

final loggedOutRoute = RouteMap(
  routes: {
    '/': (route) => const MaterialPage(
      child: LoginScreen(),
    ),
    '/signup': (route) => const MaterialPage(
      child: SignUpScreen(),
    ),
    '/profile': (route) => const MaterialPage(
      child: ProfilePic(),
    ),
  },
);

final loggedInRoute = RouteMap(
  routes: {
    '/': (route) => const MaterialPage(child: HomePage()),
    '/document/:id': (route) =>
        MaterialPage(child: DocumentScreen(id: route.pathParameters['id']!)),
    '/profile': (route) => const MaterialPage(
      child: ProfilePic(),
    ),
  },
);

final loadingRoute = RouteMap(
  routes: {'/': (route) => const MaterialPage(child: Loader())},
);
