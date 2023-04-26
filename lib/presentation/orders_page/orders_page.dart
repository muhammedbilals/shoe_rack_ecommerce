import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBarWidget(title: 'My Orders')),
        // body: TabBar(tabs: [
          
        //   Tab(height: 100, text: 'Active'),
        //   Tab(height: 100, text: 'Active'),
        //   Tab(height: 100, text: 'Active')
        // ]
        //  ),
      ),
    );
  }
}
