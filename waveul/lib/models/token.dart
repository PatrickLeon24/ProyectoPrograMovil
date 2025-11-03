class Token {
  final String waveul;
  final String files;

  Token({
    required this.waveul,
    required this.files,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      waveul: json['waveul'] as String,
      files: json['files'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'waveul': waveul,
      'files': files,
    };
  }

  @override
  String toString() {
    return 'Token{waveul: ${waveul.substring(0, 10)}..., files: ${files.substring(0, 10)}...}';
  }
}
