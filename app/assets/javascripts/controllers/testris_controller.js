app.controller('TetrisController', ['$scope', '$timeout', 'highScoresAndAssociations', function($scope, $timeout, highScoresAndAssociations){
	'use_strict;'

	// --------------------
	// Private
	// --------------------

  var _currentShape = undefined;
  var _gameBoard = { gridArray: [] };
  var _gameBoardPadding = 1;
  var _idOfGameBoard = 'game-board';
  var _nextShape;
  var _rowClassName = 'tetris-row';
  var _rowsInBoard = 20;
  var _squaresPerRow = 10;
  var _squareBorderWidth = 1;
  var _squareClassName = 'square';
  var _squareMargin = 1;
  var _squareSide = 24;

  var _constructors = {
	  shapeConstructorsPrototype: {
	    pivot: function(){
	      var nextPositionCoordinates = this.coordinatesForPosition( this.centreCoordinate, this.nextPosition() );
	      if ( coordinatesValid( nextPositionCoordinates ) ){
	        resetSquaresAtCoordinates( this.coordinates );
	        this.position = this.nextPosition();
	        this.coordinates = nextPositionCoordinates;
	        changeSquaresAtCoordinates( this.css, this.coordinates, false );
	      };
	    },

	    moveDown: function(){
	      this.centreCoordinate = [this.centreCoordinate[0] - 1, this.centreCoordinate[1]];
	      this.coordinates = returnCoordinatesARowBelow( this.coordinates );
	    },

	    moveSideways: function( factor ){
	      this.centreCoordinate = [this.centreCoordinate[0], this.centreCoordinate[1] + factor];
	      this.coordinates = returnCoordinatesShiftedAColumn( this.coordinates, + factor );
	    }
	  },

	  shapeConstructors: [
	    // startingSquares go from left to right, top to bottom
	    // I
	    function IConstructor(){ 
	      this.css = "square aqua";
	      this.position = 0;
	      this.centreCoordinate = [19,4];
	      this.nextPosition = function(){ return (this.position + 1) % 2 };
	      this.coordinatesForPosition = function( centreCoordinate, position ){
	        var coordinates = [centreCoordinate];
	        var row = centreCoordinate[0];
	        var column = centreCoordinate[1];
	        // horizontal
	        if (position === 0){
	          coordinates.push([row, column - 1]);
	          coordinates.push([row, column + 1]);
	          coordinates.push([row, column + 2]);
	        // vertical
	        } else if (position === 1){
	          coordinates.push([row + 1, column]);
	          coordinates.push([row - 1, column]);
	          coordinates.push([row - 2, column]);
	        };
	        return coordinates;
	      };
	      this.coordinates = this.coordinatesForPosition( this.centreCoordinate, this.position );
	    },
	    // J
	    function JConstructor(){ 
	      this.css = "square dark-blue"; 
	      this.position = 0;
	      this.centreCoordinate = [19,4];
	      this.nextPosition = function(){ return (this.position + 1) % 4 };
	      this.coordinatesForPosition = function( centreCoordinate, position ){
	        var coordinates = [centreCoordinate];
	        var row = centreCoordinate[0];
	        var column = centreCoordinate[1];
	        // J + 270 degrees
	        if (position === 0){
	          coordinates.push([row, column - 1]);
	          coordinates.push([row, column + 1]);
	          coordinates.push([row - 1, column + 1]);
	        // J
	        } else if (position === 1){
	          coordinates.push([row + 1, column]);
	          coordinates.push([row - 1, column]);
	          coordinates.push([row - 1, column - 1]);
	        // J + 90 degrees
	        } else if (position === 2){
	          coordinates.push([row + 1, column - 1]);
	          coordinates.push([row, column - 1]);
	          coordinates.push([row, column + 1]);
	        // J + 180 degrees
	        } else if (position === 3){
	          coordinates.push([row + 1, column + 1]);
	          coordinates.push([row + 1, column]);
	          coordinates.push([row - 1, column]);
	        };
	        return coordinates;
	      };
	      this.coordinates = this.coordinatesForPosition( this.centreCoordinate, this.position );
	    }, 
	    // S
	    function SConstructor(){ 
	      this.css = "square green"; 
	      this.position = 0;
	      this.centreCoordinate = [19,4];
	      this.nextPosition = function(){ return (this.position + 1) % 2 };
	      this.coordinatesForPosition = function( centreCoordinate, position ){
	        var coordinates = [centreCoordinate];
	        var row = centreCoordinate[0];
	        var column = centreCoordinate[1];
	        // S
	        if (position === 0){
	          coordinates.push([row, column + 1]);
	          coordinates.push([row - 1, column]);
	          coordinates.push([row - 1, column - 1]);
	        // S - 90 degrees
	        } else if (position === 1){
	          coordinates.push([row + 1, column]);
	          coordinates.push([row, column + 1]);
	          coordinates.push([row - 1, column + 1]);
	        };
	        return coordinates;
	      };
	      this.coordinates = this.coordinatesForPosition( this.centreCoordinate, this.position );
	    },
	    // T
	    function TConstructor(){ 
	      this.css = "square purple"; 
	      this.position = 0;
	      this.centreCoordinate = [19,4];
	      this.nextPosition = function(){ return (this.position + 1) % 4 };
	      this.coordinatesForPosition = function( centreCoordinate, position ){
	        var coordinates = [centreCoordinate];
	        var row = centreCoordinate[0];
	        var column = centreCoordinate[1];
	        // T
	        if (position === 0){
	          coordinates.push([row, column - 1]);
	          coordinates.push([row, column + 1]);
	          coordinates.push([row - 1, column]);
	        // T + 90 degrees
	        } else if (position === 1){
	          coordinates.push([row + 1, column]);
	          coordinates.push([row, column - 1]);
	          coordinates.push([row - 1, column]);
	        // T + 180 degrees
	        } else if (position === 2){
	          coordinates.push([row + 1, column]);
	          coordinates.push([row, column - 1]);
	          coordinates.push([row, column + 1]);
	        } else if (position === 3){
	          coordinates.push([row + 1, column]);
	          coordinates.push([row, column + 1]);
	          coordinates.push([row - 1, column]);
	        };
	        return coordinates;
	      };
	      this.coordinates = this.coordinatesForPosition( this.centreCoordinate, this.position );
	    },
	    // L
	    function LConstructor(){ 
	      this.css = "square orange"; 
	      this.position = 0;
	      this.centreCoordinate = [19,4];
	      this.nextPosition = function(){ return (this.position + 1) % 4 };
	      this.coordinatesForPosition = function( centreCoordinate, position ){
	        var coordinates = [centreCoordinate];
	        var row = centreCoordinate[0];
	        var column = centreCoordinate[1];
	        // L + 90 degrees
	        if (position === 0){
	          coordinates.push([row, column - 1]);
	          coordinates.push([row, column + 1]);
	          coordinates.push([row - 1, column - 1]);
	        // L + 180 degrees
	        } else if (position === 1){
	          coordinates.push([row + 1, column - 1]);
	          coordinates.push([row + 1, column]);
	          coordinates.push([row - 1, column]);
	        // L + 270 degrees
	        } else if (position === 2){
	          coordinates.push([row + 1, column + 1]);
	          coordinates.push([row, column - 1]);
	          coordinates.push([row, column + 1]);
	        // L
	        } else if (position === 3){
	          coordinates.push([row + 1, column]);
	          coordinates.push([row - 1, column]);
	          coordinates.push([row - 1, column + 1]);
	        };
	        return coordinates;
	      };
	      this.coordinates = this.coordinatesForPosition( this.centreCoordinate, this.position );
	    },
	    // Z
	    function ZConstructor(){ 
	      this.css = "square red"; 
	      this.position = 0;
	      this.centreCoordinate = [19,4];
	      this.nextPosition = function(){ return (this.position + 1) % 2 };
	      this.coordinatesForPosition = function( centreCoordinate, position ){
	        var coordinates = [centreCoordinate];
	        var row = centreCoordinate[0];
	        var column = centreCoordinate[1];
	        // Z
	        if (position === 0){
	          coordinates.push([row, column - 1]);
	          coordinates.push([row - 1, column]);
	          coordinates.push([row - 1, column + 1]);
	        // Z + 90
	        } else if (position === 1){
	          coordinates.push([row + 1, column + 1]);
	          coordinates.push([row, column + 1]);
	          coordinates.push([row - 1, column]);
	        };
	        return coordinates;
	      };
	      this.coordinates = this.coordinatesForPosition( this.centreCoordinate, this.position );
	    },
	    // O
	    function OConstructor(){ 
	      this.css = "square yellow";
	      // This doesn't need a centreCoordinate but to make all the other code work without have to put in a whole bunch of checks, it should be here.
	      this.centreCoordinate = [19, 4];
	      this.coordinates = [[19,4],[19,5],[18,4],[18,5]];
	      // Squares don't pivot
	      this.pivot = function(){};
	    }
	  ]
  }

  function squareConstructor(){
    this.css = "square";
    this.occupied = false;
  };

  var _addRowsToBoard = function(){
    for( var i = 0; i < _rowsInBoard; i++ ){
      _gameBoard.gridArray.push([]);
    };
  };

  var _addRowsToGameBoard = function(){
    for (var i = _rowsInBoard - 1; i >= 0; i--){
      $("#game-board").append( "<div class='" + _rowClassName + "' id='" + _rowClassName + "-" + i + "'></div>" );
    };
  };

  var _addSquares = function(){
    for( var i = 0; i < _gameBoard.gridArray.length; i++ ){
      for( var s = 0; s < _squaresPerRow; s++ ){
        newSquare = new squareConstructor();
        _gameBoard.gridArray[i].push( newSquare );
      };
    };
  };

  var _addToSquareConstructorPrototype = function(){
  	squareConstructor.prototype.border = _squareBorderWidth + "px solid black";
    squareConstructor.prototype.margin = _squareMargin + "px";
  	squareConstructor.prototype.width = _squareSide + "px";
  	squareConstructor.prototype.height = _squareSide + "px";
  };

  var _addSquaresToRows = function(){
    for (var i = 0; i < _rowsInBoard; i++){
      for (var s = 0; s < _squaresPerRow; s++){
        $("#" + _rowClassName + "-" + i).append("<div class='" + _squareClassName + "' id='" + _squareClassName + "-" + i + "-" + s + "' ></div>");
      };
    };
  };

	var _init = function(){
		_setBackground();
		$("body").css({"padding-top": "30px"});
		$("#tetris-container").css({"width": "910px"});
		_setGameBoardProperties();
		_addRowsToBoard();
		_addSquares();
		_addToSquareConstructorPrototype();
		_setView();
		_nextShape = _returnRandomShape();
	};

  // Random number from 0 to largestNumber
  _randomNumber = function( largestNumber, smallestNumber ){
    var smallest = smallestNumber || 0;
    var number =  Number( (Math.random() * largestNumber).toFixed(0) );
    while (number < smallestNumber) {
      number = Number( (Math.random() * largestNumber).toFixed(0) );
    };
    return number;
  };

	var _reset = function(){
		_gameBoard.gridArray = [];
		_addRowsToBoard();
		_addSquares();
	  _currentShape = undefined;
	  _nextShape = _returnRandomShape();
		$scope.gameOver = false;
		$scope.level = 1;
		$scope.lines = 0;
		$scope.newHighScoreAchieved = false;
		$scope.newHighScoreName = "";
		$scope.score = 0;
		_setView();
	};

  var _setPropertyOfElement = function( element, property, value ){
  	$(element).css( property, value )
  };

	var _setView = function(){
		var idOfGameBoardWithHash = "#" + _idOfGameBoard;
		var squareClassWithFullStop = "." + _squareClassName;

		$("#game-board").html("");
		_addRowsToGameBoard();
		_addSquaresToRows();
  	_setPropertyOfElement( idOfGameBoardWithHash, "height", _gameBoard.height);
  	_setPropertyOfElement( idOfGameBoardWithHash, "width", _gameBoard.width);
    _setPropertyOfElement( idOfGameBoardWithHash, "padding", _gameBoardPadding);
  	_setPropertyOfElement( squareClassWithFullStop, "height", _squareSide);
    _setPropertyOfElement( squareClassWithFullStop, "margin", _squareMargin);
  	_setPropertyOfElement( squareClassWithFullStop, "width", _squareSide);

    // Setting the height for rows
    _setPropertyOfElement( "." + _rowClassName, "height", _gameBoard.rowHeight);

    // Setting the width of the container with holds the current score and new game button
    _setPropertyOfElement( ".new-game-and-current-score", "width", _gameBoard.width);

	};

	var _setBackground = function(){
		$("body").css("background", "url(http://res.cloudinary.com/digguide/image/upload/s--5XpscH8d--/v1474115296/Personal%20Site/Portflio/Tetris/smaller2.jpg)")
	};

	var _setGameBoardProperties = function(){
		_gameBoard.padding = _gameBoardPadding + "px";
    _gameBoard.height = (_gameBoardPadding * 2 + _rowsInBoard * ( _squareSide + 2 * _squareMargin )) + 2 * _squareMargin + "px";
    _gameBoard.rowsInBoard = _rowsInBoard;
    // Gotta add in the gameBoardPadding and gameBoardBorderWidth again at the end...
    _gameBoard.rowHeight = (_squareSide + 2 * _squareMargin) + "px";
    _gameBoard.squaresPerRow = _squaresPerRow;
  	_gameBoard.width = ( _gameBoardPadding * 2 + _squaresPerRow * _squareSide + 2 * _squaresPerRow * _squareMargin ) + ( 2 * _gameBoardPadding ) + "px";
	};

  // return a random shape
  var _returnRandomShape = function(){
  	var constructors = _constructors.shapeConstructors;
    var randomConstructor = constructors[_randomNumber( constructors.length - 1 )];
    randomConstructor.prototype = _constructors.shapeConstructorsPrototype;
    return new randomConstructor;
  };

	// --------------------
	// Public
	// --------------------

	$scope.gameOver = false;
	$scope.highScoresAndAssociations = highScoresAndAssociations;
	$scope.level = 1;
	$scope.lines = 0;
	$scope.newHighScoreAchieved = false;
	$scope.newHighScoreName = "";
	$scope.score = 0;
	$scope.soundOn = true;

	$scope.startNewGame = function(){
		_reset();
		_setView();
	};

	$scope.submitHighScore = function(){

	};

	$scope.toggleSound = function(){
		if ( $scope.soundOn ){
			$("#tetris-audio").prop('muted', true);
		} else {
			$("#tetris-audio").prop('muted', false);
		};
		$scope.soundOn = !$scope.soundOn;
	};

  _init();

}])