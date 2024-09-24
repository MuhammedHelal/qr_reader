import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:qr_reader/core/widgets/custom_screen_title.dart';
import 'package:qr_reader/features/history/presentation/manager/history_cubit/history_cubit.dart';
import 'package:qr_reader/features/history/presentation/widgets/history_listview_item.dart';
import 'package:qr_reader/features/history/presentation/widgets/history_tabbar.dart';

class HistoryViewBody extends StatelessWidget {
  const HistoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
        child: Column(
          children: [
            const CustomScreenTitle(title: 'History'),
            const Gap(16),
            const HistoryTabbar(),
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
                          if (index == state.history.length - 1) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 100),
                              child: HistoryListViewItem(item: item),
                            );
                          }
                          return HistoryListViewItem(item: item);
                        },
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
