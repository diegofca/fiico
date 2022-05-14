import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PremiumItemsPage {
  void show(
    BuildContext context, {
    required List<Plan> plans,
    required Function(Plan) onPlanSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return PremiumItemsPageView(
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
    required this.onPlanSelected,
  }) : super(key: key);

  final BuildContext context;
  final List<Plan> plans;
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
        color: FiicoColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(FiicoPaddings.twenyFour),
          topRight: Radius.circular(FiicoPaddings.twenyFour),
        ),
      ),
      child: SafeArea(
        child: Wrap(
          children: [
            _title(),
            _movementListView(plans, onPlanSelected),
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
        "Ahorra con PREMIUM UNLIMITED",
        style: Style.title.copyWith(
          color: FiicoColors.black,
          fontSize: FiicoFontSize.md,
        ),
      ),
    );
  }

  Widget _movementListView(List<Plan> plans, Function(Plan) onPlanSelected) {
    return SizedBox(
      height: plans.length * 75,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: plans.length,
        itemBuilder: (context, index) {
          Plan plan = plans[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              onPlanSelected(plan);
            },
            child: _getPlanItem(plan),
          );
        },
      ),
    );
  }

  Widget _getPlanItem(Plan plan) {
    return Container(
      padding: const EdgeInsets.all(FiicoPaddings.four),
      width: (MediaQuery.of(context).size.width / 3) - 6,
      alignment: Alignment.center,
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(FiicoPaddings.eight),
        decoration: BoxDecoration(
          color: FiicoColors.purpleLite,
          border: Border.all(
            color: FiicoColors.pink,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(FiicoPaddings.twelve),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              plan.icon!,
              width: 30,
            ),
            Text(
              plan.name ?? '',
              style: Style.title.copyWith(
                color: FiicoColors.black,
                fontSize: FiicoFontSize.sm,
              ),
              maxLines: FiicoMaxLines.four,
              textAlign: TextAlign.center,
            ),
            Text(
              plan.priceDetail ?? '',
              style: Style.title.copyWith(
                color: FiicoColors.purpleDark,
                fontSize: FiicoFontSize.xs,
              ),
              maxLines: FiicoMaxLines.four,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
