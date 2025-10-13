import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasError => _error != null;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  @protected
  Future<void> runWithErrorHandling(Future<void> Function() action) async {
    try {
      setLoading(true);
      setError(null);
      await action();
    } catch (e) {
      setError(e.toString());
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  @mustCallSuper
  void dispose() {
    super.dispose();
  }
}
