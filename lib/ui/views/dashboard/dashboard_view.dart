import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../common/styles/colors.dart';
import '../../common/widgets/chart_card.dart';
import 'dashboard_viewmodel.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          drawer: const AppDrawer(),
          appBar: AppBar(
            title: const Text("Dashboard"),
            backgroundColor: AppColors.primary,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: model.refreshDashboard,
              ),
            ],
          ),
          body: model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
            onRefresh: () async => model.refreshDashboard(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Section
                  Text(
                    "Overview",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      DashboardTile(
                        icon: Icons.people,
                        title: "Users",
                        value: model.totalUsers.toString(),
                        color: AppColors.primary,
                      ),
                      DashboardTile(
                        icon: Icons.article,
                        title: "News Articles",
                        value: model.totalArticles.toString(),
                        color: AppColors.secondary,
                      ),
                      DashboardTile(
                        icon: Icons.comment,
                        title: "Comments",
                        value: model.totalComments.toString(),
                        color: Colors.teal,
                      ),
                      DashboardTile(
                        icon: Icons.analytics,
                        title: "Engagement",
                        value: "${model.engagementRate}%",
                        color: Colors.deepOrange,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Charts Section
                  Text(
                    "Analytics",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  ChartCard(
                    title: "User Growth",
                    data: model.userGrowthData,
                    labels: model.userGrowthLabels,
                    color: AppColors.primary,
                  ),
                  ChartCard(
                    title: "Article Engagement",
                    data: model.articleEngagementData,
                    labels: model.articleEngagementLabels,
                    color: AppColors.secondary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
