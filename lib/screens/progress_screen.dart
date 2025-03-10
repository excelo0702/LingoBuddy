import 'package:flutter/material.dart';
import 'package:lingo_buddy/widgets/progress_section.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final ScrollController _mainScrollController = ScrollController();

  void _hidePopup() {
    Overlay.of(context).setState(() {}); // Trigger an update to remove any overlay
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hidePopup, // Hide popup when tapping anywhere
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.flag, color: Colors.white),
              Row(
                children: const [
                  Icon(Icons.local_fire_department, color: Colors.grey),
                  SizedBox(width: 5),
                  Text("0", style: TextStyle(color: Colors.white)),
                ],
              ),
              Row(
                children: const [
                  Icon(Icons.diamond_outlined, color: Colors.blue),
                  SizedBox(width: 5),
                  Text("5365", style: TextStyle(color: Colors.blue)),
                ],
              ),
              Row(
                children: const [
                  Icon(Icons.favorite, color: Colors.red),
                  SizedBox(width: 5),
                  Text("5", style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
        body: NotificationListener<ScrollUpdateNotification>(
          onNotification: (scrollNotification) {
            ProgressSection.hidePopup(); // Hide popup when scrolling
            return false;
          },
          child: ListView(
            controller: _mainScrollController,
            padding: const EdgeInsets.only(bottom: 50),
            children: [
              ProgressSection(title: "Section 1: Order Food", stepCount: 4, scrollController: _mainScrollController),
              ProgressSection(title: "Section 2: Payment", stepCount: 4, scrollController: _mainScrollController),
              ProgressSection(title: "Section 3: Delivery", stepCount: 6, scrollController: _mainScrollController),
            ],
          ),
        ),
      ),
    );
  }
}
