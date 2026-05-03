abstract class ExportState {}

class ExportInitial extends ExportState {}
class ExportLoading extends ExportState {}
class ExportSuccess extends ExportState {
  final String filePath; // Сақталған файлдың жолы
  ExportSuccess(this.filePath);
}
class ExportError extends ExportState {
  final String message;
  ExportError(this.message);
}