import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: 'Statistics',),
        leading: const AppBarBackButton(),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          StatisticModel(label: 'sold out',value: 22,),
          StatisticModel(label: 'item count',value: 12,),
          StatisticModel(label: 'total balance',value: 1222.0,),
          SizedBox(height: 20,)
        ],),
      ),
    );
  }
}

class StatisticModel extends StatelessWidget {
  final String label;
  final dynamic value;
  const StatisticModel({
    super.key, required this.label, required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width*0.55,
            decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)
                  )
              ),
            child: Center(child: Text(label.toUpperCase(),style: const TextStyle(color: Colors.white,fontSize: 20),)),
          ),
          Container(
            height: 90,
            width: MediaQuery.of(context).size.width*0.7,
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)
                  )
              ),
            child: AnimatedCounter(count: value),
          )
    ],);
  }
}

class AnimatedCounter extends StatefulWidget {
  final dynamic count;
  const AnimatedCounter({super.key, required this.count});

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter> with TickerProviderStateMixin{

  late AnimationController _controller;
  late Animation _animation;

  //? this section customises the animation
  @override
  void initState() {
    _controller = AnimationController(vsync: this,duration: const Duration(seconds: 1));
    _animation = _controller;
    setState(() {
      _animation = Tween(begin: _animation.value,end: widget.count).animate(_controller); // "end: widget.count" last number //? reason we do "widget.count." instead of "count." is beacause we are inside a stf,
    });
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation, // AKA Tween(begin: _animation.value,end: widget.count).animate(_controller);
      builder: (context, child) {
        return  Center(
                child: Text(_animation.value.toStringAsFixed(2), 
                  style: const TextStyle(
                      color: Colors.pink,
                      fontSize: 40,
                      fontFamily: 'Acme',
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold
                      ),
            )
          );
      },
    );
  }
}