import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_fcii/features/dashboard/controller/dashboard_controller.dart';
import 'package:project_fcii/features/dashboard/controller/dashboard_state.dart';
import 'package:project_fcii/features/dashboard/modules/view/page/product_page.dart';

class DashbordPage extends StatelessWidget {
  final List<String> titles = const ['Home', 'Users', 'Services'];

  const DashbordPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardController(),
      child: BlocBuilder<DashboardController, DashboardState>(
        builder: (context, state) {
          DashboardController controller = context.read<DashboardController>();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.yellow,
              title: Text(
                titles[controller.selectedTapIndex],
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'registration');
                    },
                    icon: const Icon(CupertinoIcons.add))
              ],
            ),
            body: PageView(
              controller: controller.pageController,
              onPageChanged: controller.onChangeTabIndex,
              children: const [
                ProductPage(),
                ProductPage(),
                Text('Favourites'),
                Text('Cart'),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.selectedTapIndex,
              onTap: controller.onChangeTabIndex,
              unselectedItemColor: Colors.black,
              showUnselectedLabels: true,
              unselectedLabelStyle:
                  const TextStyle(fontSize: 15, color: Colors.red),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.collections), label: 'Products'),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.heart), label: 'Favourits'),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.cart), label: 'Cart'),
              ],
            ),
          );
        },
      ),
    );
  }
}
