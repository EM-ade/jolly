import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? label;
  final bool obscureText;
  final TextInputType keyboardType;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double? height;
  final bool showPasswordToggle;

  const CustomTextField({
    super.key,
    this.hintText,
    this.label,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.height,
    this.showPasswordToggle = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: widget.borderColor ?? const Color(0xFFA3CB43),
              width: 2,
            ),
          ),
          child: TextField(
            obscureText: _isObscured,
            keyboardType: widget.keyboardType,
            style: TextStyle(color: widget.textColor ?? Colors.black),
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              hintStyle: TextStyle(
                color: widget.textColor?.withOpacity(0.5) ?? Colors.grey,
              ),
              suffixIcon: widget.showPasswordToggle
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SvgPicture.asset(
                          'assets/images/reveal.svg',
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            widget.textColor ?? Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
