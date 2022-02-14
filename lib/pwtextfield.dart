// TextField Custom
import 'package:flutter/material.dart';

class PWTextField<T> extends StatefulWidget {
  PWTextField(
    Key key,
    String label,
    String initialValue,
    T Function(String value)? onSubmited, {
    TextEditingController? controller,
    bool required = false,
    Widget? suffix,
    int? maxLines = 1,
    bool? readOnly = false,
  }) : super(key: key);

  final String label = '';
  final String initialValue = '';
  void Function(String value)? onSubmited;
  TextEditingController? controller;
  bool required = false;
  Widget? suffix;
  int? maxLines = 1;
  bool? readOnly = false;

  @override
  State<PWTextField<T>> createState() => _PWTextFieldState<T>();
}

class _PWTextFieldState<T> extends State<PWTextField<T>> {
  TextEditingController? _controller = TextEditingController(text: '');

  @override
  void initState() {
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: _controller,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: primary,
            ),
          ),
          suffix: widget.suffix,
        ),
        onFieldSubmitted: (value) {
          if (widget.onSubmited != null) {
            widget.onSubmited!(value);
          }
        },
        textInputAction: TextInputAction.next,
        readOnly: widget.onSubmited == null || widget.readOnly == true,
        validator: (value) {
          if (widget.required && value == '') {
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
    );
  }
}
