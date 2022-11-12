// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fiico_icons.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:simple_icons/simple_icons.dart';

class FiicoSelectorIcon {
  static Future<FiicoIcon?> select(BuildContext context) async {
    final icon = await FlutterIconPicker.showIconPicker(
      context,
      title: Text(FiicoLocale().selectAicon),
      closeChild: FiicoButton.pink(
        title: FiicoLocale().cancelButton,
        ontap: () {
          Navigator.of(context).pop();
        },
      ),
      noResultsText: FiicoLocale().notResultFoundFor,
      searchHintText: FiicoLocale().searchButton,
      iconColor: FiicoColors.grayDark,
      adaptiveDialog: false,
      showTooltips: true,
      customIconPack: _customIconPack,
      iconPackModes: [
        IconPack.fontAwesomeIcons,
        IconPack.lineAwesomeIcons,
        IconPack.cupertino,
        IconPack.material,
      ],
    );
    return icon == null ? null : FiicoIcon.fromIcon(icon);
  }

  static Map<String, IconData>? get _customIconPack {
    return {
      'abbott': SimpleIcons.abbott,
      'abbvie': SimpleIcons.abbvie,
      'abletonlive': SimpleIcons.abletonlive,
      'aboutdotme': SimpleIcons.aboutdotme,
      'abstracticon': SimpleIcons.abstracticon,
      'academia': SimpleIcons.academia,
      'accenture': SimpleIcons.accenture,
      'acclaim': SimpleIcons.acclaim,
      'accusoft': SimpleIcons.accusoft,
      'acer': SimpleIcons.acer,
      'acm': SimpleIcons.acm,
      'actigraph': SimpleIcons.actigraph,
      'activision': SimpleIcons.activision,
      'adafruit': SimpleIcons.adafruit,
      'adblock': SimpleIcons.adblock,
      'adblockplus': SimpleIcons.adblockplus,
      'addthis': SimpleIcons.addthis,
      'adguard': SimpleIcons.adguard,
      'adidas': SimpleIcons.adidas,
      'adobe': SimpleIcons.adobe,
      'adobeacrobatreader': SimpleIcons.adobeacrobatreader,
      'adobeaftereffects': SimpleIcons.adobeaftereffects,
      'adobeaudition': SimpleIcons.adobeaudition,
      'adobecreativecloud': SimpleIcons.adobecreativecloud,
      'adobedreamweaver': SimpleIcons.adobedreamweaver,
      'adobefonts': SimpleIcons.adobefonts,
      'adobeillustrator': SimpleIcons.adobeillustrator,
      'adobeindesign': SimpleIcons.adobeindesign,
      'adobelightroom': SimpleIcons.adobelightroom,
      'adobephotoshop': SimpleIcons.adobephotoshop,
      'adobepremierepro': SimpleIcons.adobepremierepro,
      'adobexd': SimpleIcons.adobexd,
      'adonisjs': SimpleIcons.adonisjs,
      'adyen': SimpleIcons.adyen,
      'aerlingus': SimpleIcons.aerlingus,
      'aeroflot': SimpleIcons.aeroflot,
      'aeromexico': SimpleIcons.aeromexico,
      'abbottstudio': SimpleIcons.abbrobotstudio,
      'behance': SimpleIcons.behance,
      'bankofamerica': SimpleIcons.bankofamerica,
      'bitbucket': SimpleIcons.bitbucket,
      'bitrise': SimpleIcons.bitrise,
      'apple music': SimpleIcons.applemusic,
      'niñera': MaterialCommunityIcons.baby_bottle,
      'amazon': Zocial.amazon,
      'netflix': MaterialCommunityIcons.netflix,
      'linkedin': Zocial.linkedin,
      'rappi': Icons.delivery_dining,
      'deezer': MdiIcons.shoppingMusic,
      'reddit': MaterialCommunityIcons.reddit,
      'icloud': MaterialCommunityIcons.apple_icloud,
      'redhat': MaterialCommunityIcons.redhat,
      'celular': MaterialCommunityIcons.cellphone_iphone,
      'telefono': MaterialCommunityIcons.cellphone_basic,
      'iglesia': MaterialCommunityIcons.christianity,
      'crunchyroll': SimpleIcons.crunchyroll,
      'zoom': SimpleIcons.zoom,
      'virgin': SimpleIcons.virgin,
      'pandora': SimpleIcons.pandora,
      'disneyPlus': AppIcon.disneyPlus,
      'sack': MdiIcons.sack,
    };
  }
}
