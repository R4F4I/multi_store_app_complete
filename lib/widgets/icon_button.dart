import "package:flutter/material.dart";

class IconsButton extends StatelessWidget {
  final String label; 
  final Function() onPressed;
  final double width;
  final IconData? icon;
  final Color color;
  
  const IconsButton({
    super.key, required this.label,this.icon,required this.color, required this.onPressed, required this.width
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(25)),
        child: MaterialButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      )),
    );
  }
}