import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void pushReplacement(BuildContext context, String route, {Object? extra}) {
  context.pushReplacement(route, extra: extra);
}

Future<void> push(BuildContext context, String route, {Object? extra}) async {
  context.push(route, extra: extra);
}

void pushAndRemoveUntil(BuildContext context, String route, {Object? extra}) {
  context.go(route, extra: extra);
}

void pop(BuildContext context) {
  context.pop();
}
