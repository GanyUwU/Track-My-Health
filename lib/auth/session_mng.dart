

class SessionController {
  static final SessionController _session = SessionController._internal();
  String? userId;
  String? name;
  factory SessionController(){
    return _session;
  }
  void clearUserId() {
    userId = null;
  }

  SessionController._internal();
}