import 'package:flutter/material.dart';

class SelectButtonCommponent<T> extends StatefulWidget {
  final T value;
  final T selectedValue;
  final Function(T?) onChanged;

  final Widget Function(bool state)? builder;
  final EdgeInsetsGeometry? padding;
  const SelectButtonCommponent({
    super.key,
    required this.value,
    required this.selectedValue,
    required this.onChanged,
    this.builder,
    this.padding,
  });

  @override
  State<SelectButtonCommponent<T>> createState() => _SelectButtonCommponentState<T>();
}

class _SelectButtonCommponentState<T> extends State<SelectButtonCommponent<T>> {
  ValueNotifier<bool>? isSelected;
  @override
  void initState() {
    super.initState();
    isSelected = ValueNotifier<bool>(widget.value == widget.selectedValue);
  }

  @override
  void didUpdateWidget(covariant SelectButtonCommponent<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    isSelected?.value = widget.value == widget.selectedValue;
  }

  @override
  void dispose() {
    super.dispose();
    isSelected?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isSelected!,
      builder: (context, state, child) {
        return Padding(
          padding: widget.padding ?? EdgeInsets.zero,
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              if (state) {
                isSelected?.value = false;
                widget.onChanged(null as T);
              } else {
                isSelected?.value = true;
                widget.onChanged(widget.value);
              }
            },
            child: widget.builder!(state),
          ),
        );
      },
    );
  }
}





