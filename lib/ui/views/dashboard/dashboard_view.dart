import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../common/styles/colors.dart';
import '../../common/widgets/app_drawer.dart';
import '../../common/widgets/chart_card.dart';
import '../../common/widgets/dashboard_tiles.dart';
import 'dashboard_viewmodel.dart';

class DashboardView extends StackedView<DashboardViewModel> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, DashboardViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: viewModel.isRefreshing
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
                : const Icon(Icons.refresh),
            onPressed: viewModel.isRefreshing ? null : viewModel.refreshDashboard,
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: viewModel.refreshDashboard,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 📊 Top Metric Tiles
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashboardTile(
                  title: "Users",
                  value: viewModel.totalUsers.toString(),
                  color: AppColors.primary,
                  onTap: () => viewModel.onTileTap("Users"),
                    icon: Icons.person
                ),
                DashboardTile(
                  title: "Articles",
                  value: viewModel.totalArticles.toString(),
                  color: AppColors.rhr,
                  onTap: () => viewModel.onTileTap("Articles"), icon: Icons.article,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashboardTile(
                  title: "Comments",
                  value: viewModel.totalComments.toString(),
                  color: AppColors.secondary,
                  onTap: () => viewModel.onTileTap("Comments"), icon: Icons.comment,
                ),
                DashboardTile(
                  title: "Engagement",
                  value: "${viewModel.engagementRate.toStringAsFixed(1)}%",
                  color: AppColors.success,
                  onTap: () => viewModel.onTileTap("Engagement"),
                    icon: Icons.add_reaction
                ),
              ],
            ),

            const SizedBox(height: 24),
            // 🧠 Charts Section
            ChartCard(
              title: "User Growth (Weekly)",
              data: viewModel.userGrowthData,
              labels: viewModel.userGrowthLabels.map((label) {
                // For mock data, convert text labels to fake date series
                final index = viewModel.userGrowthLabels.indexOf(label);
                return DateTime.now().subtract(Duration(days: (6 - index)));
              }).toList(),
              color: AppColors.primary,
            ),
            ChartCard(
              title: "Article Engagement (Monthly)",
              data: viewModel.articleEngagementData,
              labels: viewModel.articleEngagementLabels.map((label) {
                final index = viewModel.articleEngagementLabels.indexOf(label);
                return DateTime.now().subtract(Duration(days: (30 - index * 7)));
              }).toList(),
              color: AppColors.info,
            ),
          ],
        ),
      ),
    );
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) => DashboardViewModel();
}
