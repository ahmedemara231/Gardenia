import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/view/onBoarding/screen_model.dart';
import 'package:gardenia/view_model/onBoarding/cubit.dart';
import 'package:gardenia/view_model/onBoarding/states.dart';
import '../../constants/constants.dart';
import '../../modules/base_widgets/myText.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({super.key});
  
  final List<ScreenModel> onBoardingScreens =
  [
    ScreenModel(image: '1', text1: 'Search for Plants', text2: 'Discover new types plants. learn more about the plant'),
    ScreenModel(image: '2', text1: 'Save your Plants', text2: 'Use the save button to add them to you list of favorite plants'),
    ScreenModel(image: '3', text1: 'Share your Plants', text2: 'Use the save button to add them to you list of favorite plants')
  ];

  final onBoardingCont = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit,OnBoardingStates>(
      builder :(context, state) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (newPageIndex)
                  {
                    OnBoardingCubit.getInstance(context).moveToNextPage(newPageIndex);
                  },
                  controller: onBoardingCont,
                  itemBuilder: (context, index) => onBoardingScreens[index],
                  itemCount: onBoardingScreens.length,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0.h),
                child: DotsIndicator(
                  dotsCount: onBoardingScreens.length,
                  position: OnBoardingCubit.getInstance(context).pageIndex,
                  decorator: DotsDecorator(
                    size: Size(7.sp, 7.sp),
                    color: Constants.appColor, // Inactive color
                    activeColor: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: ()
                    {
                      OnBoardingCubit.getInstance(context).moveToLogin(context);
                    },
                    child: MyText(
                      text: 'Skip',
                      color: Constants.appColor,
                      fontSize: 20.sp,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: ()
                    {
                      if(OnBoardingCubit.getInstance(context).pageIndex == 2)
                        {
                          OnBoardingCubit.getInstance(context).moveToLogin(context);
                        }
                      else{
                        onBoardingCont.nextPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOutCubic
                          // curve: Curves.easeOutQuad
                        );
                      }
                    },
                    child: MyText(
                      text: 'Next',
                      color: Constants.appColor,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
