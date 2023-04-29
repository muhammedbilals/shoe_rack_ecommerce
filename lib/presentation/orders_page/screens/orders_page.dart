import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';
import 'package:shoe_rack_ecommerce/presentation/orders_page/widgets/cartdetailsActive.dart';
import 'package:shoe_rack_ecommerce/presentation/orders_page/widgets/cartdetailsCompleted.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
                        icon: const Icon(
                          CustomIcon.lefticonfluttter,
                          size: 30,
                        ),
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
                      SizedBox(
                        width: size.width * 0.1,
                      )
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
                  ],
                ),
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
