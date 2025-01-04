import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/core/base/model/base_view_model.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  const BaseView(
      {super.key,
      required this.viewModel,
      required this.onPageBuild,
      this.onDispose,
      this.onViewModelReady});
  final Widget Function(BuildContext context, T viewModel) onPageBuild;
  final T viewModel;
  final Function(T model)? onViewModelReady;
  final VoidCallback? onDispose;

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  late T viewModel;
  @override
  void initState() {
    super.initState();
    this.viewModel = Get.put(widget.viewModel);
    if (widget.onViewModelReady != null) {
      widget.onViewModelReady!(widget.viewModel);
    }
    viewModel.setContext(context);
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.onDispose != null) widget.onDispose!();
  }

  @override
  Widget build(BuildContext context) {
    return widget.onPageBuild(context, widget.viewModel);
  }
}
