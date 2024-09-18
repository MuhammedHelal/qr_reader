import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:qr_reader/core/utils/colors.dart';
import 'package:qr_reader/features/history/presentation/manager/history_cubit/history_cubit.dart';
import 'package:qr_reader/features/history/presentation/widgets/history_listview_item.dart';

class HistoryViewBody extends StatelessWidget {
  const HistoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HistoryCubit>(context);
    log('tap: ${cubit.tapIndex}');
    return SafeArea(
      child: Column(
        children: [
          const Gap(10),
          DefaultTabController(
            length: 2,
            initialIndex: cubit.tapIndex,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.blackGreyish,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TabBar(
                dividerHeight: 0,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 4),
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                tabs: const [
                  Tab(
                    text: 'Scanned',
                  ),
                  Tab(text: 'Generated'),
                ],
                onTap: (index) {
                  log('indx: $index');
                  cubit.chooseTab(index);
                },
              ),

            ),
          ),
          const Gap(10),
          Expanded(
            child: BlocBuilder<HistoryCubit, HistoryState>(
              builder: (context, state) {
                if (state is HistorySuccess) {
                  if (state.history.isEmpty) {
                    return const Center(
                      child: Text('No data'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: state.history.length,
                      itemBuilder: (context, index) {
                        final item =
                            state.history[state.history.length - index - 1];

                        return HistoryListViewItem(item: item);
                      },
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
