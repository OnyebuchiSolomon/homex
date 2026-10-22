import 'package:homex/ui/global.dart';

class TextEditView extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;

  final Color? fillColor;
  final GestureTapCallback? onTap;

  final String? labelText;
  final String? hintText;

  final bool readOnly;
  final bool autofocus;
  final bool enableBoarder;
  final bool autocorrect;
  final bool obscureText;

  final double borderRadius;
  final double height;
  final double borderWidth;

  final bool isDense;

  final Widget? suffixIcon;
  final Widget? prefixIcon;

  final Color? borderColor;
  final Color? iconColor;
  final Color? textColor;

  final int? minLines;
  final int? maxLines;
  final int? maxLength;

  final bool filled;

  final String? prefixText;
  final String? helperText;

  final TextStyle? labelStyle;
  final TextAlign textAlign;

  final List<TextInputFormatter>? inputFormatters;

  final EdgeInsetsGeometry? contentPadding;

  final Iterable<String>? autofillHints;

  final FocusNode? focusNode;

  const TextEditView({
    super.key,
    this.onChanged,
    required this.controller,
    this.fillColor,
    this.onTap,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.autofocus = false,
    this.enableBoarder = true,
    this.autocorrect = false,
    this.obscureText = false,
    this.isDense = true,
    this.labelText,
    this.hintText,
    this.borderRadius = 6.0,
    this.borderWidth = 1.0,
    this.height = 42.0,
    this.suffixIcon,
    this.iconColor,
    this.textColor,
    this.prefixIcon,
    this.borderColor,
    this.filled = true,
    this.prefixText,
    this.autofillHints,
    this.focusNode,
    this.helperText,
    this.minLines,
    this.maxLength,
    this.maxLines = 1,
    this.labelStyle,
    this.contentPadding,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
  });

  @override
  State<TextEditView> createState() => _TextEditViewState();
}

class _TextEditViewState extends State<TextEditView> {
  late bool _obscurePassword;

  @override
  void initState() {
    super.initState();

    _obscurePassword = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant TextEditView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.obscureText != widget.obscureText) {
      _obscurePassword = widget.obscureText;
    }
  }

  OutlineInputBorder _border(
      BuildContext context, {
        required Color color,
      }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: widget.enableBoarder
          ? BorderSide(
        width: widget.borderWidth,
        color: color,
        style: BorderStyle.solid,
      )
          : BorderSide.none,
    );
  }

  UnderlineInputBorder _underlineBorder(
      BuildContext context, {
        required Color color,
      }) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        width: widget.borderWidth,
        color: color,
        style: BorderStyle.solid,
      ),
    );
  }

  OutlineInputBorder _errorBorder(
      BuildContext context, {
        required Color color,
      }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(
        width: widget.borderWidth,
        color: color,
        style: BorderStyle.solid,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    // ============================================================
    // THEME COLORS
    // ============================================================

    final fillColor =
        widget.fillColor ?? colors.surfaceContainerHighest;

    final borderColor =
        widget.borderColor ?? colors.outline;

    final focusedBorderColor =
        widget.borderColor ?? colors.primary;

    final iconColor =
        widget.iconColor ?? colors.onSurfaceVariant;

    final textColor =
        widget.textColor ?? colors.onSurface;

    final hintColor =
    colors.onSurface.withValues(alpha: 0.55);

    final labelColor =
        colors.onSurfaceVariant;

    final errorColor =
        colors.error;

    return SizedBox(
      height: widget.height,
      child: TextFormField(
        controller: widget.controller,

        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,

        validator: widget.validator,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        onFieldSubmitted: widget.onFieldSubmitted,

        inputFormatters: widget.inputFormatters,

        autocorrect: widget.autocorrect,
        readOnly: widget.readOnly,
        autofocus: widget.autofocus,

        obscureText: widget.obscureText && _obscurePassword,

        minLines: widget.minLines,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,

        textAlign: widget.textAlign,

        // Keeps the text vertically centered.
        textAlignVertical: TextAlignVertical.center,

        autofillHints: widget.autofillHints,
        focusNode: widget.focusNode,

        style: textTheme.bodyLarge?.copyWith(
          color: textColor,
        ),

        cursorColor: colors.primary,

        selectionControls: materialTextSelectionControls,

        decoration: InputDecoration(
          // ========================================================
          // CONTENT PADDING
          // ========================================================

          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 0,
              ),

          // ========================================================
          // BORDERS
          // ========================================================

          border: widget.enableBoarder
              ? _border(
            context,
            color: borderColor,
          )
              : _underlineBorder(
            context,
            color: borderColor,
          ),

          enabledBorder: widget.enableBoarder
              ? _border(
            context,
            color: borderColor,
          )
              : _underlineBorder(
            context,
            color: borderColor,
          ),

          focusedBorder: widget.enableBoarder
              ? _border(
            context,
            color: focusedBorderColor,
          )
              : _underlineBorder(
            context,
            color: focusedBorderColor,
          ),

          focusedErrorBorder: widget.enableBoarder
              ? _errorBorder(
            context,
            color: errorColor,
          )
              : _underlineBorder(
            context,
            color: errorColor,
          ),

          errorBorder: widget.enableBoarder
              ? _errorBorder(
            context,
            color: errorColor,
          )
              : _underlineBorder(
            context,
            color: errorColor,
          ),

          disabledBorder: widget.enableBoarder
              ? _border(
            context,
            color: colors.outline.withValues(
              alpha: 0.5,
            ),
          )
              : _underlineBorder(
            context,
            color: colors.outline.withValues(
              alpha: 0.5,
            ),
          ),

          // ========================================================
          // TEXT
          // ========================================================

          hintText: widget.hintText,

          hintStyle: AppTextStyles.labelSmall.copyWith(
            color: hintColor,
          ),

          labelText: widget.labelText,

          labelStyle:
          widget.labelStyle ??
              AppTextStyles.labelSmall.copyWith(
                color: labelColor,
              ),

          // ========================================================
          // FIELD
          // ========================================================

          filled: widget.filled,

          fillColor: fillColor,

          isDense: widget.isDense,

          // ========================================================
          // HELPER
          // ========================================================

          helperText: widget.helperText,

          helperMaxLines: 2,

          helperStyle: AppTextStyles.labelSmall.copyWith(
            color: colors.onSurfaceVariant,
          ),

          // ========================================================
          // PREFIX
          // ========================================================

          prefixText: widget.prefixText,

          prefixIcon: widget.prefixIcon,

          prefixIconColor: iconColor,

          // ========================================================
          // ICON
          // ========================================================

          iconColor: iconColor,

          suffixIcon: widget.suffixIcon ??
              (widget.obscureText
                  ? IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 38,
                  minHeight: 38,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword =
                    !_obscurePassword;
                  });
                },
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  size: 18,
                  color: iconColor.withValues(
                    alpha: 0.65,
                  ),
                ),
              )
                  : null),

          suffixIconColor: iconColor,

          // Prevent Flutter from adding unnecessary
          // vertical space.
          isCollapsed: false,
        ),
      ),
    );
  }
}

class InputLabel extends StatelessWidget {
  final String label;
  final Widget child;
  final bool isRequired;

  const InputLabel({
    required this.child,
    required this.label,
    this.isRequired = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: label,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: colors.onSurface,
                    ),
                  ),

                  if (isRequired)
                    WidgetSpan(
                      child: Transform.translate(
                        offset: const Offset(5, -2),
                        child: Text(
                          '*',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: colors.error,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        child,
      ],
    );
  }
}