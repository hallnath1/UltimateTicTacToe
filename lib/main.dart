import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        textTheme: TextTheme(
          body1: TextStyle(
              color: Color(0xFFD0D6DB)
          ),
        ),
      ),
      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}


class _HomePageState extends State<HomePage>{

  Player _oPlayer;
  List<List> _matrix;
  int _xScore;
  int _yScore;


  _HomePageState() {
    _xScore = 0;
    _yScore = 0;

      _oPlayer = new Player("Random");

    _matrix = List<List>(3);
    for (var i = 0; i < _matrix.length; i++) {
      _matrix[i] = List<String>(3);
      for (var j = 0; j < _matrix[i].length; j++) {
        _matrix[i][j] = ' ';
      }
    }
  }

  _initMatrix() {
    setState(() {
      _matrix = List<List>(3);
      for (var i = 0; i < _matrix.length; i++) {
        _matrix[i] = List<String>(3);
        for (var j = 0; j < _matrix[i].length; j++) {
          _matrix[i][j] = ' ';
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFF2E282A),
      appBar: AppBar(
        title: Text(
          'Tic Tac Toe'
        ),
      ),
      body:
        Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Global Score',
                  style: TextStyle(
                      fontSize: 50,
                      color: Color(0xFFFAD8D6),
                      fontStyle: FontStyle.italic
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'X  ',
                        style: TextStyle(
                            fontSize: 50,
                            color: Color(0xFF17BEBB)
                        ),
                      ),
                      Text(
                        '$_xScore',
                        style: TextStyle(
                            fontSize: 50
                        ),
                      ),
                      Text(
                        ' - ',
                        style: TextStyle(
                            fontSize: 50
                        ),
                      ),
                      Text(
                        '$_yScore',
                        style: TextStyle(
                            fontSize: 50
                        ),
                      ),
                      Text(
                        '  O',
                        style: TextStyle(
                            fontSize: 50,
                            color: Color(0xFFCD5334)
                        ),
                      ),
                    ],
                  )
                ),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      child: Text("2-Player"),
                      onPressed: () {
                        _oPlayer.type = "Human";
                        _initMatrix();

                      },
                    ),
                    RaisedButton(
                      child: Text("Random Player"),
                      onPressed: () {
                        _oPlayer.type = "Random";
                        _initMatrix();
                      },
                    ),
                  ],
                  alignment: MainAxisAlignment.center,
                ),
                Container(
                    height: MediaQuery.of(context).size.width * 0.1,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                    )
                ),
                _buildTTT(0, 0),
              ],
            ),
          ),

    );
  }

  String _turn = 'X';

  _buildTTT(int i, int j){
    return Column(
      children: [
      Container(
          height: MediaQuery.of(context).size.width * 0.3,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildElement(0, 0),
              _buildElement(0, 1),
              _buildElement(0, 2),
            ],
          )
      ),
      Container(
        height: MediaQuery.of(context).size.width * 0.3,
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
        _buildElement(1, 0),
        _buildElement(1, 1),
        _buildElement(1, 2),
        ],
      )
      ),
      Container(
        height: MediaQuery.of(context).size.width * 0.3,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildElement(2, 0),
              _buildElement(2, 1),
              _buildElement(2, 2),
            ],
          )
        ),
      ]
    );
  }

  _buildElement(int i, int j) {
    return GestureDetector(
      onTap: () {
        if (_matrix[i][j] == " "){
          _updateMatrixField(i, j);

          if (!_checkWin(i, j))
            if (!_checkDraw())
              _nextPlayer();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: _tttBorder(i, j),
        ),
        child: Center(
          child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width * 0.2, MediaQuery.of(context).size.width * 0.2),
              painter: IconPainter(_matrix[i][j])
          )
        )
      ),
    );
  }

  Border _tttBorder(i,j) {
    if (i == 0 && j == 0)
      return Border(
        right: BorderSide(width: 2.0, color: Color(0xFFD0D6DB)),
        bottom: BorderSide(width: 2.0, color: Color(0xFFD0D6DB))
      );
    else if (i == 0 && j == 1)
      return Border(
          left: BorderSide(width: 2.0, color: Color(0xFFD0D6DB)),
          right: BorderSide(width: 2.0, color: Color(0xFFD0D6DB)),
          bottom: BorderSide(width: 2.0, color: Color(0xFFD0D6DB))
      );
    else if (i == 0 && j == 2)
      return Border(
          left: BorderSide(width: 2.0, color: Color(0xFFD0D6DB)),
          bottom: BorderSide(width: 2.0, color: Color(0xFFD0D6DB))
      );
    else if (i == 1 && j == 0)
      return Border(
          right: BorderSide(width: 2.0, color: Color(0xFFD0D6DB)),
          top: BorderSide(width: 2.0, color: Color(0xFFD0D6DB)),
          bottom: BorderSide(width: 2.0, color: Color(0xFFD0D6DB))
      );
    else if (i == 1 && j == 1)
      return Border.all(width: 2.0, color: Color(0xFFD0D6DB));
    else if (i == 1 && j == 2)
      return Border(
          left: BorderSide(width: 2.0, color: Color(0xFFD0D6DB)),
          top: BorderSide(width: 2.0, color: Color(0xFFD0D6DB)),
          bottom: BorderSide(width: 2.0, color: Color(0xFFD0D6DB))
      );
    else if (i == 2 && j == 0)
      return Border(
          right: BorderSide(width: 2.0, color: Color(0xFFD0D6DB)),
          top: BorderSide(width: 2.0, color: Color(0xFFD0D6DB))
      );
    else if (i == 2 && j == 1)
      return Border(
          right: BorderSide(width: 2.0, color: Color(0xFFD0D6DB)),
          top: BorderSide(width: 2.0, color: Color(0xFFD0D6DB)),
          left: BorderSide(width: 2.0, color: Color(0xFFD0D6DB))
      );
    else
      return Border(
          left: BorderSide(width: 2.0, color: Color(0xFFD0D6DB)),
          top: BorderSide(width: 2.0, color: Color(0xFFD0D6DB))
      );
  }

  _updateMatrixField(int i, int j) {
    setState(() {
      if (_matrix[i][j] == ' ') {
        _matrix[i][j] = _turn;
        if (_turn == 'X')
          _turn = 'O';
        else
          _turn = 'X';
      }
    });
  }

  bool _checkDraw() {
    for (var i = 0; i < _matrix.length; i++) {
      for (var j = 0; j < _matrix[i].length; j++) {
        if (_matrix[i][j] == ' ')
          return false;
      }
    }
    _showDialog('It\'s a Draw');
    return true;

  }

  _checkWin(int x, int y) {
    var row = 0, col = 0, diag = 0, rdiag = 0;
    var n = _matrix.length - 1;
    var player = _matrix[x][y];

    for (int i = 0; i < _matrix.length; i++) {
      if (_matrix[x][i] == player)
        col++;
      if (_matrix[i][y] == player)
        row++;
      if (_matrix[i][i] == player)
        diag++;
      if (_matrix[i][n-i] == player)
        rdiag++;
    }
    if(row == n+1 || col == n+1 || diag == n+1 || rdiag == n+1 ) {
      if (player == "X")
        _xScore++;
      else
        _yScore++;
      _turn = "X";
      _showDialog('Player $player won');
      return true;
    }
    return false;
  }

  _showDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(

          title: Text('Game Over'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _initMatrix();
                },
                child: Text('Reset')
            )
          ],
        );
      }
    );
  }

  _nextPlayer(){
    List<int> x_y = _oPlayer._nextMove(_matrix);

    if (x_y != []) {
      _updateMatrixField(x_y[0], x_y[1]);
    }
    if (!_checkWin(x_y[0], x_y[1])){
      _checkDraw();
    }
  }
}

