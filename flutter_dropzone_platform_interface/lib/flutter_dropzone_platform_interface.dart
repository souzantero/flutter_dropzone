import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_flutter_dropzone.dart';

enum DragOperation { copy, move, link, copyMove, copyLink, linkMove, all }

abstract class FlutterDropzonePlatform extends PlatformInterface {
  static final _token = Object();
  final events = StreamController<DropzoneEvent>.broadcast();
  static FlutterDropzonePlatform _instance = MethodChannelFlutterDropzone();

  FlutterDropzonePlatform() : super(token: _token);

  /// The default instance of [FlutterDropzonePlatform] to use.
  static FlutterDropzonePlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [FlutterDropzonePlatform] when they register themselves.
  static set instance(FlutterDropzonePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Internal function to set up the platform view.
  void init(Map<String, dynamic> params, {@required int viewId}) {
    throw UnimplementedError('init');
  }

  /// Specify the [DragOperation] while dragging the file.
  Future<bool> setOperation(DragOperation operation, {@required int viewId}) async {
    throw UnimplementedError('setOperation');
  }

  /// Specify the list of accepted MIME types.
  Future<bool> setMIME(List<String> mime, {@required int viewId}) async {
    throw UnimplementedError('setMIME');
  }

  /// Convenience function to display the browser File Open dialog.
  ///
  /// Set [multiple] to allow picking more than one file.
  /// Returns the list of files picked by the user.
  Future<List<dynamic>> pickFiles(bool multiple, {@required int viewId}) async {
    throw UnimplementedError('pickFiles');
  }

  /// Get the filename of the passed HTML file.
  Future<String> getFilename(dynamic htmlFile, {@required int viewId}) async {
    throw UnimplementedError('getFilename');
  }

  /// Get the size of the passed HTML file.
  Future<int> getFileSize(dynamic htmlFile, {@required int viewId}) async {
    throw UnimplementedError('getFileSize');
  }

  /// Get the MIME type of the passed HTML file.
  Future<String> getFileMIME(dynamic htmlFile, {@required int viewId}) async {
    throw UnimplementedError('getFileMIME');
  }

  /// Create a temporary URL to the passed HTML file.
  ///
  /// When finished, the URL should be released using [releaseFileUrl()].
  Future<String> createFileUrl(dynamic htmlFile, {@required int viewId}) async {
    throw UnimplementedError('createFileUrl');
  }

  /// Release a temporary URL previously created using [createFileUrl()].
  Future<bool> releaseFileUrl(String fileUrl, {@required int viewId}) async {
    throw UnimplementedError('releaseFileUrl');
  }

  /// Get the contents of the passed HTML file.
  Future<Uint8List> getFileData(dynamic htmlFile, {@required int viewId}) async {
    throw UnimplementedError('getFileData');
  }

  /// Event called when the dropzone view has been loaded.
  Stream<DropzoneLoadedEvent> onLoaded({@required int viewId}) {
    return events.stream //
        .where((event) => event.viewId == viewId && event is DropzoneLoadedEvent)
        .cast<DropzoneLoadedEvent>();
  }

  /// Event called if the dropzone view has an eror.
  Stream<DropzoneErrorEvent> onError({@required int viewId}) {
    return events.stream //
        .where((event) => event.viewId == viewId && event is DropzoneErrorEvent)
        .cast<DropzoneErrorEvent>();
  }

  /// Event called when the user drops a file onto the dropzone.
  Stream<DropzoneDropEvent> onDrop({@required int viewId}) {
    return events.stream //
        .where((event) => event.viewId == viewId && event is DropzoneDropEvent)
        .cast<DropzoneDropEvent>();
  }

  /// Internal function to build the platform view.
  Widget buildView(Map<String, dynamic> creationParams, Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers, PlatformViewCreatedCallback onPlatformViewCreated) {
    throw UnimplementedError('buildView');
  }

  void dispose() {
    events.close();
  }
}

class DropzoneEvent<T> {
  final int viewId;
  final T value;

  DropzoneEvent(this.viewId, [this.value]);
}

/// Event called when the dropzone view has been loaded.
class DropzoneLoadedEvent extends DropzoneEvent {
  DropzoneLoadedEvent(int viewId) : super(viewId, null);
}

/// Event called if the dropzone view has an eror.
class DropzoneErrorEvent extends DropzoneEvent<String> {
  DropzoneErrorEvent(int viewId, String error) : super(viewId, error);
}

/// Event called when the user drops a file onto the dropzone.
class DropzoneDropEvent extends DropzoneEvent<dynamic> {
  DropzoneDropEvent(int viewId, dynamic file) : super(viewId, file);
}
