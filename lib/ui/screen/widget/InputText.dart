import 'package:flutter/material.dart';
import 'package:sketoo/utils/typograhpy.dart';

class InputText extends StatefulWidget {
  final String initialText;
  final Color backgroundColor;
  final double width;
  final double height;

  const InputText(
      {Key? key,
      required this.initialText,
      required this.backgroundColor,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
        child: TextField(
          controller: _controller,
          style: inputJua,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 25.0,
              ),
            ),
            hintText: widget.initialText,
            hintStyle: inputJua,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 6),
            alignLabelWithHint: true,
          ),
        ),
      ),
    );
  }
}
