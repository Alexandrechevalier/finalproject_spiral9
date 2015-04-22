// Copyright (c) 2015, <Denice B Johansson>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:memory_final/memory_final.dart';

void main() {
  CanvasElement canvas = querySelector('#canvas');
  ButtonElement play = querySelector('#play');
  play.onClick.listen((Event e) {
    window.location.reload();
  });
  new Board(canvas, new Memory(4));
}
