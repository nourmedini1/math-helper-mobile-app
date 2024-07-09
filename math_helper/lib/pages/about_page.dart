import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/components/app_bar/custom_app_bar.dart';
import 'package:math_helper/core/ui/components/drawer/custom_drawer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          context: context, tabController: null, isHomePage: false),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? pageBody(context)
            : ListView(
                physics: const BouncingScrollPhysics(),
                children: [pageBody(context)],
              ),
      ),
    );
  }

  Column pageBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        title(context),
        sectionOne(context),
        sectionTwo(context),
        sectionThree(context),
        sectionFour(context),
      ],
    );
  }

  Column sectionTwo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("MathHelper is perfect for:",
            style: Theme.of(context).textTheme.titleSmall),
        Text(
            """Students of calculus, differential equations, linear algebra, and complex analysis. Professionals who need a math refresher or on-the-go problem-solving tool. Anyone who wants to conquer complex mathematical concepts.""",
            style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Column sectionThree(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("Master the Material:",
            style: Theme.of(context).textTheme.titleSmall),
        Text(
          "Go beyond basic solutions. MathHelper offers insights and explanations to solidify your understanding of each topic.",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Column sectionFour(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("Here's what MathHelper offers:",
            style: Theme.of(context).textTheme.titleSmall),
        RichText(
          text: TextSpan(
            style: TextStyle(
                fontSize: 15,
                fontFamily: Theme.of(context).textTheme.bodySmall!.fontFamily,
                color: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .color), // Default style
            // Default style
            children: const <TextSpan>[
              TextSpan(
                  text: 'Calculus: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text:
                      'Tackle single, double, and triple integrals, derivatives, limits, summations, products, and Taylor series with ease.\n'),
              TextSpan(
                  text: 'Differential Equations: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text:
                      'Solve differential equations and understand their behavior.\n'),
              TextSpan(
                  text: 'Linear Algebra: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text:
                      'Add, multiply, invert, and find the determinant and rank of matrices.\n'),
              TextSpan(
                  text: 'Complex Analysis: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text:
                      'Perform operations on complex numbers, convert them to polar form, and delve into the world of complex variables.'),
            ],
          ),
        ),
      ],
    );
  }

  Column sectionOne(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Your All-in-One Math Toolkit:",
            style: Theme.of(context).textTheme.titleSmall),
        Text(
            "Struggling with complex math problems? Drowning in a sea of formulas? MathHelper is your personal tutor, equation slayer, and all-around math whiz, ready to guide you through the intricacies of higher mathematics.",
            style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Text title(BuildContext context) {
    return Text("About Our App",
        style: TextStyle(
          color: AppColors.primaryColorTint30,
          fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
          fontFamily: Theme.of(context).textTheme.titleMedium!.fontFamily,
        ));
  }
}
