abstract class ExportEvent {}

class ExportToPdfRequested extends ExportEvent {
  final DateTime? startDate;
  final DateTime? endDate;

  ExportToPdfRequested({this.startDate, this.endDate});
}
