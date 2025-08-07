// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
// import 'package:bangladesh_finance_ekyc/feature/home/home_page/bloc/home_bloc.dart';
// import 'package:bangladesh_finance_ekyc/feature/home/home_page/bloc/home_event.dart';
// import 'package:bangladesh_finance_ekyc/feature/home/home_page/bloc/home_state.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   static Widget builder(BuildContext context) {
//     return BlocProvider<HomeBloc>(
//       create: (_) => HomeBloc()..add(LoadHomeMenuEvent()),
//       child: const HomePage(),
//     );
//   }

//   void _navigate(BuildContext context, String categoryType) {
//     Navigator.pushNamed(
//       context,
//       AppRoute.categorySelection,
//       arguments: categoryType,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorConstant.foreground,
//       appBar: AppBar(
//         title: const Text('Home'),
//         backgroundColor: ColorConstant.primary,
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: AppStyle.paddingAllMedium,
//           child: BlocBuilder<HomeBloc, HomeState>(
//             builder: (context, state) {
//               if (state is HomeLoadingState) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state is HomeLoadedState) {
//                 return Column(
//                   children: state.menuItems.map<Widget>((HomeMenuItem item) {
//                     return GestureDetector(
//                       onTap: () => _navigate(context, item.key),
//                       child: Card(
//                         elevation: 3,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         margin: const EdgeInsets.symmetric(vertical: 12),
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//                           leading: Icon(item.icon, color: ColorConstant.primary),
//                           title: Text(
//                             item.title,
//                             style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                                   color: ColorConstant.primary,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                           ),
//                           trailing: const Icon(Icons.arrow_forward_ios, size: 18),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 );
//               } else {
//                 return const Center(child: Text('Unable to load categories.'));
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
// ProductSelectionState().serviceTypeId = "I"; // or "C"
// NavigatorUtil.pushNamed(AppRoute.categorySelection, arguments: 'Islamic');

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
// import 'package:bangladesh_finance_ekyc/feature/home/home_page/bloc/home_bloc.dart';
// import 'package:bangladesh_finance_ekyc/feature/home/home_page/bloc/home_event.dart';
// import 'package:bangladesh_finance_ekyc/feature/home/home_page/bloc/home_state.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   static Widget builder(BuildContext context) {
//     return BlocProvider<HomeBloc>(
//       create: (_) => HomeBloc()..add(LoadHomeMenuEvent()),
//       child: const HomePage(),
//     );
//   }

// void _navigate(BuildContext context, String categoryType) {
//   final bloc = context.read<HomeBloc>();

//   final serviceTypeId = categoryType == 'Islamic' ? 'I' : 'C';
//   bloc.add(SaveServiceTypeEvent(serviceTypeId: serviceTypeId));

//   Navigator.pushNamed(
//     context,
//     AppRoute.categorySelection,
//     arguments: categoryType,
//   );
//   print('➡️ Navigating with categoryType: $categoryType and serviceTypeId: $serviceTypeId');
// }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         SystemNavigator.pop(); // Minimize app
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: ColorConstant.foreground,
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           leading: Container(), // Prevents back button from reappearing
//           title: const Text('Home'),
//           backgroundColor: ColorConstant.primary,
//           centerTitle: true,
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: AppStyle.paddingAllMedium,
//             child: BlocBuilder<HomeBloc, HomeState>(
//               builder: (context, state) {
//                 if (state is HomeLoadingState) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is HomeLoadedState) {
//                   return Column(
//                     children: state.menuItems.map<Widget>((HomeMenuItem item) {
//                       return GestureDetector(
//                         onTap: () => _navigate(context, item.key),
//                         child: Card(
//                           elevation: 3,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           margin: const EdgeInsets.symmetric(vertical: 12),
//                           child: ListTile(
//                             contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//                             leading: Icon(item.icon, color: ColorConstant.primary),
//                             title: Text(
//                               item.title,
//                               style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                                     color: ColorConstant.primary,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                             ),
//                             trailing: const Icon(Icons.arrow_forward_ios, size: 18),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 } else {
//                   return const Center(child: Text('Unable to load categories.'));
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';

import 'package:bangladesh_finance_ekyc/feature/home/home_page/bloc/home_bloc.dart';
import 'package:bangladesh_finance_ekyc/feature/home/home_page/bloc/home_event.dart';
import 'package:bangladesh_finance_ekyc/feature/home/home_page/bloc/home_state.dart';

import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc()..add(LoadHomeMenuEvent()),
      child: const HomePage(),
    );
  }

  void _navigate(BuildContext context, String categoryType) {
    final serviceTypeId = categoryType == 'Islamic' ? 'I' : 'C';

    // ✅ Save to global singleton state
    ProductSelectionState().setServiceTypeId(serviceTypeId);

    print('[HomePage] ✅ Selected serviceTypeId: $serviceTypeId');
    print('[HomePage] Full state: ${ProductSelectionState()}');

    Navigator.pushNamed(
      context,
      AppRoute.categorySelection,
      arguments: categoryType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop(); // Minimize app
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorConstant.foreground,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Container(), // Hide back button
          title: const Text('Home'),
          backgroundColor: ColorConstant.primary,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: AppStyle.paddingAllMedium,
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeLoadedState) {
                  return Column(
                    children: state.menuItems.map((item) {
                      return GestureDetector(
                        onTap: () => _navigate(context, item.key),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            leading: Icon(item.icon, color: ColorConstant.primary),
                            title: Text(
                              item.title,
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: ColorConstant.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return const Center(child: Text('Unable to load categories.'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

