enum Status { success, failed, loading }

class ApiResponse {
  dynamic _responseBody;
  String? _errorMessage;
  String? _successMessage;
  Status? _status;

  dynamic get body => _responseBody;
  set setBody(dynamic body) => _responseBody = body;

  String? get error => _errorMessage;
  set setError(String? error) => _errorMessage = error;

  String? get successMsg => _successMessage;
  set setSuccessMsg(String? msg) => _successMessage = msg;

  Status? get status => _status;
  set setStatus(Status? status) => _status = status;
}
