import 'package:flutter/material.dart';

import 'modules/orders/presentation/screens/order_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Orders',
      home: OrderListScreen(),
    );
  }
}
