import 'package:flutter_exercise/bindings/data_bindings.dart';
import 'package:flutter_exercise/screens/home_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
static final routes = [
  GetPage(
    name: '/home',
    page: () => HomeScreen(),
    binding: DataBindings(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 200),
  ),
];
}