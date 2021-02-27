import 'package:flutter/material.dart';
abstract class BlocBase {
  void dispose();
}

class AddUserBlocProvider<T extends BlocBase> extends StatefulWidget {
  AddUserBlocProvider({Key key, @required this.child, @required this.bloc,}) : super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<AddUserBlocProvider<T>>();
    // AddUserBlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    AddUserBlocProvider<T> provider = context.findAncestorWidgetOfExactType();

    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<AddUserBlocProvider<BlocBase>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}