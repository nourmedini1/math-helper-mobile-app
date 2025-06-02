import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/components/home_screen_menu/mathematical_topics_group.dart';

class TopicsPage extends StatefulWidget {
  const TopicsPage({super.key});

  @override
  State<TopicsPage> createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 28, bottom: 0, left: 24),
                  child: Text(
                    "Mathematical topics",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const MathematicalTopicsGroupWidget(),
              ],
            ),
          );
  }
}