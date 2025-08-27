// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';

// import 'package:bangladesh_finance_ekyc/model/branch_model.dart';
// import '../bloc/product_apply_bloc.dart';
// import '../bloc/product_apply_event.dart';
// import '../bloc/product_apply_state.dart';

// class ProductApplyPage extends StatelessWidget {
//   const ProductApplyPage({super.key});

//   static Widget builder(BuildContext context) {
//     return BlocProvider(
//       create: (_) => ProductApplyBloc()..add(ProductApplyStarted()),
//       child: const ProductApplyPage(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ProductApplyBloc, ProductApplyState>(
//       listenWhen: (prev, curr) =>
//           prev.submitSuccess != curr.submitSuccess ||
//           prev.errorMessage != curr.errorMessage,
//       listener: (context, state) {
//         if (state.submitSuccess) {
//           Navigator.pushNamed(context, AppRoute.mobileNo);
//         } else if (state.errorMessage != null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.errorMessage!)),
//           );
//         }
//       },
//       child: Scaffold(
//         backgroundColor: ColorConstant.foreground,
//         appBar: AppBar(
//           title: BlocBuilder<ProductApplyBloc, ProductApplyState>(
//             buildWhen: (p, c) => p.isFixed != c.isFixed,
//             builder: (context, state) {
//               final title = state.isFixed
//                   ? 'Fixed Deposit – Apply'
//                   : 'Monthly Deposit – Apply';
//               return Text(title, style: const TextStyle(fontWeight: FontWeight.bold));
//             },
//           ),
//           centerTitle: true,
//           backgroundColor: ColorConstant.primary,
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: AppStyle.paddingAllMedium,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 BlocBuilder<ProductApplyBloc, ProductApplyState>(
//                   builder: (context, state) {
//                     final txt = state.isFixed
//                         ? 'Select a branch, enter deposit amount. Tenure is fixed by product name when available.'
//                         : 'Select a branch, choose payment option, enter amount, and select tenure.';
//                     return Text(
//                       txt,
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyMedium
//                           ?.copyWith(color: Colors.black87),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 16),

//                 // -------- Branch Dropdown ----------
//                 const _BranchDropdown(),
//                 const SizedBox(height: 20),

//                 // -------- Body (fixed/monthly) -----
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         BlocBuilder<ProductApplyBloc, ProductApplyState>(
//                           buildWhen: (p, c) =>
//                               p.isFixed != c.isFixed || p.monthlyMode != c.monthlyMode,
//                           builder: (context, state) {
//                             if (state.isFixed) {
//                               return const _FixedForm();
//                             }
//                             return const _MonthlyForm();
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // -------- Actions ------------------
//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () => Navigator.pop(context),
//                         style: OutlinedButton.styleFrom(
//                           side: const BorderSide(color: ColorConstant.primary),
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                         ),
//                         child: const Text(
//                           'Back',
//                           style: TextStyle(
//                             color: ColorConstant.primary,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: BlocBuilder<ProductApplyBloc, ProductApplyState>(
//                         buildWhen: (p, c) =>
//                             p.isSubmitting != c.isSubmitting || p.isValid != c.isValid,
//                         builder: (context, state) {
//                           return ElevatedButton(
//                             onPressed: state.isSubmitting
//                                 ? null
//                                 : () => context.read<ProductApplyBloc>().add(SubmitPressed()),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: ColorConstant.primary,
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(14),
//                               ),
//                             ),
//                             child: state.isSubmitting
//                                 ? const SizedBox(
//                                     height: 20,
//                                     width: 20,
//                                     child: CircularProgressIndicator(),
//                                   )
//                                 : const Text(
//                                     'Continue',
//                                     style: TextStyle(color: Colors.white, fontSize: 16),
//                                   ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Branch dropdown with loading + retry
// class _BranchDropdown extends StatelessWidget {
//   const _BranchDropdown({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductApplyBloc, ProductApplyState>(
//       buildWhen: (p, c) =>
//           p.isBranchesLoading != c.isBranchesLoading ||
//           p.branchesError != c.branchesError ||
//           p.branches != c.branches ||
//           p.selectedBranch != c.selectedBranch,
//       builder: (context, state) {
//         if (state.isBranchesLoading) {
//           return Container(
//             padding: const EdgeInsets.symmetric(vertical: 12),
//             child: const Row(
//               children: [
//                 SizedBox(
//                   width: 18, height: 18,
//                   child: CircularProgressIndicator(strokeWidth: 2),
//                 ),
//                 SizedBox(width: 10),
//                 Text('Loading branches...'),
//               ],
//             ),
//           );
//         }

//         if (state.branchesError != null) {
//           return Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   state.branchesError!,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () => context.read<ProductApplyBloc>().add(FetchBranches()),
//                 child: const Text('Retry'),
//               ),
//             ],
//           );
//         }

//         final items = state.branches
//             .map((b) => DropdownMenuItem<Branch>(
//                   value: b,
//                   child: Text(b.branchName, overflow: TextOverflow.ellipsis),
//                 ))
//             .toList();

//         return DropdownButtonFormField<Branch>(
//           value: state.selectedBranch,
//           decoration: InputDecoration(
//             labelText: 'Select Branch',
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//             contentPadding: AppStyle.paddingAllSmall,
//           ),
//           items: items,
//           onChanged: (b) {
//             if (b != null) {
//               context.read<ProductApplyBloc>().add(BranchSelected(b));
//             }
//           },
//         );
//       },
//     );
//   }
// }

// /// ----- Fixed: Amount + (Tenure badge if locked; dropdown if not)
// class _FixedForm extends StatelessWidget {
//   const _FixedForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bloc = context.read<ProductApplyBloc>();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const _AmountField(label: 'Amount'),
//         const SizedBox(height: 16),
//         BlocBuilder<ProductApplyBloc, ProductApplyState>(
//           buildWhen: (p, c) =>
//               p.tenureLocked != c.tenureLocked || p.tenureMonths != c.tenureMonths,
//           builder: (context, state) {
//             if (state.tenureLocked) {
//               return _LockedTenureBadge(months: state.tenureMonths);
//             }
//             return _TenureDropdown(onChanged: (m) => bloc.add(TenureChanged(m)));
//           },
//         ),
//       ],
//     );
//   }
// }

// /// ----- Monthly: Mode dropdown + Amount + Tenure dropdown (always editable)
// class _MonthlyForm extends StatelessWidget {
//   const _MonthlyForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bloc = context.read<ProductApplyBloc>();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         BlocBuilder<ProductApplyBloc, ProductApplyState>(
//           buildWhen: (p, c) => p.monthlyMode != c.monthlyMode,
//           builder: (context, state) {
//             return DropdownButtonFormField<String>(
//               value: state.monthlyMode,
//               decoration: InputDecoration(
//                 labelText: 'Payment option',
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                 contentPadding: AppStyle.paddingAllSmall,
//               ),
//               items: const [
//                 DropdownMenuItem(value: 'on_time', child: Text('On time')),
//                 DropdownMenuItem(value: 'installment', child: Text('On installment')),
//               ],
//               onChanged: (v) => bloc.add(MonthlyModeChanged(v ?? 'on_time')),
//             );
//           },
//         ),
//         const SizedBox(height: 16),

//         BlocBuilder<ProductApplyBloc, ProductApplyState>(
//           buildWhen: (p, c) => p.monthlyMode != c.monthlyMode || p.amountText != c.amountText,
//           builder: (context, state) {
//             return _AmountField(
//               key: ValueKey('amount-${state.monthlyMode}-${state.amountText.hashCode}'),
//               label: state.monthlyMode == 'on_time'
//                   ? 'Principal amount'
//                   : 'Installment amount',
//             );
//           },
//         ),
//         const SizedBox(height: 16),

//         // Monthly deposits always show tenure dropdown (never locked)
//         _TenureDropdown(onChanged: (m) => bloc.add(TenureChanged(m))),
//       ],
//     );
//   }
// }

// /// ----- Amount field (shared)
// class _AmountField extends StatelessWidget {
//   final String label;
//   const _AmountField({super.key, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductApplyBloc, ProductApplyState>(
//       buildWhen: (p, c) => p.amountText != c.amountText,
//       builder: (context, state) {
//         return TextFormField(
//           initialValue: state.amountText,
//           onChanged: (v) => context.read<ProductApplyBloc>().add(AmountChanged(v)),
//           keyboardType: TextInputType.number,
//           inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
//           decoration: InputDecoration(
//             labelText: label,
//             hintText: 'Enter amount',
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//             contentPadding: AppStyle.paddingAllSmall,
//             prefixIcon: const Icon(Icons.currency_exchange, color: ColorConstant.primary),
//           ),
//         );
//       },
//     );
//   }
// }

// /// ----- Tenure dropdown (shared)
// class _TenureDropdown extends StatelessWidget {
//   final Function(int) onChanged;
//   const _TenureDropdown({super.key, required this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductApplyBloc, ProductApplyState>(
//       buildWhen: (p, c) => p.tenureMonths != c.tenureMonths,
//       builder: (context, state) {
//         return DropdownButtonFormField<int>(
//           value: state.tenureMonths,
//           decoration: InputDecoration(
//             labelText: 'Tenure (months)',
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//             contentPadding: AppStyle.paddingAllSmall,
//           ),
//           items: state.tenureOptions
//               .map((m) => DropdownMenuItem<int>(value: m, child: Text('$m Months')))
//               .toList(),
//           onChanged: (val) {
//             if (val != null) onChanged(val);
//           },
//         );
//       },
//     );
//   }
// }

// /// ----- Read-only badge when tenure is locked (Fixed only)
// class _LockedTenureBadge extends StatelessWidget {
//   final int months;
//   const _LockedTenureBadge({super.key, required this.months});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.lock_clock, size: 20, color: ColorConstant.primary),
//           const SizedBox(width: 8),
//           Text(
//             'Tenure: $months Months',
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//         ],
//       ),
//     );
//   }
// }
// lib/feature/home/product_apply/view/product_apply_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';
import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';

import 'package:bangladesh_finance_ekyc/model/branch_model.dart';
import '../bloc/product_apply_bloc.dart';
import '../bloc/product_apply_event.dart';
import '../bloc/product_apply_state.dart';

class ProductApplyPage extends StatelessWidget {
  const ProductApplyPage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductApplyBloc()..add(ProductApplyStarted()),
      child: const ProductApplyPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductApplyBloc, ProductApplyState>(
      listenWhen: (prev, curr) =>
          prev.submitSuccess != curr.submitSuccess ||
          prev.errorMessage != curr.errorMessage,
      listener: (context, state) {
        if (state.submitSuccess) {
          Navigator.pushNamed(context, AppRoute.mobileNo);
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstant.foreground,
        
        appBar: AppBar(
          title: Text(
            ProductSelectionState().productName ?? 'Apply',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: ColorConstant.primary,
          foregroundColor: Colors.white, // makes back icon white
          
        ),
        body: SafeArea(
          child: Padding(
            padding: AppStyle.paddingAllMedium,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<ProductApplyBloc, ProductApplyState>(
                  builder: (context, state) {
                    final txt = state.isFixed
                        ? 'Select a branch, enter deposit amount. Tenure is fixed by product name when available.'
                        : 'Select a branch, choose payment option, enter amount, and select tenure.';
                    return Text(
                      txt,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.black87),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // -------- Branch Dropdown ----------
                const _BranchDropdown(),
                const SizedBox(height: 20),

                // -------- Body (fixed/monthly) -----
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        BlocBuilder<ProductApplyBloc, ProductApplyState>(
                          buildWhen: (p, c) =>
                              p.isFixed != c.isFixed ||
                              p.monthlyMode != c.monthlyMode,
                          builder: (context, state) {
                            if (state.isFixed) {
                              return const _FixedForm();
                            }
                            return const _MonthlyForm();
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // -------- Actions ------------------
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: ColorConstant.primary),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            color: ColorConstant.primary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: BlocBuilder<ProductApplyBloc, ProductApplyState>(
                        buildWhen: (p, c) =>
                            p.isSubmitting != c.isSubmitting ||
                            p.isValid != c.isValid,
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: state.isSubmitting
                                ? null
                                : () => context.read<ProductApplyBloc>().add(
                                    SubmitPressed(),
                                  ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: state.isSubmitting
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text(
                                    'Continue',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Branch dropdown with loading + retry
class _BranchDropdown extends StatelessWidget {
  const _BranchDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductApplyBloc, ProductApplyState>(
      buildWhen: (p, c) =>
          p.isBranchesLoading != c.isBranchesLoading ||
          p.branchesError != c.branchesError ||
          p.branches != c.branches ||
          p.selectedBranch != c.selectedBranch,
      builder: (context, state) {
        if (state.isBranchesLoading) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: const Row(
              children: [
                SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 10),
                Text('Loading branches...'),
              ],
            ),
          );
        }

        if (state.branchesError != null) {
          return Row(
            children: [
              Expanded(
                child: Text(
                  state.branchesError!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () =>
                    context.read<ProductApplyBloc>().add(FetchBranches()),
                child: const Text('Retry'),
              ),
            ],
          );
        }

        final items = state.branches
            .map(
              (b) => DropdownMenuItem<Branch>(
                value: b,
                child: Text(b.branchName, overflow: TextOverflow.ellipsis),
              ),
            )
            .toList();

        return DropdownButtonFormField<Branch>(
          value: state.selectedBranch,
          decoration: InputDecoration(
            labelText: 'Select Branch',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: AppStyle.paddingAllSmall,
          ),
          items: items,
          onChanged: (b) {
            if (b != null) {
              context.read<ProductApplyBloc>().add(BranchSelected(b));
            }
          },
        );
      },
    );
  }
}

/// ----- Fixed: Amount + (Tenure badge if locked; dropdown if not)
class _FixedForm extends StatelessWidget {
  const _FixedForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductApplyBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stable, stateful amount field (no rebuild on each keystroke)
        const _AmountField(label: 'Amount'),
        const SizedBox(height: 16),
        BlocBuilder<ProductApplyBloc, ProductApplyState>(
          buildWhen: (p, c) =>
              p.tenureLocked != c.tenureLocked ||
              p.tenureMonths != c.tenureMonths,
          builder: (context, state) {
            if (state.tenureLocked) {
              return _LockedTenureBadge(months: state.tenureMonths);
            }
            return _TenureDropdown(
              onChanged: (m) => bloc.add(TenureChanged(m)),
            );
          },
        ),
      ],
    );
  }
}

/// ----- Monthly: Mode dropdown + (Stable) Amount + Tenure dropdown
class _MonthlyForm extends StatelessWidget {
  const _MonthlyForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductApplyBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ProductApplyBloc, ProductApplyState>(
          buildWhen: (p, c) => p.monthlyMode != c.monthlyMode,
          builder: (context, state) {
            return DropdownButtonFormField<String>(
              value: state.monthlyMode,
              decoration: InputDecoration(
                labelText: 'Payment option',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: AppStyle.paddingAllSmall,
              ),
              items: const [
                DropdownMenuItem(value: 'on_time', child: Text('On time')),
                DropdownMenuItem(
                  value: 'installment',
                  child: Text('On installment'),
                ),
              ],
              onChanged: (v) => bloc.add(MonthlyModeChanged(v ?? 'on_time')),
            );
          },
        ),
        const SizedBox(height: 16),

        // IMPORTANT: Only rebuild this when monthlyMode changes (for label),
        // and keep a stable controller so the keyboard stays up while typing.
        BlocBuilder<ProductApplyBloc, ProductApplyState>(
          buildWhen: (p, c) => p.monthlyMode != c.monthlyMode,
          builder: (context, state) {
            final label = state.monthlyMode == 'on_time'
                ? 'Principal amount'
                : 'Installment amount';
            // Change the key only when the MODE changes (not on amount changes).
            return _AmountField(
              key: ValueKey('amount-field-${state.monthlyMode}'),
              label: label,
            );
          },
        ),
        const SizedBox(height: 16),

        // Monthly deposits always show tenure dropdown (never locked)
        _TenureDropdown(onChanged: (m) => bloc.add(TenureChanged(m))),
      ],
    );
  }
}

/// ----- Amount field (STATEFUL; keeps controller & focus stable)
class _AmountField extends StatefulWidget {
  final String label;
  const _AmountField({super.key, required this.label});

  @override
  State<_AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<_AmountField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant _AmountField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // When the monthly MODE changes (key changes), the widget is recreated with a new key,
    // so controller is fresh; we ensure the field starts empty (your bloc also resets amountText).
    if (oldWidget.label != widget.label) {
      // Optional: clear when label changes (mode changed)
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      onChanged: (v) => context.read<ProductApplyBloc>().add(AmountChanged(v)),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: 'Enter amount',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: AppStyle.paddingAllSmall,
        prefixIcon: const Icon(
          Icons.currency_exchange,
          color: ColorConstant.primary,
        ),
      ),
    );
  }
}

/// ----- Tenure dropdown (shared)
class _TenureDropdown extends StatelessWidget {
  final Function(int) onChanged;
  const _TenureDropdown({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductApplyBloc, ProductApplyState>(
      buildWhen: (p, c) => p.tenureMonths != c.tenureMonths,
      builder: (context, state) {
        return DropdownButtonFormField<int>(
          value: state.tenureMonths,
          decoration: InputDecoration(
            labelText: 'Tenure (months)',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: AppStyle.paddingAllSmall,
          ),
          items: state.tenureOptions
              .map(
                (m) =>
                    DropdownMenuItem<int>(value: m, child: Text('$m Months')),
              )
              .toList(),
          onChanged: (val) {
            if (val != null) onChanged(val);
          },
        );
      },
    );
  }
}

/// ----- Read-only badge when tenure is locked (Fixed only)
class _LockedTenureBadge extends StatelessWidget {
  final int months;
  const _LockedTenureBadge({super.key, required this.months});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock_clock, size: 20, color: ColorConstant.primary),
          const SizedBox(width: 8),
          Text(
            'Tenure: $months Months',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
