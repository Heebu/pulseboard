import 'dart:async';
import 'package:stacked/stacked.dart';

import '../../../app/setup.dart';

class DashboardViewModel extends BaseViewModel {

  // Dashboard metrics
  int totalUsers = 0;
  int totalArticles = 0;
  int totalComments = 0;
  double engagementRate = 0;

  List<double> userGrowthData = [];
  List<double> articleEngagementData = [];
  List<String> userGrowthLabels = [];
  List<String> articleEngagementLabels = [];

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  Timer? _timer;

  DashboardViewModel() {
    _initData();
    _simulateLiveData();
  }

  void _initData() {
    totalUsers = 1200;
    totalArticles = 340;
    totalComments = 980;
    engagementRate = 74.5;

    userGrowthData = [120, 150, 180, 200, 230, 250, 300];
    articleEngagementData = [60, 90, 120, 150, 180, 200, 210];
    userGrowthLabels = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    articleEngagementLabels = ["Week 1", "Week 2", "Week 3", "Week 4"];
  }

  void _simulateLiveData() {
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      totalUsers += 5;
      totalArticles += 2;
      totalComments += 8;
      engagementRate = (engagementRate + 0.2) % 100;
      rebuildUi();
    });
  }

  Future<void> refreshDashboard() async {
    _isRefreshing = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    totalUsers += 10;
    totalArticles += 3;
    totalComments += 5;
    engagementRate += 1.5;

    _isRefreshing = false;
    rebuildUi();
  }

  void onTileTap(String title) {
    switch (title) {
      case 'Users':
        print("Navigating to Users screen...");
        break;
      case 'Articles':
        print("Navigating to Articles screen...");
        break;
      case 'Comments':
        print("Navigating to Comments screen...");
        break;
      default:
        print("Tapped on $title tile.");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
