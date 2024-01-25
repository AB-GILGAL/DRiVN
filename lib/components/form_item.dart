import 'package:drivn_customer/utils/export.dart';

class FormItem extends StatefulWidget {
  FormItem({
    super.key,
    required this.name,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.validator,
    this.obscureText = false,
  });
  final String? name;

  final TextEditingController? controller;

  final String? hintText;

  final Widget? suffixIcon;

  bool obscureText = false;

  final String? Function(String?)? validator;

  @override
  State<FormItem> createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name!,
          style: TextStyle(
              color: CustomeColors.yellowColor,
              fontSize: AppDimentions.smallFontSize),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 15),
          child: TextFormField(
            cursorColor: CustomeColors.whiteColor,
            style: const TextStyle(color: CustomeColors.whiteColor),
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: CustomeColors.greyColor),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: CustomeColors.whiteColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: CustomeColors.whiteColor),
              ),
              suffixIcon: widget.suffixIcon,
            ),
            obscureText: widget.obscureText,
          ),
        ),
      ],
    );
  }
}
