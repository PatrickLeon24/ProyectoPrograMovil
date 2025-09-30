import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff5c5c5c),
      surfaceTint: Color(0xff5e5e5e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff747474),
      onPrimaryContainer: Color(0xfffefcfc),
      secondary: Color(0xff222323),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff383838),
      onSecondaryContainer: Color(0xffa2a1a1),
      tertiary: Color(0xff5d5f5f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffffff),
      onTertiaryContainer: Color(0xff747676),
      error: Color(0xffb41c1b),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffd83831),
      onErrorContainer: Color(0xfffffbff),
      surface: Color(0xff41ae98),
      onSurface: Color(0xff171d1b),
      onSurfaceVariant: Color(0xff288CE9),
      outline: Color(0xff7e7576),
      outlineVariant: Color(0xffcfc4c5),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3230),
      inversePrimary: Color(0xffc7c6c6),
      primaryFixed: Color(0xffe3e2e2),
      onPrimaryFixed: Color(0xff1b1c1c),
      primaryFixedDim: Color(0xffc7c6c6),
      onPrimaryFixedVariant: Color(0xff464747),
      secondaryFixed: Color(0xffe4e2e1),
      onSecondaryFixed: Color(0xff1b1c1c),
      secondaryFixedDim: Color(0xffc8c6c6),
      onSecondaryFixedVariant: Color(0xff474747),
      tertiaryFixed: Color(0xffe2e2e2),
      onTertiaryFixed: Color(0xff1a1c1c),
      tertiaryFixedDim: Color(0xffc6c6c7),
      onTertiaryFixedVariant: Color(0xff454747),
      surfaceDim: Color(0xffd6dbd8),
      surfaceBright: Color(0xfff6faf7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f5f1),
      surfaceContainer: Color(0xffeaefec),
      surfaceContainerHigh: Color(0xffe4e9e6),
      surfaceContainerHighest: Color(0xffdfe4e0),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff353636),
      surfaceTint: Color(0xff5e5e5e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6d6d6d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff222323),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff383838),
      onSecondaryContainer: Color(0xffcbc9c8),
      tertiary: Color(0xff343637),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6c6d6d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcd302a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff6faf7),
      onSurface: Color(0xff0d1211),
      onSurfaceVariant: Color(0xff3b3436),
      outline: Color(0xff585152),
      outlineVariant: Color(0xff736b6c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3230),
      inversePrimary: Color(0xffc7c6c6),
      primaryFixed: Color(0xff6d6d6d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff545555),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6d6d6d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff555554),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6c6d6d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff535555),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc2c8c5),
      surfaceBright: Color(0xfff6faf7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f5f1),
      surfaceContainer: Color(0xffe4e9e6),
      surfaceContainerHigh: Color(0xffd9dedb),
      surfaceContainerHighest: Color(0xffced3d0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2b2c2c),
      surfaceTint: Color(0xff5e5e5e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff494949),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff222323),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff383838),
      onSecondaryContainer: Color(0xfffbf8f8),
      tertiary: Color(0xff2a2c2d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff48494a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000b),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff6faf7),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff312b2c),
      outlineVariant: Color(0xff4f4749),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3230),
      inversePrimary: Color(0xffc7c6c6),
      primaryFixed: Color(0xff494949),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff323333),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff494949),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff323333),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff48494a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff313333),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb5bab7),
      surfaceBright: Color(0xfff6faf7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffedf2ef),
      surfaceContainer: Color(0xffdfe4e0),
      surfaceContainerHigh: Color(0xffd0d6d2),
      surfaceContainerHighest: Color(0xffc2c8c5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc7c6c6),
      surfaceTint: Color(0xffc7c6c6),
      onPrimary: Color(0xff303031),
      primaryContainer: Color(0xff919090),
      onPrimaryContainer: Color(0xff0a0b0b),
      secondary: Color(0xffc8c6c6),
      onSecondary: Color(0xff303030),
      secondaryContainer: Color(0xff383838),
      onSecondaryContainer: Color(0xffa2a1a1),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff2f3131),
      tertiaryContainer: Color(0xffe2e2e2),
      onTertiaryContainer: Color(0xff636565),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff5c0004),
      surface: Color(0xff0f1413),
      onSurface: Color(0xffdfe4e0),
      onSurfaceVariant: Color(0xffcfc4c5),
      outline: Color(0xff988e90),
      outlineVariant: Color(0xff4c4546),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe4e0),
      inversePrimary: Color(0xff5e5e5e),
      primaryFixed: Color(0xffe3e2e2),
      onPrimaryFixed: Color(0xff1b1c1c),
      primaryFixedDim: Color(0xffc7c6c6),
      onPrimaryFixedVariant: Color(0xff464747),
      secondaryFixed: Color(0xffe4e2e1),
      onSecondaryFixed: Color(0xff1b1c1c),
      secondaryFixedDim: Color(0xffc8c6c6),
      onSecondaryFixedVariant: Color(0xff474747),
      tertiaryFixed: Color(0xffe2e2e2),
      onTertiaryFixed: Color(0xff1a1c1c),
      tertiaryFixedDim: Color(0xffc6c6c7),
      onTertiaryFixedVariant: Color(0xff454747),
      surfaceDim: Color(0xff0f1413),
      surfaceBright: Color(0xff353a38),
      surfaceContainerLowest: Color(0xff0a0f0e),
      surfaceContainerLow: Color(0xff171d1b),
      surfaceContainer: Color(0xff1b211f),
      surfaceContainerHigh: Color(0xff262b29),
      surfaceContainerHighest: Color(0xff303634),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffdddcdc),
      surfaceTint: Color(0xffc7c6c6),
      onPrimary: Color(0xff252626),
      primaryContainer: Color(0xff919090),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffdedcdb),
      onSecondary: Color(0xff252626),
      secondaryContainer: Color(0xff929090),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff2f3131),
      tertiaryContainer: Color(0xffe2e2e2),
      onTertiaryContainer: Color(0xff464849),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0f1413),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe5dadb),
      outline: Color(0xffbaafb1),
      outlineVariant: Color(0xff988e8f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe4e0),
      inversePrimary: Color(0xff474848),
      primaryFixed: Color(0xffe3e2e2),
      onPrimaryFixed: Color(0xff101111),
      primaryFixedDim: Color(0xffc7c6c6),
      onPrimaryFixedVariant: Color(0xff353636),
      secondaryFixed: Color(0xffe4e2e1),
      onSecondaryFixed: Color(0xff111111),
      secondaryFixedDim: Color(0xffc8c6c6),
      onSecondaryFixedVariant: Color(0xff363636),
      tertiaryFixed: Color(0xffe2e2e2),
      onTertiaryFixed: Color(0xff0f1112),
      tertiaryFixedDim: Color(0xffc6c6c7),
      onTertiaryFixedVariant: Color(0xff343637),
      surfaceDim: Color(0xff0f1413),
      surfaceBright: Color(0xff404644),
      surfaceContainerLowest: Color(0xff040807),
      surfaceContainerLow: Color(0xff191f1d),
      surfaceContainer: Color(0xff242927),
      surfaceContainerHigh: Color(0xff2e3432),
      surfaceContainerHighest: Color(0xff393f3d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff1f0ef),
      surfaceTint: Color(0xffc7c6c6),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffc3c2c2),
      onPrimaryContainer: Color(0xff0a0b0b),
      secondary: Color(0xfff2efef),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc4c2c2),
      onSecondaryContainer: Color(0xff0b0b0b),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffe2e2e2),
      onTertiaryContainer: Color(0xff282a2b),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea5),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0f1413),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff9edef),
      outlineVariant: Color(0xffcbc0c1),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe4e0),
      inversePrimary: Color(0xff474848),
      primaryFixed: Color(0xffe3e2e2),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffc7c6c6),
      onPrimaryFixedVariant: Color(0xff101111),
      secondaryFixed: Color(0xffe4e2e1),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc8c6c6),
      onSecondaryFixedVariant: Color(0xff111111),
      tertiaryFixed: Color(0xffe2e2e2),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc6c6c7),
      onTertiaryFixedVariant: Color(0xff0f1112),
      surfaceDim: Color(0xff0f1413),
      surfaceBright: Color(0xff4c514f),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1b211f),
      surfaceContainer: Color(0xff2c3230),
      surfaceContainerHigh: Color(0xff373d3b),
      surfaceContainerHighest: Color(0xff424846),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
  );

  /// Success
  static const success = ExtendedColor(
    seed: Color(0xff00c934),
    value: Color(0xff00c934),
    light: ColorFamily(
      color: Color(0xff006e18),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff00c934),
      onColorContainer: Color(0xff004d0e),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff006e18),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff00c934),
      onColorContainer: Color(0xff004d0e),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff006e18),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff00c934),
      onColorContainer: Color(0xff004d0e),
    ),
    dark: ColorFamily(
      color: Color(0xff3ee64e),
      onColor: Color(0xff003908),
      colorContainer: Color(0xff00c934),
      onColorContainer: Color(0xff004d0e),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff3ee64e),
      onColor: Color(0xff003908),
      colorContainer: Color(0xff00c934),
      onColorContainer: Color(0xff004d0e),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff3ee64e),
      onColor: Color(0xff003908),
      colorContainer: Color(0xff00c934),
      onColorContainer: Color(0xff004d0e),
    ),
  );

  /// Main Background
  static const mainBackground = ExtendedColor(
    seed: Color(0xfff2f2f2),
    value: Color(0xfff2f2f2),
    light: ColorFamily(
      color: Color(0xff5d5f5f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfff2f2f2),
      onColorContainer: Color(0xff6d6e6e),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff5d5f5f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfff2f2f2),
      onColorContainer: Color(0xff6d6e6e),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff5d5f5f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfff2f2f2),
      onColorContainer: Color(0xff6d6e6e),
    ),
    dark: ColorFamily(
      color: Color(0xffffffff),
      onColor: Color(0xff2f3131),
      colorContainer: Color(0xffe2e2e2),
      onColorContainer: Color(0xff636565),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffffff),
      onColor: Color(0xff2f3131),
      colorContainer: Color(0xffe2e2e2),
      onColorContainer: Color(0xff636565),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffffff),
      onColor: Color(0xff2f3131),
      colorContainer: Color(0xffe2e2e2),
      onColorContainer: Color(0xff636565),
    ),
  );

  /// Optional Gray
  static const optionalGray = ExtendedColor(
    seed: Color(0xffb4b4b4),
    value: Color(0xffb4b4b4),
    light: ColorFamily(
      color: Color(0xff5d5e5f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb4b4b4),
      onColorContainer: Color(0xff454646),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff5d5e5f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb4b4b4),
      onColorContainer: Color(0xff454646),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff5d5e5f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb4b4b4),
      onColorContainer: Color(0xff454646),
    ),
    dark: ColorFamily(
      color: Color(0xffd0cfcf),
      onColor: Color(0xff2f3131),
      colorContainer: Color(0xffb4b4b4),
      onColorContainer: Color(0xff454646),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffd0cfcf),
      onColor: Color(0xff2f3131),
      colorContainer: Color(0xffb4b4b4),
      onColorContainer: Color(0xff454646),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffd0cfcf),
      onColor: Color(0xff2f3131),
      colorContainer: Color(0xffb4b4b4),
      onColorContainer: Color(0xff454646),
    ),
  );

  List<ExtendedColor> get extendedColors => [
    success,
    mainBackground,
    optionalGray,
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
