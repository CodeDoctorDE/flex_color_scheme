import 'package:flutter/material.dart';

import '../../../../shared/controllers/theme_controller.dart';
import '../../../../shared/utils/link_text_span.dart';
import '../../../../shared/widgets/universal/list_tile_reveal.dart';
import '../../../../shared/widgets/universal/showcase_material.dart';
import '../../../../shared/widgets/universal/slider_list_tile_reveal.dart';
import '../../../../shared/widgets/universal/switch_list_tile_reveal.dart';
import '../../../theme/theme_values.dart';
import '../../shared/color_scheme_popup_menu.dart';

class SearchBarPanel extends StatelessWidget {
  const SearchBarPanel(this.controller, {super.key});
  final ThemeController controller;

  static final Uri _fcsFlutterIssue126623 = Uri(
    scheme: 'https',
    host: 'github.com',
    path: 'flutter/flutter/issues/126623',
  );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle spanTextStyle = theme.textTheme.bodySmall!;
    final TextStyle linkStyle = theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary, fontWeight: FontWeight.bold);

    // The most common logic for enabling Playground controls.
    final bool enableControl =
        controller.useSubThemes && controller.useFlexColorScheme;
    // Get effective platform default global radius.
    final double? effectiveRadius = ThemeValues.effectiveRadius(controller);
    final String defaultLabel =
        controller.searchRadius == null && effectiveRadius == null
            ? 'Stadium/28dp'
            : controller.searchRadius == null &&
                    effectiveRadius != null &&
                    controller.searchUseGlobalShape
                ? 'global ${effectiveRadius.toStringAsFixed(0)} dp'
                : 'Stadium/28dp';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8),
        SwitchListTileReveal(
          title: const Text('Fullscreen search view'),
          dense: true,
          subtitleReveal: const Text(
              'This is NOT a theming property! It is a toggle that enables '
              'you to test the fullscreen SearchView instead, '
              'of the default one opening under the SearchBar.\n'),
          value: controller.searchIsFullScreen,
          onChanged: controller.setSearchIsFullScreen,
        ),
        SearchBarShowcase(isFullScreen: controller.searchIsFullScreen),
        const Divider(),
        ColorSchemePopupMenu(
          enabled: enableControl,
          title: const Text('Background color'),
          defaultLabel: 'surfaceContainerHigh',
          value: controller.searchBackgroundSchemeColor,
          onChanged: controller.setSearchBackgroundSchemeColor,
        ),
        SliderListTileReveal(
          enabled: enableControl,
          title: const Text('Elevation'),
          subtitleReveal: const Text('In the Playground there is currently '
              'only one control for the elevation of the SearchBar and '
              'SearchView, but they are separate in the FlexColorScheme API. '
              'You can see this in the generated code too.\n'),
          value: controller.searchElevation,
          onChanged: controller.setSearchElevation,
          min: 0,
          max: 40,
          divisions: 40,
          valueDecimalPlaces: 0,
          valueHeading: 'ELEV',
          valueDefaultLabel: '6',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SliderListTileReveal(
                enabled: enableControl,
                contentPadding: ThemeValues.tilePaddingStart(context),
                title: const Text('Radius'),
                subtitleReveal: const Text(
                  'The SearchBar default is Stadium shaped '
                  'and the default SearchView is 28dp. In the Playground there '
                  'is currently only one control for the radius, but they are '
                  'separate in the FlexColorScheme API, you can see this '
                  'in the generated code too.\n',
                ),
                value: controller.searchRadius,
                onChanged: controller.setSearchRadius,
                min: 0,
                max: 40,
                divisions: 40,
                valueDecimalPlaces: 0,
                valueHeading: 'RADIUS',
                valueUnitLabel: ' dp',
                valueDefaultLabel: defaultLabel,
                valueDefaultDisabledLabel: 'Stadium/28dp',
              ),
            ),
            Expanded(
              child: SwitchListTileReveal(
                title: const Text('Use global'),
                enabled: enableControl,
                contentPadding: ThemeValues.tilePaddingEnd(context),
                subtitleReveal: const Text(
                    'If ON the SearchBar and SearchView radius will use the '
                    'global border radius and its platform adaptive setting '
                    'if a radius has not been defined.\n'),
                value: controller.searchUseGlobalShape,
                onChanged: controller.setSearchUseGlobalShape,
              ),
            ),
          ],
        ),
        SliderListTileReveal(
          enabled: enableControl,
          title: const Text('SearchView header height'),
          value: controller.searchViewHeaderHeight,
          onChanged: controller.setSearchViewHeaderHeight,
          min: 40,
          max: 100,
          divisions: 60,
          valueDecimalPlaces: 0,
          valueHeading: 'HEIGHT',
          valueDefaultLabel: '56 dp',
        ),
        const Divider(),
        ListTileReveal(
          dense: true,
          title: const Text('Known issues'),
          subtitleReveal: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  style: spanTextStyle,
                  text: 'The InputDecoration theme leeks through into '
                      'SearchBar and SearchView. From the SearchView it cannot '
                      'even be removed with a Theme wrapper. For more '
                      'information, see ',
                ),
                LinkTextSpan(
                  style: linkStyle,
                  uri: _fcsFlutterIssue126623,
                  text: 'issue #126623',
                ),
                TextSpan(
                  style: spanTextStyle,
                  text: '. This issue has been fixed in Flutter 3.13.\n'
                      '\n'
                      'The SearchView suffers from the common Flutter lack '
                      'of support f variant themes, thus if you set the '
                      'shape to something else for the none full screen mode '
                      'the full screen mode gets the same shape. You do not '
                      'want or expect that, it should remain without a shape '
                      'in full screen mode. See issue <report and add link>.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
