import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final bool loading;
  final Widget child;

  const LoadingContainer({Key key, this.loading, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loading ? _loadingView : child;
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
