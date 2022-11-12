import 'dart:ui';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/plan.dart';
import 'package:control/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PremiumItemsPage {
  void show(
    BuildContext context, {
    required List<Plan> plans,
    required FiicoUser? user,
    required Function(Plan) onPlanSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return PremiumItemsPageView(
          user: user,
          plans: plans,
          context: context,
          onPlanSelected: onPlanSelected,
        );
      },
    );
  }
}

class PremiumItemsPageView extends StatelessWidget {
  const PremiumItemsPageView({
    Key? key,
    required this.context,
    required this.plans,
    required this.user,
    required this.onPlanSelected,
  }) : super(key: key);

  final BuildContext context;
  final List<Plan> plans;
  final FiicoUser? user;
  final Function(Plan) onPlanSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      padding: EdgeInsets.only(
        left: FiicoPaddings.eight,
        right: FiicoPaddings.eight,
        top: FiicoPaddings.thirtyTwo,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: FiicoColors.grayNightDark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(FiicoPaddings.twenyFour),
          topRight: Radius.circular(FiicoPaddings.twenyFour),
        ),
      ),
      child: SafeArea(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            _title(),
            _movementListView(plans, user, onPlanSelected),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(
        right: FiicoPaddings.sixteen,
        left: FiicoPaddings.sixteen,
        bottom: FiicoPaddings.twenyFour,
      ),
      child: Text(
        FiicoLocale().saveMoreWhitPremiumUnlimited,
        textAlign: TextAlign.center,
        style: Style.desc.copyWith(
          color: FiicoColors.white,
          fontSize: FiicoFontSize.xm,
        ),
      ),
    );
  }

  Widget _movementListView(
      List<Plan> plans, FiicoUser? user, Function(Plan) onPlanSelected) {
    return SizedBox(
      height: plans.length * 85,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: plans.length,
        itemBuilder: (context, index) {
          Plan plan = plans[index];
          return GestureDetector(
            onTap: () {
              if (!user!.isPremium() ||
                  plan.isUnlimited() != user.isUnlimited()) {
                Navigator.of(context).pop();
                onPlanSelected(plan);
              }
            },
            child: _getPlanItem(plan, user),
          );
        },
      ),
    );
  }

  Widget _getPlanItem(Plan plan, FiicoUser? user) {
    return Container(
      padding: const EdgeInsets.all(FiicoPaddings.four),
      width: (MediaQuery.of(context).size.width / 3) - 6,
      alignment: Alignment.center,
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(FiicoPaddings.eight),
        decoration: BoxDecoration(
          color:
              plan.unlimited! ? FiicoColors.black : FiicoColors.grayNightDark,
          border: Border.all(
            color: plan.unlimited! ? FiicoColors.gold : FiicoColors.pink,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(FiicoPaddings.twelve),
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  plan.icon!,
                  width: 40,
                ),
                Text(
                  plan.getPlanTitle(),
                  style: Style.title.copyWith(
                    color: FiicoColors.white,
                    fontSize: FiicoFontSize.sm,
                  ),
                  maxLines: FiicoMaxLines.four,
                  textAlign: TextAlign.center,
                ),
                Text(
                  plan.priceDetail ?? '',
                  style: Style.title.copyWith(
                    color:
                        plan.unlimited! ? FiicoColors.gold : FiicoColors.pink,
                    fontSize: FiicoFontSize.xm,
                  ),
                  maxLines: FiicoMaxLines.four,
                  textAlign: TextAlign.center,
                ),
                Text(
                  plan.getDurationTitle(),
                  style: Style.subtitle.copyWith(
                    color: FiicoColors.graySoft,
                    fontSize: FiicoFontSize.xxs,
                  ),
                  maxLines: FiicoMaxLines.four,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Visibility(
              visible:
                  user!.isPremium() && plan.isUnlimited() == user.isUnlimited(),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: FiicoColors.grayNightDark.withOpacity(0.1),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
