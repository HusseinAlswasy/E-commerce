import 'package:e_commerce/modules/shop_app/login/login.dart';
import 'package:e_commerce/shared/network/local/chahe_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../shared/componenets/componentes.dart';

class switchScreen {
  String? image;
  String? title;
  String? body;

  switchScreen({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardcontroller = PageController(); // علشان التنقل تحت

  List<switchScreen> screen = [
    switchScreen(
      image: 'assets/images/e_commerce.png',
      title: 'WELCOME',
      body: 'Do You Shopping Here ',
    ),
    switchScreen(
        image: 'assets/images/order.png',
        title: 'ORDER',
        body: 'Fast Delivery'),
    switchScreen(
      image: 'assets/images/pay.png',
      title: 'PAY',
      body: 'You Can Pay With Card',
    ),
  ];
  bool isLast = false;
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value == true) {
        navigateAndFinish(
          context,
          ShopAppLogin(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            text: 'SKIP',
            function: submit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(), //to didnt give color
                controller: boardcontroller, //to move screen
                onPageChanged: (int index) {
                  if (index == screen.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                    print("Not Last");
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(screen[index]),
                itemCount: screen.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  //packege to move line on way animation
                  count: screen.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                    activeDotColor: Colors.indigo,
                  ),
                  controller: boardcontroller,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardcontroller.nextPage(
                        //move
                        duration: const Duration(
                          milliseconds: 750, //move fast betwen screen
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_rounded),
                  backgroundColor: Colors.indigo[500],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(switchScreen screen) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image(
                height: 280,
                width: 280,
                image: AssetImage(
                  '${screen.image}',
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            '${screen.title}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            '${screen.body}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      );
}
