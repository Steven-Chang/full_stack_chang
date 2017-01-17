app.controller('TetrisController', ['$scope', '$timeout', 'highScoresAndAssociations', function($scope, $timeout, highScoresAndAssociations){
	'use_strict;'

	// --------------------
	// Private
	// --------------------

	var _init = function(){
		_setBackground();
		$("body").css({"padding-top": "30px"});
		$("#tetris-container").css({"width": "910px"});
	};

	var _setBackground = function(){
		$("body").css("background", "url(http://res.cloudinary.com/digguide/image/upload/s--5XpscH8d--/v1474115296/Personal%20Site/Portflio/Tetris/smaller2.jpg)")
	};

  var _gameBoardPadding = 1;
  var _idOfGameBoard = 'game-board';
  var _rowClassName = 'tetris-row';
  var _rowsInBoard = 20;
  var _squaresPerRow = 10;
  var _squareBorderWidth = 1;
  var _squareClassName = 'square';
  var _squareMargin = 1;
  var _squareSide = 24;

	// --------------------
	// Public
	// --------------------

	$scope.highScoresAndAssociations = highScoresAndAssociations;

  _init();

}])