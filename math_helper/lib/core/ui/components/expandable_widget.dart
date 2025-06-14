import 'package:flutter/material.dart';
import 'package:math_helper/core/ui/app_colors.dart';

class ExpandableGroup extends StatefulWidget {
  /// optional property control the expanded or collapsed list
  ///
  /// Default value is false
  final bool isExpanded;

  /// required widget and display the header of each group
  ///
  ///
  final Widget header;

  /// required list `ListTile` widget for group items
  ///
  ///
  final List<Widget> items;

  /// optional widget for expanded Icon.
  ///
  /// Default value is `Icon(Icons.keyboard_arrow_down)`
  final Widget? expandedIcon;

  /// optional widget for collapse Icon.
  ///
  /// Default value is `Icon(Icons.keyboard_arrow_right)`
  final Widget? collapsedIcon;

  /// option value for header EdgeInsets
  ///
  /// Default value will `EdgeInsets.only(left: 0.0, right: 16.0)`
  final EdgeInsets? headerEdgeInsets;

  /// background color of header
  ///
  /// Default value `Theme.of(context).appBarTheme.color`
  final Color? headerBackgroundColor;

  const ExpandableGroup(
      {Key? key,
      this.isExpanded = false,
      required this.header,
      required this.items,
      this.expandedIcon,
      this.collapsedIcon,
      this.headerEdgeInsets,
      this.headerBackgroundColor})
      : super(key: key);

  @override
  _ExpandableGroupState createState() => _ExpandableGroupState();
}

class _ExpandableGroupState extends State<ExpandableGroup> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _updateExpandState(widget.isExpanded);
  }

  void _updateExpandState(bool isExpanded) =>
      setState(() => _isExpanded = isExpanded);

  @override
  Widget build(BuildContext context) {
    return _isExpanded ? _buildListItems(context) : _wrapHeader();
  }

  Widget _wrapHeader() {
    List<Widget> children = [];
    
    children.add(ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: widget.headerEdgeInsets ??
          const EdgeInsets.only(left: 0.0, right: 16.0),
      title: widget.header,
      trailing: _isExpanded
          ? widget.expandedIcon ?? const Icon(Icons.keyboard_arrow_down)
          : widget.collapsedIcon ?? const Icon(Icons.keyboard_arrow_right),
      onTap: () => _updateExpandState(!_isExpanded),
    ));
    return ClipRRect(
  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
  child: Ink(
    color: widget.headerBackgroundColor ?? AppColors.primaryColor,
    child: Column(
      children: children,
    ),
  ),
);
  }

  Widget _buildListItems(BuildContext context) {
    List<Widget> titles = [];
    titles.add(_wrapHeader());
    titles.addAll(widget.items);
    titles.add(const SizedBox(height: 16)); // Add some space at the end
    return Column(
      
      children: titles,
    );
  }
}
