// class jmlOnline {
//   final String status;
//   final String refresh_token;

//   jmlOnline({this.status, this.refresh_token});

//   factory jmlOnline.fromJson(Map<String, dynamic> json) {
//     return jmlOnline(
//         status: json['status'], refresh_token: json['refresh_token']);
//   }
// }

class OnlineUserStatus {
  final String status;

  OnlineUserStatus({this.status});

  factory OnlineUserStatus.fromJson(Map<String, dynamic> json) {
    return OnlineUserStatus(
      status: json['status'],
    );
  }
}
