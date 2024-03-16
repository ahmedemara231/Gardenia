import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/modules/myText.dart';
import 'package:gardenia/modules/textFormField.dart';

class Categories extends StatelessWidget {
  Categories({super.key});

  final searchCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            title: MyText(
              text: 'Categories',
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Constants.appColor,
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: const CircleAvatar(
                  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSKu_Had8DMwqdwykhzm6vCDJIUHYfEtnoJw&usqp=CAU'),
                ),
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 10.w
                    ),
                    child: Container(
                      height: 45.h,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          color: Constants.appColor,
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: TFF(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                        obscureText: false,
                        controller: searchCont,
                        hintText: 'Search',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.white70,
                        ),
                        prefixIcon: const Icon(Icons.search,color: Colors.grey,),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                    child: TabBar(
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.black87,
                        tabs:  [
                          Tab(
                            child: MyText(text: 'All',color: Constants.appColor,fontSize: 12.sp,fontWeight: FontWeight.bold,),
                          ),
                          Tab(
                            child: MyText(text: 'Indoor',color: Constants.appColor,fontSize: 12.sp,fontWeight: FontWeight.bold,),
                          ),
                          Tab(
                            child: MyText(text: 'Outdoor',color: Constants.appColor,fontSize: 12.sp,fontWeight: FontWeight.bold,),
                          ),
                          Tab(
                            child: MyText(text: 'Garden',color: Constants.appColor,fontSize: 12.sp,fontWeight: FontWeight.bold,),
                          ),
                          Tab(
                            child: MyText(text: 'office',color: Constants.appColor,fontSize: 12.sp,fontWeight: FontWeight.bold,),
                          ),
                        ],
                    ),
                  ),
                  SizedBox(
                    height: context.setHeight(3/1.7),
                    child: TabBarView(
                      children:
                      [
                        ListView(
                          children: [
                            SizedBox(
                              height: 200,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Card(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12.0.h,horizontal: 16.w),
                                    child: Column(
                                      children: [
                                        Expanded(child: Image.asset('images/plant1.png')),
                                        MyText(
                                          text: 'Plant Name',
                                          color: Constants.appColor,
                                          fontWeight: FontWeight.bold,fontSize: 13.sp,
                                        ),
                                        MyText(
                                            text: 'Type',
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                                itemCount: 5,
                              ),
                            ),
                            SizedBox(height: 16.h,),
                            SizedBox(
                              height: context.setHeight(6),
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Card(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12.0.h,horizontal: 16.w),
                                    child: Column(
                                      children: [
                                        Expanded(child: Image.asset('images/plant1.png')),
                                        MyText(
                                          text: 'Plant Name',
                                          color: Constants.appColor,
                                          fontWeight: FontWeight.bold,fontSize: 13.sp,
                                        ),
                                        MyText(
                                            text: 'Type',
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                                itemCount: 5,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0.h),
                              child: Row(
                                children: [
                                  MyText(
                                      text: 'Popular',
                                      color: Constants.appColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold
                                  ),
                                  const Spacer(),
                                  TextButton(
                                      onPressed: () {},
                                      child: MyText(
                                          text: 'See all',
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold
                                      ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: context.setHeight(6),
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {},
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 12.0.h,horizontal: 16.w),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                                            child: Image.asset('images/plant1.png'),
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              MyText(
                                                text: 'Plant Name',
                                                color: Constants.appColor,
                                                fontWeight: FontWeight.bold,fontSize: 13.sp,
                                              ),
                                              MyText(
                                                  text: 'Type',
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                                itemCount: 5,
                              ),
                            ),
                          ],
                        ),
                        MyText(text: 'mohamed'),
                        MyText(text: 'ahmed'),
                        MyText(text: 'y'),
                        MyText(text: 'emara'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
