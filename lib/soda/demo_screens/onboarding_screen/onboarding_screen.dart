import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../signup_screen/signup_screen.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  final controller = PageController();
  bool isLastPage = false;
  final int total = lotty.length + 1;
  int selectedIndex = 0;
  int page = 1;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async{
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('showHome', true);
                      Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()));
                    },
                  child: const Text('Skip',style:TextStyle(fontWeight: FontWeight.w400,
                      fontSize: 18, color: Colors.black)),),
                ],
              ),
              Flexible(flex: 3,
                child: PageView.builder(
                  onPageChanged: (index){
                    setState(() {
                      isLastPage = index == 2;
                      // selectedIndex = index;
                      // page = selectedIndex + 1;
                      // print('page:$page');
                      // // print(selectedIndex);
                      // print("$index");
                    });
                  },
                  controller: controller,
                  itemCount: lotty.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index)=>Container(
                    decoration: const BoxDecoration(
                      // color: Colors.brown,
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: SizedBox(width: 400,height: 400,
                              child: Lottie.asset(lotty[index].lottie,repeat:
                              false)),
                        ),
                        const SizedBox(height:8),
                        Text(lotty[index].heading,
                            textAlign: TextAlign.center, style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w800)),
                        Text(lotty[index].subheading,
                            textAlign: TextAlign.center, style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                      ]
                    )
                  ),
                ),
              ),
              Flexible(flex: 1,
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Center(child: SmoothPageIndicator(
                      onDotClicked:(index)=>controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500), curve: Curves
                              .easeIn),
                      effect: const WormEffect(
                        dotColor: Colors.black,
                        spacing: 16,
                        activeDotColor: Colors.red,
                      ),
                      controller: controller,
                      count: lotty.length,)),
                    const SizedBox(height: 10,),
                    SizedBox(height: 50, width: 100,
                      child: isLastPage?
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          )
                        ), onPressed: ()async {
                        final prefs = await SharedPreferences
                            .getInstance();
                        prefs.setBool('showHome', true);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SignUpScreen()));

                      }, child:const Text('Get Started'),
                         //  onPressed: () {if (page == isLastPage)async{
                         //
                         //  final prefs = await SharedPreferences
                         //      .getInstance();
                         //  prefs.setBool('showHome', true);
                         //  Navigator.pushReplacement(
                         //      context,
                         //      MaterialPageRoute(
                         //          builder: (context) =>
                         //              SignUpScreen()));
                         //  }
                         //  else
                         //    controller.nextPage(duration:Duration(seconds: 1),curve: Curves.easeIn);
                         // child:const Icon( Icons.arrow_forward_ios_rounded))),
                      )
                      :ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            )
                        ), onPressed: () {
                          controller.nextPage(duration: const Duration(seconds: 1),
                              curve: Curves.easeIn);
                      }, child:const Text('Next'),
                        //  onPressed: () {if (page == isLastPage)async{
                        //
                        //  final prefs = await SharedPreferences
                        //      .getInstance();
                        //  prefs.setBool('showHome', true);
                        //  Navigator.pushReplacement(
                        //      context,
                        //      MaterialPageRoute(
                        //          builder: (context) =>
                        //              SignUpScreen()));
                        //  }
                        //  else
                        //    controller.nextPage(duration:Duration(seconds: 1),curve: Curves.easeIn);
                        // child:const Icon( Icons.arrow_forward_ios_rounded))),
                      )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Model{
  final String lottie, heading, subheading;
  Model({
    required this.lottie,
    required this.heading,
    required this.subheading});
}
final List<Model> lotty = [
Model(
    lottie:'assets/icons/108337-welcome.json',
    heading:'WELCOME TO VET',
    subheading:'A Veterinery Company that can help you with just about '
'anything pet',),
Model(lottie:'assets/icons/114223-chat-wirth-doctor.json',
      heading:'PET VACCINATION AND MORE...',
      subheading:'Set your appointment with us now \nto vaccinate your pet',),
Model(lottie:'assets/icons/115070-doctor.json',
heading:'WE ARE A PHONE DISTANCE AWAY FROM YOU',
subheading:'You can order your pet food, post a sale of your pet and '
'also find petseller around',),
];
