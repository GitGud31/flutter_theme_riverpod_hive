import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class L {
  static void log(dynamic msg) {
    final Logger logger = Logger();
    logger.log(Level.debug, msg);
  }
}

class ProvidersLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    //super.didAddProvider(provider, value, container);

    L.log('''
    {
      "provider": "${provider.name ?? provider.runtimeType}",
      "value": "$value",
      "container: "$container"
    }''');
  }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    L.log('''
    {
      "provider": "${provider.name ?? provider.runtimeType}",
      "newValue": "$newValue"
    }''');
  }

  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer container,
  ) {
    //super.didDisposeProvider(provider, containers);

    L.log('''
    {
      "provider": "${provider.name ?? provider.runtimeType}",
      "containers": "$container"
    }''');
  }
}
