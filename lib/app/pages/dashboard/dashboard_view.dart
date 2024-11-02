import 'package:flutter/material.dart';
import 'widget/dashboard_widget.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Astrologer Dashboard',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.amber,
      ),
      drawer: const Drawer(
          // Add Drawer contents here

          ),
      body: DashboardWidget(),
    );
  }
}
