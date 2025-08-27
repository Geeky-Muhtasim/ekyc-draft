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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc()..add(LoadHomeMenuEvent()),
      child: const HomePage(),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _navigate(BuildContext context, String categoryType) {
    final serviceTypeId = categoryType == 'Islamic' ? 'I' : 'C';
    ProductSelectionState().setServiceTypeId(serviceTypeId);

    debugPrint('[HomePage] ✅ Selected serviceTypeId: $serviceTypeId');
    debugPrint('[HomePage] Full state: ${ProductSelectionState()}');

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
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorConstant.foreground,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Container(),
          title: const Text('Home'),
          foregroundColor: Colors.white,
          backgroundColor: ColorConstant.primary,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: AppStyle.paddingAllMedium,
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                // 🔁 If we ever find the page in Initial state (e.g., after back),
                // schedule a reload.
                if (state is HomeInitialState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      debugPrint('[HomePage] 🔁 Re-dispatching LoadHomeMenuEvent (back nav)');
                      context.read<HomeBloc>().add(LoadHomeMenuEvent());
                    }
                  });
                  return const Center(child: CircularProgressIndicator());
                }

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
                } else if (state is HomeErrorState) {
                  return Center(child: Text(state.message));
                }

                // Fallback (should rarely happen)
                return const Center(child: Text('Unable to load categories.'));
              },
            ),
          ),
        ),
      ),
    );
  }
}
