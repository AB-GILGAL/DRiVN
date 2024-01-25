import 'package:drivn_customer/utils/export.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key, this.onPressed, this.title, this.bgd, this.side});
  final Color? bgd;
  final String? title;
  final MaterialStateProperty<BorderSide?>? side;

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: bgd,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
        child: Text(
          title!,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
