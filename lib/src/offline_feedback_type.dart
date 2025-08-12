/// Defines the type of feedback to show when a SmartButton is pressed while offline.
enum OfflineFeedbackType {
  /// Shows an adaptive alert dialog when offline.
  dialog,

  /// Shows a snackbar notification when offline.
  snackbar,

  /// Shows no visual feedback when offline.
  none,
}
