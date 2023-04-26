import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';
import 'package:shoe_rack_ecommerce/presentation/orders_page/widgets/cartdetailsActive.dart';
import 'package:shoe_rack_ecommerce/presentation/orders_page/widgets/cartdetailsCompleted.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(110),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {},
                      ),
                      const Spacer(),
                      const Center(
                        child: Text(
                          'Orders',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const TabBar(
                    indicatorColor: Colors.green,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(height: 40, text: 'Active'),
                      Tab(height: 40, text: 'Completed'),
                    ]),
              ],
            ),
          ),
          body: const TabBarView(
              // physics: NeverScrollableScrollPhysics(),
              physics: BouncingScrollPhysics(),
              children: [OrderDetailsActive(), OrderDetailsCompleted()]),
        ),
      ),
    );
  }
}