/*
class QrDataView extends StatelessWidget {
  const QrDataView({super.key, required this.data});
  final String data;
  @override
  Widget build(BuildContext context) {
    // TODO ::
    Future.delayed(const Duration(seconds: 2), () {
      locator<HistoryCubit>().addHistory(
        HistoryItemEntity(
          data: data,
          date: DateTime.now().toString(),
        ),
      );
    });
    return Stack(
      alignment: Alignment.center,
      children: [
        const BackgroundCircles(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            color: AppColors.blackGreyish,
          ),
          child: Text(
            'Data:\n$data',
            style: const TextStyle(fontSize: 25),
          ),
        ),
      ],
    );
  }
}
*/