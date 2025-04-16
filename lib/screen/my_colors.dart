import 'package:flutter/material.dart';

@immutable
class MyColors extends ThemeExtension<MyColors> {
  final Color background;
  final Color text;
  final Color primary;
  final Color secondary;
  final Color divider;
  final Color card; // ✅ 추가된 필드

  const MyColors({
    required this.background,
    required this.text,
    required this.primary,
    required this.secondary,
    required this.divider,
    required this.card, // ✅ 생성자에 추가
  });

  @override
  MyColors copyWith({
    Color? background,
    Color? text,
    Color? primary,
    Color? secondary,
    Color? divider,
    Color? card, // ✅ copyWith에 추가
  }) {
    return MyColors(
      background: background ?? this.background,
      text: text ?? this.text,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      divider: divider ?? this.divider,
      card: card ?? this.card, // ✅
    );
  }

  @override
  MyColors lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) return this;
    return MyColors(
      background: Color.lerp(background, other.background, t)!,
      text: Color.lerp(text, other.text, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      card: Color.lerp(card, other.card, t)!, // ✅
    );
  }

  static const light = MyColors(
    background: Color(0xFFFFFFFF),
    text: Color(0xFF000000),
    primary: Color(0xFF547EE8),
    secondary: Color(0xFFF6F6F6),
    divider: Color(0xFFDADADA),
    card: Color(0xFFFDFDFD), // ✅ light mode 카드 색상
  );

  static const dark = MyColors(
    background: Color(0xFF121212),
    text: Color(0xFFFFFFFF),
    primary: Color(0xFF90CAF9),
    secondary: Color(0xFF1E1E1E),
    divider: Color(0xFF444444),
    card: Color(0xFF2C2C2E), // ✅ dark mode 카드 색상
  );
}
