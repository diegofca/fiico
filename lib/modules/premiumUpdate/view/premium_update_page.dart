import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/modules/premiumUpdate/view/premium_update_success_view.dart';
import 'package:flutter/material.dart';

class PremiumUpdatePage {
  void show(
    BuildContext context, {
    required Function onUpdateIntent,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return PremiumUpdatePageView(
          onUpdateIntent: onUpdateIntent,
        );
      },
    );
  }
}

class PremiumUpdatePageView extends StatelessWidget {
  const PremiumUpdatePageView({
    Key? key,
    required this.onUpdateIntent,
  }) : super(key: key);

  final Function onUpdateIntent;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      padding: EdgeInsets.only(
        top: FiicoPaddings.thirtyTwo,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(FiicoPaddings.twenyFour),
          topRight: Radius.circular(FiicoPaddings.twenyFour),
        ),
      ),
      child: SafeArea(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            const PremiumUpdateSuccessView(),
            _buyButtonView(context, onUpdateIntent),
          ],
        ),
      ),
    );
  }

  Widget _buyButtonView(BuildContext context, Function onUpdateIntent) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        vertical: FiicoPaddings.eight,
        horizontal: FiicoPaddings.thirtyTwo,
      ),
      child: FiicoButton(
        title: FiicoLocale().update,
        color: FiicoColors.pink,
        textColor: FiicoColors.white,
        onTap: () {
          Navigator.of(context).pop();
          onUpdateIntent.call();
        },
      ),
    );
  }
}
