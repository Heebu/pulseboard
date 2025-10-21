import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../common/widgets/chart_card.dart';
import '../../common/widgets/empty_view.dart';
import '../../common/widgets/error_view.dart';
import '../../common/widgets/loading_view.dart';
import 'dashboard_viewmodel.dart';


class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: const Text('Biometrics Dashboard'),
            centerTitle: true,
          ),
          body: SafeArea(
            child: _buildBody(viewModel),
          ),
        );
      },
    );
  }

  Widget _buildBody(DashboardViewModel vm) {
    switch (vm.state) {
      case DataState.loading:
        return const LoadingSkeleton();
      case DataState.error:
        return ErrorView(onRetry: vm.retry);
      case DataState.empty:
        return const EmptyView();
      case DataState.success:
        return _buildDashboard(vm);
    }
  }

  Widget _buildDashboard(DashboardViewModel vm) {
    return Column(
      children: [
        const SizedBox(height: 12),
        _buildRangeSelector(vm),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              ChartCard(
                title: 'HRV (Heart Rate Variability)',
                color: Colors.blueAccent,
                data: vm.biometrics.map((e) => e.hrv ?? 0).toList(),
                labels: vm.biometrics.map((e) => e.date).toList(),
              ),
              ChartCard(
                title: 'RHR (Resting Heart Rate)',
                color: Colors.redAccent,
                data: vm.biometrics.map((e) => (e.rhr ?? 0).toDouble()).toList(),
                labels: vm.biometrics.map((e) => e.date).toList(),
              ),
              ChartCard(
                title: 'Steps Count',
                color: Colors.greenAccent,
                data: vm.biometrics.map((e) => (e.steps ?? 0).toDouble()).toList(),
                labels: vm.biometrics.map((e) => e.date).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRangeSelector(DashboardViewModel vm) {
    final ranges = ['7d', '30d', '90d'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: ranges.map((r) {
          final selected = vm.selectedRange == r;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ChoiceChip(
              label: Text(r),
              selected: selected,
              onSelected: (_) => vm.changeRange(r),
            ),
          );
        }).toList(),
      ),
    );
  }
}
