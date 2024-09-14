class TokenConfig {
  const TokenConfig({
    required this.jwtSecret,
    required this.jwtAudience,
    required this.jwtIssuer,
  });

  final String jwtSecret;
  final String jwtAudience;
  final String jwtIssuer;
}
