class RefreshTokenSendModelApi {
  final String refreshToken;

  RefreshTokenSendModelApi(this.refreshToken);

  Map<String, dynamic> toMap() {
    return {
      "refresh_token": refreshToken,
      "scope": "",
    };
  }
}
