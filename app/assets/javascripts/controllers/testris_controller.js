app.controller('TetrisController', ['$scope', '$interval', '$timeout', 'highScoresAndAssociations', function($scope, $interval, $timeout, highScoresAndAssociations){
	'usestrict;'

	// --------------------
	// Private
	// --------------------

  var currentShape = undefined;
  var gameBoard = { gridArray: [] };
  var gameBoardPadding = 1;
  var idOfGameBoard = 'game-board';
  var intervalSpeed = 400;
  var gameInterval;
  var gameOverCounter = 0;
  var gameOverInterval;
  var nextShape;
  var rowClassName = 'tetris-row';
  var rowsInBoard = 20;
  var squaresPerRow = 10;
  var squareBorderWidth = 1;
  var squareClassName = 'square';
  var squareMargin = 1;
  var squareSide = 24;

  var constructors = {
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

  var addRowsToBoard = function(){
    for( var i = 0; i < rowsInBoard; i++ ){
      gameBoard.gridArray.push([]);
    };
  };

  var addRowsToGameBoard = function(){
    for (var i = rowsInBoard - 1; i >= 0; i--){
      $("#game-board").append( "<div class='" + rowClassName + "' id='" + rowClassName + "-" + i + "'></div>" );
    };
  };

  var addSquares = function(){
    for( var i = 0; i < gameBoard.gridArray.length; i++ ){
      for( var s = 0; s < squaresPerRow; s++ ){
        newSquare = new squareConstructor();
        gameBoard.gridArray[i].push( newSquare );
      };
    };
  };

  var addToSquareConstructorPrototype = function(){
  	squareConstructor.prototype.border = squareBorderWidth + "px solid black";
    squareConstructor.prototype.margin = squareMargin + "px";
  	squareConstructor.prototype.width = squareSide + "px";
  	squareConstructor.prototype.height = squareSide + "px";
  };

  var addSquaresToRows = function(){
    for (var i = 0; i < rowsInBoard; i++){
      for (var s = 0; s < squaresPerRow; s++){
        $("#" + rowClassName + "-" + i).append("<div class='" + squareClassName + "' id='" + squareClassName + "-" + i + "-" + s + "' ></div>");
      };
    };
  };

  var changeSquaresAtCoordinates = function( css, coordinates, occupy ){
    for (var i = 0; i < coordinates.length; i++){
      changeSquareAtCoordinate( css, coordinates[i], occupy );
    };
  };

	var changeSquareAtCoordinate = function( css, coordinate, occupy ){
    var row = coordinate[0];
    var column = coordinate[1];
    var grid = gameBoard.gridArray;
    grid[row][column].css = css;
    grid[row][column].occupied = occupy;
  };

  var changeToNextLevel = function( initialNumberOfLines ){
    if( playerReachedNextLevel( initialNumberOfLines ) ){
      intervalSpeed  = intervalSpeed - 40;
      $interval.cancel( gameInterval );
      setGameInterval();
      $scope.level = $scope.level + 1;
    };
  };

  var clearCompletedRows = function( rows ){
    var currentLinesCount = 0;
    var initialNumberOfLines = $scope.lines;
    for (var i = 0; i < rows.length; i++){
      var row = rows[i];
      if( rowComplete( row ) ){
        resetRow( row );
        $scope.lines++;
        currentLinesCount++;
      };
    };
    $scope.score += (currentLinesCount * currentLinesCount * 100);
    changeToNextLevel( initialNumberOfLines );
  };

  var coordinateOccupied = function( coordinate ){
    var grid = gameBoard.gridArray;
    var rowNumber = coordinate[0];
    var columnNumber = coordinate[1];
    return grid[rowNumber][columnNumber].occupied;
  };

  var coordinateOutOfRange = function( coordinate, rowsInBoard, squaresPerRow ){
    var rowNumber = coordinate[0];
    var columnNumber = coordinate[1];
    if ( rowNumber < 0 || rowNumber >= rowsInBoard || columnNumber < 0 || columnNumber >= squaresPerRow ){
      return true;
    };
    return false;
  };

  var coordinatesValid = function( coordinates ){
    var rowsInBoard = gameBoard.rowsInBoard;
    var squaresPerRow = gameBoard.squaresPerRow;
    for (var i = 0; i < coordinates.length; i++){
      if( coordinateOutOfRange(coordinates[i], rowsInBoard, squaresPerRow) || coordinateOccupied(coordinates[i]) ){
        return false;
      };
    };
    return true;
  };

	var init = function(){
		setBackground();
		$("#tetris").focus();
		$("#tetris").css({"padding-top": "30px"});
		$("#tetris-container").css({"width": "910px"});
		setGameBoardProperties();
		addRowsToBoard();
		addSquares();
		addToSquareConstructorPrototype();
		setView();
		nextShape = returnRandomShape();
		$scope.startNewGame();
	};

	var moveDownIfPossible = function(){
    if ( currentShape !== undefined && coordinatesValid( returnCoordinatesARowBelow( currentShape.coordinates ) ) ) {
      resetSquaresAtCoordinates( currentShape.coordinates );
      currentShape.moveDown();
      changeSquaresAtCoordinates( currentShape.css, currentShape.coordinates, false );
    };
  };

  var moveLeftIfPossible = function(){
    if ( currentShape !== undefined && coordinatesValid( returnCoordinatesShiftedAColumn( currentShape.coordinates, -1 ) ) ) {
      resetSquaresAtCoordinates( currentShape.coordinates );
      currentShape.moveSideways( -1 );
      changeSquaresAtCoordinates( currentShape.css, currentShape.coordinates, false );
    };
  };

  var moveRightIfPossible = function(){
    if ( currentShape !== undefined && coordinatesValid( returnCoordinatesShiftedAColumn( currentShape.coordinates, +1 ) ) ) {
      resetSquaresAtCoordinates( currentShape.coordinates );
      currentShape.moveSideways( +1 );
      changeSquaresAtCoordinates( currentShape.css, currentShape.coordinates, false );
    };
  };

  // Opted for this option because deleting and remaking rows requires making new squares....
  var moveUnoccupiedRowsToTheBack = function(){
  	var grid = gameBoard.gridArray;
    var newGrid = [];
    var occupied = 0;
    var unoccupied = grid.length - 1;
    for (var i = 0; i < grid.length; i++){
      if (rowEmpty( grid, i )){
        newGrid[unoccupied] = grid[i];
        unoccupied -= 1;
      } else {
        newGrid[occupied] = grid[i];
        occupied += 1;
      };
    };
    gameBoard.gridArray = newGrid;
  };

  // This needs some serious fixing lol!
  var newHighScore = function(){
  	var lowestHighScore = $scope.highScoresAndAssociations[$scope.highScoresAndAssociations.length - 1]["score"];
    return lowestHighScore < $scope.score;
  };

  // So every 8 lines the level should increase
  // gotta add initialNumberOfLines % 8 to current
  // number of lines minus initial to factor in multiple lines that can be gained per level.
  var playerReachedNextLevel = function( initialNumberOfLines ){
    return (initialNumberOfLines % 8) + $scope.lines - initialNumberOfLines >= 8;
  };

  // Random number from 0 to largestNumber
  var randomNumber = function( largestNumber, smallestNumber ){
    var smallest = smallestNumber || 0;
    var number =  Number( (Math.random() * largestNumber).toFixed(0) );
    while (number < smallestNumber) {
      number = Number( (Math.random() * largestNumber).toFixed(0) );
    };
    return number;
  };

  var renderBoard = function(){
  	var grid = gameBoard.gridArray;

    for ( var arrayIndex = 0; arrayIndex < grid.length; arrayIndex++ ) {
      for ( var squareIndex = 0; squareIndex < grid[arrayIndex].length; squareIndex++ ) {
        var square = grid[arrayIndex][squareIndex];
        $("#square-" + arrayIndex + "-" + squareIndex).attr( "class", square.css );
      };
    };
  };

  var renderGameOver = function(){
    if ( gameOverCounter % 2 === 0) {
      if ($("#game-over").length > 0){
        $("#game-over").remove();
      } else {
        $("#game-board").append("<div id='game-over'>Game Over</div>")
      };
    };
  };

  var renderNextShape = function(){
  	var shape = nextShape;
    var coordinates = shape.coordinates;

    for(var i = 0; i < coordinates.length; i++){
      var row = coordinates[i][0] - 18;
      var column = coordinates[i][1] - 3;
      $("#nps-" + row + "-" + column).attr( "class", shape.css );
    };
  };

	var reset = function(){
		gameBoard.gridArray = [];
		addRowsToBoard();
		addSquares();
	  currentShape = undefined;
	  nextShape = returnRandomShape();
		$scope.gameOver = false;
		$scope.level = 1;
		$scope.lines = 0;
		$scope.newHighScoreAchieved = false;
		$scope.newHighScoreName = "";
		$scope.score = 0;
		$interval.cancel( gameInterval );
		$interval.cancel( gameOverInterval );
	};

	var resetNextShapeSquares = function(){
    // this for loop is for the rows
    for(var r = 0; r < 2; r++){
      for(var c = 0; c < 4; c++){
        $("#nps-" + r + "-" + c).attr("class", "square");
      };
    };
  };

  var resetRow = function( rowNumber ){
  	var grid = gameBoard.gridArray;
    for (var i = 0; i < grid[rowNumber].length; i++){
      changeSquareAtCoordinate( "square", [rowNumber, i], false );
    };
  };

  // model.rowEmpty
  rowEmpty = function( grid, rowNumber ){
    for (var i = 0; i < grid[rowNumber].length; i++){
      if (grid[rowNumber][i].occupied){
        return false;
      };
    };
    return true;
  };

	var resetSquaresAtCoordinates = function( coordinates ){
    for (var i = 0; i < coordinates.length; i++){
      changeSquareAtCoordinate( "square", coordinates[i], false );
    };
  };

  // model.returnCoordinatesARowBelow
  var returnCoordinatesARowBelow = function( coordinatesArray ){
    var coordinatesARowBelow = [];
    for (var i = 0; i < coordinatesArray.length; i++){
      var row = coordinatesArray[i][0];
      var column = coordinatesArray[i][1];
      coordinatesARowBelow.push( [row - 1, column] );
    };
    return coordinatesARowBelow;
  };

	var returnCoordinatesShiftedAColumn = function( coordinates, factor ){
    var newCoordinates = [];
    for (var i = 0; i < coordinates.length; i++){
      var row = coordinates[i][0];
      var column = coordinates[i][1];
      newCoordinates.push( [row, column + factor] );
    };
    return newCoordinates;
  };

	var returnRowNumbersFromCoordinates = function( coordinates ){
    var rowNumbers = [];
    for (var i = 0; i < coordinates.length; i++){
      rowNumbers.push( coordinates[i][0] );
    };
    return rowNumbers;
  };

  var rowComplete = function(rowNumber){
  	var grid = gameBoard.gridArray;
    for (var i = 0; i < grid[rowNumber].length; i++){
      if ( !grid[rowNumber][i].occupied ){
        return false;
      };
    };
    return true;
  };

	var rowEmpty = function( grid, rowNumber ){
    for (var i = 0; i < grid[rowNumber].length; i++){
      if (grid[rowNumber][i].occupied){
        return false;
      };
    };
    return true;
  };


  var runGameOverProcess = function(){
    $scope.gameOver = true;
    // clearning interval
    // resetting the interval speed
    // then starting a new interval.
    $interval.cancel( gameInterval );
    intervalSpeed = 400;
    gameOverInterval = $interval(function(){
    	gameOverCounter++;
    	renderGameOver();
    }, intervalSpeed);
    runNewHighScoreProcess();
  };

  var runNewHighScoreProcess = function(){
    if (newHighScore()){
    	$scope.newHighScoreAchieved = true;
    };
  };

  var setGameInterval = function(){
  	gameInterval = $interval(function(){
			takeTurn();
			renderBoard();
			resetNextShapeSquares();
			renderNextShape();
		}, intervalSpeed);
  };

  var setPropertyOfElement = function( element, property, value ){
  	$(element).css( property, value )
  };

	var setView = function(){
		var idOfGameBoardWithHash = "#" + idOfGameBoard;
		var squareClassWithFullStop = "." + squareClassName;

		$("#game-board").html("");
		addRowsToGameBoard();
		addSquaresToRows();
  	setPropertyOfElement( idOfGameBoardWithHash, "height", gameBoard.height);
  	setPropertyOfElement( idOfGameBoardWithHash, "width", gameBoard.width);
    setPropertyOfElement( idOfGameBoardWithHash, "padding", gameBoardPadding);
  	setPropertyOfElement( squareClassWithFullStop, "height", squareSide);
    setPropertyOfElement( squareClassWithFullStop, "margin", squareMargin);
  	setPropertyOfElement( squareClassWithFullStop, "width", squareSide);

    // Setting the height for rows
    setPropertyOfElement( "." + rowClassName, "height", gameBoard.rowHeight);

    // Setting the width of the container with holds the current score and new game button
    setPropertyOfElement( ".new-game-and-current-score", "width", gameBoard.width);

	};

	var setBackground = function(){
		$("#tetris").css("background", "url(http://res.cloudinary.com/digguide/image/upload/s--5XpscH8d--/v1474115296/Personal%20Site/Portflio/Tetris/smaller2.jpg)")
	};

	var setGameBoardProperties = function(){
		gameBoard.padding = gameBoardPadding + "px";
    gameBoard.height = (gameBoardPadding * 2 + rowsInBoard * ( squareSide + 2 * squareMargin )) + 2 * squareMargin + "px";
    gameBoard.rowsInBoard = rowsInBoard;
    // Gotta add in the gameBoardPadding and gameBoardBorderWidth again at the end...
    gameBoard.rowHeight = (squareSide + 2 * squareMargin) + "px";
    gameBoard.squaresPerRow = squaresPerRow;
  	gameBoard.width = ( gameBoardPadding * 2 + squaresPerRow * squareSide + 2 * squaresPerRow * squareMargin ) + ( 2 * gameBoardPadding ) + "px";
	};

  // return a random shape
  var returnRandomShape = function(){
  	var shapeConstructors = constructors.shapeConstructors;
    var randomConstructor = shapeConstructors[randomNumber( shapeConstructors.length - 1 )];
    randomConstructor.prototype = constructors.shapeConstructorsPrototype;
    return new randomConstructor;
  };

  // currently we're making a new shape when there is no currentShape and setting currentShape to that
  // What we can do instead is, if there's no currentShape then make currentShape the nextShape and set nextShape to a newShape...
  var takeTurn = function(){
    var shapeCons = constructors.shapeConstructors;
    // if there's no current shape
    if ( currentShape === undefined ) {
      currentShape = nextShape;
      nextShape = returnRandomShape( shapeCons );

      // If the new piece can be placed on the gameboard
      // place piece on board
      // else
      // gameOver
      if ( coordinatesValid( currentShape.coordinates ) ){
        changeSquaresAtCoordinates( currentShape.css, currentShape.coordinates, false );
      } else {
        runGameOverProcess();
      };
    // else check if the next move is possible
    // if so, reset current squares, and move the piece down
    // and change the squares at new coordinates
    } else if ( coordinatesValid( returnCoordinatesARowBelow( currentShape.coordinates ) ) ) {
      resetSquaresAtCoordinates( currentShape.coordinates );
      currentShape.moveDown();
      changeSquaresAtCoordinates( currentShape.css, currentShape.coordinates, false );
    // current piece can't move down any further
    // clearing completed rows
    // moving those rows to the top
    // and resetting the currentShape
    } else {
      changeSquaresAtCoordinates( currentShape.css, currentShape.coordinates, true );
      clearCompletedRows( returnRowNumbersFromCoordinates(currentShape.coordinates) );
      moveUnoccupiedRowsToTheBack();
      currentShape = undefined;
    };
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

	$scope.$on('$destroy', function() {
    $interval.cancel(gameInterval);
    $interval.cancel(gameOverInterval);
  });

	$scope.processKeyDown = function($event){
    var grid = gameBoard.gridArray
    // left key
    if ( $event.keyCode === 37 ) {
    	// Currenty up to here
      moveLeftIfPossible();
      renderBoard();
      $event.preventDefault();
    // up key
    } else if ( $event.keyCode === 38 ) {
      // I think I could break down the pivot method so it does less...
      if (currentShape !== undefined){
        currentShape.pivot();
        renderBoard();
      };
      $event.preventDefault();
    // right key
    } else if ( $event.keyCode === 39 ) {
      moveRightIfPossible();
      renderBoard();
      $event.preventDefault();
    // down key
    } else if ($event.keyCode === 40 ) {
      moveDownIfPossible();
      renderBoard();
      $event.preventDefault();
    };
	};

	$scope.startNewGame = function(){
		reset();
		setView();
		gameInterval = $interval(function(){
			takeTurn();
			renderBoard();
			resetNextShapeSquares();
			renderNextShape();
		}, intervalSpeed);
	};

	$scope.submitHighScore = function(){
		$scope.newHighScoreAchieved = false;
		highScoresAndAssociations.post({
			associations: { level: $scope.level, 
											lines: $scope.lines }, 
			title: "Tetris", 
			score: $scope.score,
			name: $scope.newHighScoreName
		})
		.then(function( result ){
			$scope.highScoresAndAssociations = result;
		});
	};

	$scope.toggleSound = function(){
		if ( $scope.soundOn ){
			$("#tetris-audio").prop('muted', true);
		} else {
			$("#tetris-audio").prop('muted', false);
		};
		$scope.soundOn = !$scope.soundOn;
	};

  init();

}])