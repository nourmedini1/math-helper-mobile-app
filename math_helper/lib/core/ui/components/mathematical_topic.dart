import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';
import 'package:math_helper/core/ui/app_theme_data.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:provider/provider.dart';

class MathematicalTopicWidget extends StatefulWidget {
  final String title;
  final String description;
  final List<ListTile> elementsCards;
  final bool isExpanded;
  final Widget? expandedIcon;
  final Widget? collapsedIcon;
  final Widget? topicIcon;
  const MathematicalTopicWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.elementsCards,
      this.isExpanded = false,
      this.expandedIcon = const Icon(Icons.keyboard_arrow_down),
      this.collapsedIcon = const Icon(
        Icons.keyboard_arrow_up,
        color: AppColors.customBlackTint90,
      ),
      this.topicIcon});

  @override
  State<MathematicalTopicWidget> createState() =>
      _MathematicalTopicWidgetState();
}

class _MathematicalTopicWidgetState extends State<MathematicalTopicWidget> {
  late bool _isExpanded;
  @override
  void initState() {
    super.initState();
    _updateExpansionState(widget.isExpanded);
  }

  void _updateExpansionState(bool expansionState) =>
      setState(() => _isExpanded = expansionState);
  @override
  Widget build(BuildContext context) {
    return _isExpanded ? _buildContent(context) : _buildHeader();
  }

  Widget _buildHeader() {
    List<Widget> children = [];

    children.add(ListTile(
      title: Text(
        widget.title,
        style: TextStyle(
          color: Theme.of(context).textTheme.titleSmall!.color,
          fontSize: 18,
          fontFamily: Theme.of(context).textTheme.titleSmall!.fontFamily,
        ),
      ),
      subtitle: Text(
        widget.description,
        style: Theme.of(context).textTheme.labelSmall,
      ),
      leading: widget.topicIcon,
      trailing: _isExpanded ? widget.expandedIcon : widget.collapsedIcon,
      onTap: () => _updateExpansionState(!_isExpanded),
    ));
    return Ink(
      color: Theme.of(context).cardColor,
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    List<Widget> titles = [];
    titles.add(_buildHeader());
    titles.addAll(widget.elementsCards);
    return Column(
      children: ListTile.divideTiles(
        tiles: titles,
        context: context,
        color: Provider.of<ThemeManager>(context).themeData ==
                AppThemeData.lightTheme
            ? AppColors.primaryColorTint40
            : AppColors.customWhite,
      ).toList(),
    );
  }
}
