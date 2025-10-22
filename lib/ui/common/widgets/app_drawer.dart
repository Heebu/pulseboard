import 'package:flutter/material.dart';
import 'package:pulseboard/ui/views/chart_detail/chart_detail_view.dart';
import 'package:pulseboard/ui/views/dashboard/dashboard_view.dart';
import 'package:pulseboard/ui/views/journal/journal_view.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue.shade700),
            child: const Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Wellness Dashboard',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          _drawerItem(
            context,
            icon: Icons.dashboard_outlined,
            title: 'Dashboard',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardView(),));
              // navigationService.clearStackAndShow(Routes.dashboardView);
            },
          ),
          _drawerItem(
            context,
            icon: Icons.insights_outlined,
            title: 'Charts',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChartDetailView(chartType: 'Chart Type'),));
              // navigationService.navigateTo(Routes.chartDetailView);
            },
          ),
          _drawerItem(
            context,
            icon: Icons.book_outlined,
            title: 'Journal',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => JournalView(),));

              // navigationService.navigateTo(Routes.journalView);
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Logout', style: TextStyle(color: Colors.redAccent)),
            onTap: () {
              // You can later hook up logout logic here
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade800),
      title: Text(title, style: const TextStyle(fontSize: 15)),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
