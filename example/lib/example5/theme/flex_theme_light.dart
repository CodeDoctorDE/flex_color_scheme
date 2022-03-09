import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../../shared/const/app_color.dart';
import '../../shared/const/app_data.dart';
import '../../shared/controllers/theme_controller.dart';

/// This function calls [flexColorSchemeLight] and uses
/// [FlexColorScheme.toTheme] to return the [ThemeData] object represented by
/// the returned [FlexColorScheme] setup.
///
/// We do it this way and not directly, or by setting it all up with the
/// convenience extension helper [FlexThemeData.light], because when we create
/// a standard Flutter SDK theme with [ThemeData.from] a [ColorScheme] factory,
/// we will use the same [flexColorSchemeLight] light function to return
/// the [ColorScheme] it represents with its [FlexColorScheme.toScheme] method.
///
/// The [ThemeData.from] a [ColorScheme] will be used to demonstrate difference
/// using the exact same [ColorScheme], but using just default [ThemeData] with
/// no [FlexColorScheme] theming applied.
///
ThemeData flexThemeLight(ThemeController controller) =>
    flexColorSchemeLight(controller).toTheme;

/// Create the FlexColorScheme object represented by our current
/// [ThemeController] configuration.
///
/// This setup may seem complex, but all the controller does is represent
/// configuration values selected in the UI that are input to a large number
/// of properties in [FlexColorScheme], so we can dynamically produce the
/// configured theme.
///
/// Normally you would probably only have a few properties offered as possible
/// features the user can change. Since this is a feature demo of almost
/// everything [FlexColorScheme] it is a bit wild.
FlexColorScheme flexColorSchemeLight(ThemeController controller) {
  // Using a built-in scheme or one of the custom colors in the demo?
  final bool useBuiltIn = controller.schemeIndex > 2 &&
      controller.schemeIndex < AppColor.schemesCustom.length - 1;
  // Get the enum index of scheme
  final int flexScheme = controller.schemeIndex - 3;

  return FlexColorScheme.light(
    // Use controller to get current scheme colors, use custom "colors"
    // property only if we use an index where we have custom colors in use.
    colors: !useBuiltIn ? AppColor.scheme(controller).light : null,
    // Otherwise use built-in scheme based property. We could
    // use only the colors property, but then we do no see the
    // correct keyColor behavior in dark mode, with built-in.
    // Also a good test of that factory works as designed.
    // The source code gen also uses this logic.
    scheme: useBuiltIn ? FlexScheme.values[flexScheme] : null,
    // Used number of colors from the selected input FlexColorScheme based theme
    usedColors: controller.usedColors,
    // Use controller to select surface mode
    surfaceMode: controller.surfaceMode,
    // Integer used to control the level of primary color
    // surface blends applied to surfaces and backgrounds.
    blendLevel: controller.blendLevel,
    // Enum used to select what AppBar style we use.
    appBarStyle: controller.lightAppBarStyle,
    // Set background opacity on app bar.
    appBarOpacity: controller.appBarOpacity,
    // Used to control if we use one or two toned status bar.
    transparentStatusBar: controller.transparentStatusBar,
    // Used to modify the themed AppBar elevation.
    appBarElevation: controller.appBarElevation,
    // Enum used to select what TabBar style we use.
    tabBarStyle: controller.tabBarStyle,
    // Keep scaffold plain white in all blend modes.
    lightIsWhite: controller.lightIsWhite,
    // Swap primary and secondary colors.
    swapColors: controller.swapLightColors,
    // If true, tooltip theme background will be light in light
    // theme, and dark in dark themes. The Flutter and Material
    // default and standard is the other way, tooltip background
    // color is inverted compared to app background.
    // Set to true, to mimic e.g. the look of Windows desktop
    // tooltips. You could tie this to the active platform and
    // have different style of tooltips on different platforms.
    tooltipsMatchBackground: controller.tooltipsMatchBackground,
    //
    // Opt in/out of using opinionated sub-themes.
    useSubThemes: controller.useSubThemes,
    // Options used to modify the sub-themes, there are more
    // properties than this, but here we use:
    subThemesData: FlexSubThemesData(
      // Want color themed disable hover, focus, highlight and
      // splash colors? Then keep this one on.
      interactionEffects: controller.interactionEffects,
      // Blend level for on colors for on colors, primary
      // secondary and tertiary and their containers.
      blendOnLevel: controller.blendOnLevel,
      // Use blend level values also with main on colors, not
      // only with container and on surfaces.
      blendOnColors: controller.blendLightOnColors,
      // By default sub themes mode also opts in on using colored text for
      // the themed text. If you plan to put text on surfaces that are not
      // primary color tinted or primary colored, then you may need to
      // turn this off, or make custom text themes for those surfaces.
      // Material3 has containers with matching colors too, they work great
      // for contrast colored text, do use them too.
      blendTextTheme: controller.blendLightTextTheme,
      // Opt in/out of the Material 3 style matched TextTheme geometry, or
      // Typography, as it is called in Flutter SDK. The M3 Typography is not
      // yet natively available in Flutter SDK 2.10.3 or earlier, this offers it
      // as a way to use it already now.
      useTextTheme: controller.useTextTheme,
      // Value to adjust themed border radius on widgets with
      // an adjustable corner rounding, this one is very handy.
      // If null, it defaults to Material3 (You) design
      // guide values, when available: https://m3.material.io/
      // If you give it value, "all" Flutter built-in widgets
      // supporting border radius will use the give radius.
      defaultRadius:
          controller.useDefaultRadius ? null : controller.cornerRadius,
      // SchemeColor based ColorScheme color used on buttons & toggles.
      textButtonSchemeColor: controller.textButtonSchemeColor,
      elevatedButtonSchemeColor: controller.elevatedButtonSchemeColor,
      outlinedButtonSchemeColor: controller.outlinedButtonSchemeColor,
      materialButtonSchemeColor: controller.materialButtonSchemeColor,
      toggleButtonsSchemeColor: controller.toggleButtonsSchemeColor,
      switchSchemeColor: controller.switchSchemeColor,
      checkboxSchemeColor: controller.checkboxSchemeColor,
      radioSchemeColor: controller.radioSchemeColor,
      // Style of unselected switch/checkbox/radio.
      unselectedToggleIsColored: controller.unselectedIsColored,
      //
      // Base ColorScheme used by TextField InputDecorator.
      inputDecoratorSchemeColor: controller.inputDecoratorSchemeColor,
      // Text input field uses a themed fill color.
      inputDecoratorIsFilled: controller.inputDecoratorIsFilled,
      // Do you like underline or outline border type?
      // (Might add some new styles in a future update)
      inputDecoratorBorderType: controller.inputDecoratorBorderType,
      // Only want a border when the text input has focus
      // or error, then set this to false. By default it always
      // has a border of selected style, but thinner.
      inputDecoratorUnfocusedHasBorder:
          controller.inputDecoratorUnfocusedHasBorder,
      // Set to false to keep using M2 style FAB and ignore
      // M3 type default and global radius on the FAB, it thus
      // remains circular or stadium shaped in extended mode.
      fabUseShape: controller.fabUseShape,
      fabSchemeColor: controller.fabSchemeColor,
      chipSchemeColor: controller.chipSchemeColor,
      // Set some opacity on popup menu, just to show a setting not available
      // via ThemeController in the demo.
      popupMenuOpacity: 0.96,
      // ColorScheme used on various widgets.
      dialogBackgroundSchemeColor: controller.dialogBackgroundSchemeColor,
      appBarBackgroundSchemeColor: controller.appBarBackgroundSchemeColor,
      tabBarItemSchemeColor: controller.tabBarItemSchemeColor,
      tabBarIndicatorSchemeColor: controller.tabBarIndicator,
      //
      // BottomNavigationBar settings
      // Shares input with BottomNavigationBar.
      bottomNavigationBarSelectedLabelSchemeColor:
          controller.navBarSelectedSchemeColor,
      bottomNavigationBarUnselectedLabelSchemeColor:
          controller.navUnselectedSchemeColor,
      bottomNavigationBarMutedUnselectedLabel: controller.navBarMuteUnselected,
      bottomNavigationBarSelectedIconSchemeColor:
          controller.navBarSelectedSchemeColor,
      bottomNavigationBarUnselectedIconSchemeColor:
          controller.navUnselectedSchemeColor,
      bottomNavigationBarMutedUnselectedIcon: controller.navBarMuteUnselected,
      bottomNavigationBarBackgroundSchemeColor:
          controller.navBarBackgroundSchemeColor,
      bottomNavigationBarOpacity: controller.bottomNavigationBarOpacity,
      bottomNavigationBarElevation: controller.bottomNavigationBarElevation,
      // TODO(rydmike): Remove these dev phase testing commented inputs
      // bottomNavigationBarSelectedIconSize: 24,
      // bottomNavigationBarUnselectedIconSize: 24,
      // bottomNavigationBarUnselectedLabelSize: null,
      // bottomNavigationBarSelectedLabelSize: 20,
      //
      // NavigationBar settings
      // Shares input with BottomNavigationBar and Rail.
      navigationBarSelectedLabelSchemeColor:
          controller.navBarSelectedSchemeColor,
      navigationBarUnselectedLabelSchemeColor:
          controller.navUnselectedSchemeColor,
      navigationBarMutedUnselectedLabel: controller.navBarMuteUnselected,
      navigationBarSelectedIconSchemeColor:
          controller.navBarSelectedSchemeColor,
      navigationBarUnselectedIconSchemeColor:
          controller.navUnselectedSchemeColor,
      navigationBarMutedUnselectedIcon: controller.navBarMuteUnselected,
      navigationBarHighlightSchemeColor: controller.navBarHighlight,
      navigationBarBackgroundSchemeColor:
          controller.navBarBackgroundSchemeColor,
      navigationBarOpacity: controller.bottomNavigationBarOpacity,
      //
      // NavigationRail settings
      // Shares controller values with nav bars in this demo.
      navigationRailSelectedLabelSchemeColor:
          controller.navBarSelectedSchemeColor,
      navigationRailUnselectedLabelSchemeColor:
          controller.navUnselectedSchemeColor,
      navigationRailMutedUnselectedLabel: controller.navBarMuteUnselected,
      navigationRailSelectedIconSchemeColor:
          controller.navBarSelectedSchemeColor,
      navigationRailUnselectedIconSchemeColor:
          controller.navUnselectedSchemeColor,
      navigationRailMutedUnselectedIcon: controller.navBarMuteUnselected,
      navigationRailUseIndicator: controller.useIndicator,
      navigationRailIndicatorSchemeColor: controller.navBarHighlight,
      navigationRailBackgroundSchemeColor:
          controller.navBarBackgroundSchemeColor,
      navigationRailOpacity: controller.bottomNavigationBarOpacity,
      navigationRailElevation: controller.bottomNavigationBarElevation,
      // TODO(rydmike): Remove these dev phase testing commented inputs
      // navigationRailSelectedIconSize: 24,
      // navigationRailUnselectedIconSize: 20,
      // navigationRailUnselectedLabelSize: 12,
      // navigationRailSelectedLabelSize: 16,
    ),
    //
    // Advanced color properties for seed generated ColorScheme's
    //
    // Use key color based M3 ColorScheme.
    keyColors: FlexKeyColors(
      useKeyColors: controller.useKeyColors,
      useSecondary: controller.useSecondary,
      useTertiary: controller.useTertiary,
      keepPrimary: controller.keepPrimary,
      keepSecondary: controller.keepSecondary,
      keepTertiary: controller.keepTertiary,
      keepPrimaryContainer: controller.keepPrimaryContainer,
      keepSecondaryContainer: controller.keepSecondaryContainer,
      keepTertiaryContainer: controller.keepTertiaryContainer,
    ),
    // Use Material3 error colors with Material2 themes.
    useMaterial3ErrorColors: controller.useM3ErrorColors,
    // Use predefined [FlexTones] setups for the generated
    // [TonalPalette] and it's usage in [ColorScheme] config.
    // You can make your custom [FlexTones] object right here
    // and apps it it, this just uses an int value to select
    // between a few preconfigured ones.
    tones: AppColor.flexTonesConfig(
        Brightness.light, controller.usedFlexToneSetup),
    //
    // ThemeData properties passed along directly to ThemeData.
    //
    // Modify the value in the AppData class to change it.
    visualDensity: AppData.visualDensity,
    // Custom font, modify in AppData class to change it.
    fontFamily: AppData.font,
    // The platform can be toggled in the app, but not saved.
    platform: controller.platform,
    // Opt-in/out of using Flutter SDK Material3 based theming
    // features. In Flutter SDK 2.10.3 and earlier it has almost no
    // effect, but it will later and then we can use this toggle
    // with FlexColorScheme too, and in this demo we can see its
    // impact easily.
    useMaterial3: controller.useMaterial3,
  );
}
