 import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_utils.dart';
 import '../../core/widgets/image_view.dart';
import '../../res/app_images.dart';
 import 'dropdown_view.dart';

class CustomDatePicker extends StatefulWidget {
  final Widget? child;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Color? pickerColor;
  final DateTime? initialDate;
  final DateTime? selectedDate;
  final void Function(DateTime dateTime)? onSelected;
  final SelectableDayPredicate? selectableDayPredicate;
  final bool isPreset;
  final String? hintText;
  final bool isExpanded;
  const CustomDatePicker(
      {required this.child,
      this.firstDate,
      this.lastDate,
      this.pickerColor,
      this.initialDate,
      this.selectedDate,
      this.onSelected,
      this.selectableDayPredicate,
      super.key})
      : isPreset = false,
        isExpanded = false,
        hintText = null;

  const CustomDatePicker.preset(
      {this.child,
      this.firstDate,
      this.lastDate,
      this.pickerColor,
      this.initialDate,
      this.selectedDate,
      this.onSelected,
      this.selectableDayPredicate,
      this.hintText = 'Select Date',
      this.isExpanded = true,
      super.key})
      : isPreset = true;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final date = DateTime.now();
    final picked = await selectDate(
      context,
      initialDate: selectedDate,
      pickerColor: widget.pickerColor,
      selectableDayPredicate: widget.selectableDayPredicate,
      firstDate: widget.firstDate ?? date.add(const Duration(days: -50000)),
      lastDate: widget.lastDate ?? date.add(const Duration(days: 90000)),
    );
    if (picked != null && picked != selectedDate) {
      setPicked(picked);
      if (widget.onSelected != null) widget.onSelected!(picked);
    }
  }

  void setPicked(picked) => setState(() => selectedDate = picked);

  @override
  void initState() {
    if (widget.initialDate != null) {
      selectedDate = widget.initialDate!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedDate != null) {
      selectedDate = widget.selectedDate!;
    }
    if (widget.isPreset) {
      return InkWell(
        onTap: () => _selectDate(context),
        child: DropdownCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(formatDate),
              if (widget.isExpanded) ...[
                const Spacer()
              ] else ...[
                const SizedBox(width: 15)
              ],
              widget.child ?? ImageView.svg(AppImages.icDatePicker),
            ],
          ),
        ),
      );
    }
    return InkWell(onTap: () => _selectDate(context), child: widget.child!);
  }

  String get formatDate {
    if (selectedDate == null) {
      return widget.hintText!;
    }
    final now = DateTime.now();
    if (now.day == selectedDate!.day &&
        now.month == now.month &&
        now.year == now.year) {
      return 'Today';
    }
    return AppUtils.dateFormat.format(selectedDate!);
  }
}

Future<DateTime?> selectDate(BuildContext context,
    {DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    SelectableDayPredicate? selectableDayPredicate,
    Color? pickerColor}) async {
  final date = DateTime.now();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? date,
      lastDate: lastDate ?? date.add(const Duration(days: 90000)),
      selectableDayPredicate: selectableDayPredicate,
      builder: (BuildContext? context, Widget? child) {
        return Theme(
            data: Theme.of(context!).copyWith(
                colorScheme: ColorScheme.light(
                    primary: pickerColor ??
                        Theme.of(context).colorScheme.secondary)),
            child: child!);
      });
  return picked;
}

Future<DateTimeRange?> selectDateRange(
  BuildContext context, {
  DateTimeRange? initialDateRange,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final date = DateTime.now();
  DateTimeRange? range = await showDateRangePicker(
      context: context,
      initialDateRange: initialDateRange,
      firstDate: firstDate ?? date,
      lastDate: lastDate ?? date.add(const Duration(days: 90000)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                    secondary: Theme.of(context).colorScheme.secondary,
                    primary: Theme.of(context).colorScheme.primary)),
            child: child!);
      });
  return range;
}
