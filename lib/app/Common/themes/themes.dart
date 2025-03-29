import 'package:flutter/material.dart';

class ImageTheme extends ThemeExtension<ImageTheme> {
  final Color iconColor;
  final ColorFilter? imageFilter;

  ImageTheme({required this.iconColor, this.imageFilter});

  @override
  ThemeExtension<ImageTheme> copyWith({
    Color? iconColor,
    ColorFilter? imageFilter,
  }) {
    return ImageTheme(
      iconColor: iconColor ?? this.iconColor,
      imageFilter: imageFilter ?? this.imageFilter,
    );
  }

  @override
  ThemeExtension<ImageTheme> lerp(
    covariant ThemeExtension<ImageTheme>? other,
    double t,
  ) {
    if (other is! ImageTheme) return this;
    return ImageTheme(
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      imageFilter: t < 0.5 ? imageFilter : other.imageFilter,
    );
  }
}
