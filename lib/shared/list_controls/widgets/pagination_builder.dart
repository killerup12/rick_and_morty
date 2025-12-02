part of '../list_controls.dart';

class PaginationBuilder extends StatefulWidget {
  const PaginationBuilder({
    this.scrollThreshold = 0.3,
    this.onRefresh,
    this.onPaginate,
    this.uploadCondition,
    this.controller,
    required this.builder,
    super.key,
  });

  final double scrollThreshold;
  final Future Function()? onRefresh;
  final Future Function()? onPaginate;
  final bool Function()? uploadCondition;
  final ScrollController? controller;
  final Widget Function(BuildContext context, ScrollController controller) builder;

  @override
  State<PaginationBuilder> createState() => _PaginationBuilderState();
}

class _PaginationBuilderState extends State<PaginationBuilder> {
  var _isLoadingMore = false;
  ScrollController? _scrollController;
  ScrollController get _effectiveScrollController => widget.controller ?? (_scrollController ??= ScrollController());

  bool _isRefreshing = false;
  async.Timer? _loadMoreTimer;

  double? axisLength;

  @override
  void initState() {
    _effectiveScrollController.addListener(() async {
      if (_isRefreshing || _isLoadingMore) return;

      _loadMoreTimer?.cancel();

      _loadMoreTimer = async.Timer(const Duration(milliseconds: 15), () async {
        if (!context.mounted) return;
        if (!(widget.uploadCondition?.call() ?? false)) return;
        if (_effectiveScrollController.position.pixels < 0) return;
        if (_effectiveScrollController.position.pixels + (axisLength ?? 0) <
            _effectiveScrollController.position.maxScrollExtent)
          return;

        _isLoadingMore = true;
        try {
          await widget.onPaginate?.call();
        } finally {
          if (!mounted) return;
          WidgetsBinding.instance.addPostFrameCallback((_) => _isLoadingMore = false);
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.dispose();

    _loadMoreTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    axisLength = size.height * widget.scrollThreshold;

    return RefreshIndicator(
      onRefresh: () async {
        if (widget.onRefresh == null) return;

        try {
          _isRefreshing = true;
          await widget.onRefresh!();
        } finally {
          _isRefreshing = false;
        }
      },
      child: Builder(builder: (context) => widget.builder(context, _effectiveScrollController)),
    );
  }
}
