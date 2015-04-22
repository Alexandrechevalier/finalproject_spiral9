part of finalproject_spiral9;


onOff(end){  
   }

class MainCar extends Piece {
  MainCar() {
    randomInit();
    width = 50;
    height = 100;
    shape = PieceShape.IMG;
    imgId = 'mainCar';
    usesVideo = false;
    audioId = 'explosionmoi';
    usesAudio = true;
  }
}

class Laser extends Piece {
  Laser() {
    randomInit();
    width = 25;
    height = 50;
    speed.dy = 6;
    shape = PieceShape.IMG;
    imgId = 'rocket';
    isVisible = false;
  }
}

class Car extends Piece {
  Car(int id) {
    this.id = id;
    width = 50;
    height = 100;
    isTagged = false;
    shape = PieceShape.IMG;
    imgId = 'car';
    x = randomNum(720);
    y = randomRangeNum(550, 2000);
    if (dy < 2) {
      dy = 2;
      y = -y;
    }
  }
}

class Cars extends Pieces {
  Cars(int count) {
    create(count);
  }

  create(int count) {
    for (var i = 1; i <= count; i++) {
      add(new Car(i));
    }
  }
}

class YellowLine extends Object with Piece {
  YellowLine nextLine;

  YellowLine(int id) {
    this.id = id;
    width = 15;
    height = 53;
    color.main = 'yellow';
    color.border = 'yellow';
    speed.dy = 4;
    shape = PieceShape.RECT;
  }

  calcY() {
    if (nextLine == null) {
      y = -height;
    } else {
      y = nextLine.y - height * 1.5;
    }
  }
}

class YellowLines extends Object with Pieces {
  YellowLines(int count) {
    create(count);
  }

  create(int count) {
    var nextLine = new YellowLine(0);
    nextLine.y = -nextLine.height;
    add(nextLine);
    for (var i = 1; i < count; i++) {
      var currentLine = new YellowLine(i);
      currentLine.nextLine = nextLine;
      nextLine = currentLine;
      add(currentLine);
    }
  }

  calcY() {
    var frontLine = firstWhere((YellowLine yl) => yl.nextLine == null);
    frontLine.y = frontLine.space.height - frontLine.height;
    for (var line in this) {
      if (line.nextLine != null) {
        line.y = line.nextLine.y - line.height * 1.5;
      }
    }
  }

  moveDown() {
    for (var line in this) {
      line.y += line.speed.dy;
      if (line.y > line.space.height) {
        line.calcY();
      }
    }
  }
}


