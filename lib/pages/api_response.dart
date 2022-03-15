class ApiResponse<T> {
  bool? ok;
  String? error;
  T? result;

  ApiResponse.ok(this.result) : ok = true;

  ApiResponse.error(this.error) : ok = false;
}
