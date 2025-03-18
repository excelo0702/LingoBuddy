import 'package:flutter/material.dart';
import 'package:lingo_buddy/widgets/progress_section.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final ScrollController _mainScrollController = ScrollController();

  final List<Map<String, dynamic>> _progressSections = [
    {"title": "Section 1: Order Food", "stepCount": 4},
    {"title": "Section 2: Payment", "stepCount": 4},
    {"title": "Section 3: Delivery", "stepCount": 6},
  ];

  @override
  void dispose() {
    _mainScrollController.dispose();
    super.dispose();
  }

  void _hidePopup() {
    ProgressSection.hidePopup();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hidePopup,
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: _buildAppBar(),
        body: NotificationListener<ScrollUpdateNotification>(
          onNotification: (scrollNotification) {
            _hidePopup();
            return false;
          },
          child: _buildProgressList(),
        ),
      ),
    );
  }

  /// Builds the custom AppBar with progress indicators.
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.flag, color: Colors.white),
          _buildIconWithText(Icons.local_fire_department, "0", Colors.grey),
          _buildIconWithText(Icons.diamond_outlined, "5365", Colors.blue),
          _buildIconWithText(Icons.favorite, "5", Colors.red),
        ],
      ),
    );
  }

  /// Builds a row containing an icon and associated text.
  Widget _buildIconWithText(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 5),
        Text(text, style: TextStyle(color: color)),
      ],
    );
  }

  /// Builds the list of progress sections dynamically.
  Widget _buildProgressList() {
    return ListView.builder(
      controller: _mainScrollController,
      padding: const EdgeInsets.only(bottom: 50),
      itemCount: _progressSections.length,
      itemBuilder: (context, index) {
        return ProgressSection(
          title: _progressSections[index]["title"],
          stepCount: _progressSections[index]["stepCount"],
          scrollController: _mainScrollController,
        );
      },
    );
  }
}
