// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class FiicoSelectorIcon {
  static Future<FiicoIcon?> select(BuildContext context) async {
    final icon = await FlutterIconPicker.showIconPicker(
      context,
      title: const Text('Seleccione un icono'),
      closeChild: FiicoButton.green(
        title: 'Cancelar',
        ontap: () {
          Navigator.of(context).pop();
        },
      ),
      noResultsText: 'No se encontraron resultados de ',
      searchHintText: 'Buscar',
      iconColor: FiicoColors.grayDark,
      adaptiveDialog: false,
      showTooltips: true,
      iconPackModes: [
        IconPack.fontAwesomeIcons,
        IconPack.lineAwesomeIcons,
        IconPack.cupertino,
        IconPack.material,
      ],
    );
    return icon == null ? null : FiicoIcon.fromIcon(icon);
  }
}
