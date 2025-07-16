abstract class DashboardEvent {}

class FetchUserLocation extends DashboardEvent {}
class ToggleMapExpansion extends DashboardEvent {}
class StartLocationListening extends DashboardEvent {}
class StopLocationListening extends DashboardEvent {}

class ChangeTab extends DashboardEvent {
  final int index;

  ChangeTab(this.index);
}