class IconPainter extends CustomPainter{
  IconPainter(this.icon);
  String icon;

  @override
  void paint(Canvas canvas, Size size) {
    if (icon == "X")
      paintX(canvas, size);
    else if(icon == "O")
      paintO(canvas, size);
  }

  @override
  bool shouldRepaint(IconPainter oldDelegate) {
    return icon != oldDelegate.icon;
  }

  paintO(Canvas canvas, Size size){
    final paint = Paint()
      ..color = Color(0xFFCD5334)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    canvas.drawCircle(Offset(size.width/2,size.height/2), size.width/2, paint);
  }
  paintX(Canvas canvas, Size size){
    final paint = Paint()
      ..color = Color(0xFF17BEBB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(size.width, 0), paint);
  }
}
/*
class StrikeThroughDecoration extends Decoration {
  StrikeThroughDecoration();
  int _xScore;
  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
    return new _StrikeThroughPainter(_xScore);
  }
}

class _StrikeThroughPainter extends BoxPainter {
  int _xScore;

  _StrikeThroughPainter(_xScore){
    this._xScore = _xScore;
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint()
      ..color = Color(0x77FAD8D6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20 + _xScore.toDouble();

    final rect = offset & configuration.size;
    canvas.drawLine(new Offset(rect.left, rect.top + rect.height / 2), new Offset(rect.right, rect.top + rect.height / 2), paint);
    canvas.restore();
  }
}*/

class Player{
  String type;

  Player(String type){
    this.type = type;
  }

  List<int> _nextMove(List<List> _matrix){
    if (type == "Random"){
      var random = Random.secure();
      int x = 0;
      int y = 0;
      do {
        x = random.nextInt(3);
        y = random.nextInt(3);
      } while (_matrix[x][y] != ' ');

      return [x, y];
    }
    return [];
  }
}