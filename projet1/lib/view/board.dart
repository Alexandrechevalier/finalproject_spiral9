part of finalproject_spiral9;

class Board extends Surface {
  Pieces cars;
  Piece laser, mainCar;
  YellowLines yellowLines;
  AudioElement hitSound;
  int touch = 0;
  bool end;

  Board(CanvasElement canvas) {
    this.canvas = canvas;
    cars = new Cars(20);
    mainCar = new MainCar();
    yellowLines = new YellowLines(7);
    laser = new Laser();
    hitSound = document.querySelector('#${mainCar.audioId}');

    canvas.onMouseMove.listen((MouseEvent e) {
      mainCar.x = e.offset.x - mainCar.width / 2;
      mainCar.y = e.offset.y - mainCar.height / 2;
    });
    canvas.onMouseDown.listen((MouseEvent e) {
      laser.x = e.offset.x - mainCar.width / 5;
      laser.y = e.offset.y - mainCar.height;
      laser.isVisible = true;
    });

    yellowLines.forEach((YellowLine yellowLine) {
      yellowLine.space = area;
      yellowLine.x = yellowLine.space.width / 2;
    });
    yellowLines.calcY();
  }

  background() {
    context
      ..beginPath()
      ..fillRect(0, 0, width, height)
      ..closePath();
  }

  clear() {
    super.clear();
    background();
  }

  draw() {
    clear();
    drawRect(canvas, 0, 0, width, height, color: 'black', borderColor: 'red');
    if (touch >= 3) {
      return end;
    }
    yellowLines.moveDown();
    yellowLines.forEach((YellowLine yellowLine) {
      drawPiece(yellowLine);
    });

    cars.forEach((Car car) {
      if (car.isVisible) {
        car.move(Direction.DOWN);
        if (car.isSelected && (car.x < 0 || car.y < 0)) {
          car.isVisible = false;
        }
        if (!car.isSelected && mainCar.hit(car)) {
          car.isSelected = true;
          car.imgId = 'explosion';
          hitSound.load();
          hitSound.play(); 
          touch == touch++;
        } else if (!car.isSelected && laser.isVisible && laser.hit(car)) {
          car.isSelected = true;
          hitSound.load();
          hitSound.play();
          car.imgId = 'explosion';
          //laser.isVisible = false;  A voir
        }
        drawPiece(car);
      }
    });
    if (laser.isVisible) {
      laser.y = laser.y - 6;
      if (laser.y + laser.height < 0) {
        laser.isVisible = false;
      }
      drawPiece(laser);
    }
    drawPiece(mainCar);
  }
}
