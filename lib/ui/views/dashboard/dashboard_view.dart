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
        title: const Text("Biometrics Dashboard"),
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
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: viewModel.refreshDashboard,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 🔹 Summary Grid Section
              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 50,
                childAspectRatio: 3,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  DashboardTile(
                    title: "Users",
                    value: viewModel.totalUsers.toString(),
                    color: AppColors.primary,
                    icon: Icons.person_outline,
                    onTap: () => viewModel.onTileTap("Users", context),
                  ),
                  DashboardTile(
                    title: "Articles",
                    value: viewModel.totalArticles.toString(),
                    color: AppColors.rhr,
                    icon: Icons.article_outlined,
                    onTap: () => viewModel.onTileTap("Articles", context),
                  ),
                  DashboardTile(
                    title: "Comments",
                    value: viewModel.totalComments.toString(),
                    color: AppColors.secondary,
                    icon: Icons.comment_outlined,
                    onTap: () => viewModel.onTileTap("Comments", context),
                  ),
                  DashboardTile(
                    title: "Engagement",
                    value: "${viewModel.engagementRate.toStringAsFixed(1)}%",
                    color: AppColors.success,
                    icon: Icons.trending_up,
                    onTap: () => viewModel.onTileTap("Engagement", context),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Divider(),

              // 🔹 Charts Section
              const SizedBox(height: 24),
              Text(
                "Performance Charts",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              ChartCard(
                title: "User Growth (Weekly)",
                data: viewModel.userGrowthData,
                labels: viewModel.userGrowthLabels.map((label) {
                  final index = viewModel.userGrowthLabels.indexOf(label);
                  return DateTime.now().subtract(Duration(days: (6 - index)));
                }).toList(),
                color: AppColors.primary,
              ),

              const SizedBox(height: 20),

              ChartCard(
                title: "Article Engagement (Monthly)",
                data: viewModel.articleEngagementData,
                labels: viewModel.articleEngagementLabels.map((label) {
                  final index = viewModel.articleEngagementLabels.indexOf(label);
                  return DateTime.now().subtract(Duration(days: (30 - index * 7)));
                }).toList(),
                color: AppColors.info,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) => DashboardViewModel();
}
