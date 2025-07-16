abstract class ServicesEvent {}

class FetchServices extends ServicesEvent {
  final String carWashId;

  FetchServices(this.carWashId);
}