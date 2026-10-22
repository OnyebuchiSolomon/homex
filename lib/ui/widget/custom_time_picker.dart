import 'package:flutter/material.dart';

import '../../core/widgets/image_view.dart';
import '../../res/app_images.dart';
import 'dropdown_view.dart';

class CustomTimePicker extends StatefulWidget {
  final String hintText;
  final bool isExpanded;
  final String timeFormat;
  final void Function(TimeOfDay time)? onSelected;
  const CustomTimePicker({
    this.hintText = 'Select Time',
    this.timeFormat = 'hh:mm a',
    this.isExpanded = true,
    this.onSelected,
    super.key,
  });

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  TimeOfDay? selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTime ?? TimeOfDay.now(),
        builder: (BuildContext? context, Widget? child) {
          return Theme(
              data: Theme.of(context!).copyWith(
                  colorScheme: ColorScheme.light(
                      primary: Theme.of(context).colorScheme.secondary)),
              child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: false),
                child: child!,
              ));
        });

    if (picked != null && picked != selectedTime) {
      setState(()=> selectedTime = picked);
      if (widget.onSelected != null) widget.onSelected!(picked);
    }
  }

  String get formatTime {
    if (selectedTime == null) {
      return widget.hintText;
    }
    return '${selectedTime!.hour} : ${selectedTime!.minute} : ${selectedTime!.minute} ${selectedTime!.period.name.toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectTime(context),
      child: DropdownCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(formatTime),
            if (widget.isExpanded) ...[
              const Spacer()
            ] else ...[
              const SizedBox(width: 15)
            ],
            ImageView.svg(AppImages.icTimePicker),
          ],
        ),
      ),
    );
  }
}
