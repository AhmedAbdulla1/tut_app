import 'package:flutter/material.dart';
import 'package:painter/painter.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: Size(200,(200*0.625).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
        painter: RPSCustomPainter(),
      ),
    );
  }
}


class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;


    Path path0 = Path();
    path0.moveTo(size.width*0.2446625,size.height*0.3765600);
    path0.quadraticBezierTo(size.width*0.4171625,size.height*0.3765600,size.width*0.4546625,size.height*0.3785600);
    path0.lineTo(size.width*0.4546625,size.height*0.5765600);
    path0.quadraticBezierTo(size.width*0.3778125,size.height*0.5758400,size.width*0.3482500,size.height*0.5396400);
    path0.cubicTo(size.width*0.3013750,size.height*0.4726400,size.width*0.3333250,size.height*0.4063600,size.width*0.2446625,size.height*0.3765600);
    path0.close();

    canvas.drawPath(path0, paint0);


    Paint paint1 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;


    Path path1 = Path();
    path1.moveTo(size.width*0.3457625,size.height*0.5222200);

    canvas.drawPath(path1, paint1);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
