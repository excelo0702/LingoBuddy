import 'package:flutter/material.dart';
import 'package:lingo_buddy/widgets/step.dart';
import '../popups/step_selection_popup.dart';

class ProgressSection extends StatefulWidget {
  final String title;
  final int stepCount;
  final ScrollController scrollController;

  const ProgressSection({
    super.key,
    required this.title,
    required this.stepCount,
    required this.scrollController
  });

  static void hidePopup() {
    _ProgressSectionState._hidePopup(); // Call static hide method
  }

  @override
  State<ProgressSection> createState() => _ProgressSectionState();
}

class _ProgressSectionState extends State<ProgressSection> {
  double width = double.infinity;
  List<double> positions = [0.2, 0.5, 0.7, 0.5];
  static bool _scrollingInProgress = false;
  static OverlayEntry? _overlayEntry;
  final List<GlobalKey> _stepKeys = List.generate(10, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        width = MediaQuery.of(context).size.width;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _showPopup(BuildContext context, int index, double xOffset) {
    if (_overlayEntry != null) {
      _hidePopup(); // Hide any existing popup first
    }

    final keyContext = _stepKeys[index].currentContext;
    if (keyContext == null) return;

    RenderBox renderBox = keyContext.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);
    Size size = renderBox.size;

    double screenHeight = MediaQuery.of(context).size.height;
    double popupHeight = 200; // Approximate height of the popup
    double bottomSpace = screenHeight - (position.dy + size.height);

    if (bottomSpace < popupHeight) {
      // Calculate how much to scroll to make space
      double scrollOffset = (popupHeight - bottomSpace).clamp(0, widget.scrollController.position.maxScrollExtent);

      _scrollingInProgress = true;

      widget.scrollController.animateTo(
        widget.scrollController.offset + scrollOffset + 20,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ).then((_) {
        _scrollingInProgress = false;
        // After scrolling, recalculate position and show popup
        _showPopupAfterScroll(context, index, xOffset);
      });

    } else {
      _insertPopup(context, index, xOffset, position, size);
    }
  }

  void _showPopupAfterScroll(BuildContext context, int index, double xOffset) {
    if (_overlayEntry != null) return; // If popup already exists, return

    final keyContext = _stepKeys[index].currentContext;
    if (keyContext == null) return;

    RenderBox renderBox = keyContext.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);
    Size size = renderBox.size;

    _insertPopup(context, index, xOffset, position, size);
  }

  void _insertPopup(BuildContext context, int index, double xOffset, Offset position, Size size) {
    _overlayEntry = OverlayEntry(
      builder: (context) => StepSelectionPopup(
        index: index,
        xOffset: xOffset,
        position: position,
        onClose: _hidePopup,
        size: size,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }



  static void _hidePopup() {
    if (_scrollingInProgress) return;

    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ...List.generate(
            widget.stepCount,
                (index) {
              double xOffset = width * positions[index % 4];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _showPopup(context, index, xOffset);
                    },
                    child: StepWidget(
                      xOffset: xOffset,
                      name: "Step ${index + 1}",
                      keyWidget: _stepKeys[index],
                    ),
                  ),
                  if (index < widget.stepCount - 1) const SizedBox(height: 20),
                ],
              );
            },
          ),
        ],
    );
  }
}
