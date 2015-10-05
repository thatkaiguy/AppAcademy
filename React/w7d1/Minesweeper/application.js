
var MineSweeperGameComponent = React.createClass({
  getInitialState: function () {
    return {
        board: new Minesweeper.Board(9, 10),
        isOver: false,
        isWon: false
    }
  },

  updateGame: function (position, flagged) {
    if (flagged) {
      this.state.board.grid[position[0]][position[1]].toggleFlag();
    } else {
      this.state.board.grid[position[0]][position[1]].explore();
    }

    this.setState({
      isWon: this.state.board.won(),
      isOver: this.state.board.won() || this.state.board.lost()
    })
  },

  restartGame: function () {
    this.setState({
      board: new Minesweeper.Board(9, 10),
      isOver: false,
      isWon: false
    });
  },

  render: function () {
    var endMsg = '';
    if (this.state.isWon) {
      endMsg = (
        <div>
          <p>"You have won!"</p>
          <button onClick={ this.restartGame }>Restart</button>
        </div>
      )
    } else if (this.state.isOver) {
      endMsg = (
        <div>
          <p>"You have lost!"</p>
          <button onClick={ this.restartGame }>Restart</button>
        </div>
      )
    }
    return(
      <div>
        <BoardComponent board={ this.state.board } updateGame={ this.updateGame } />
        { endMsg }
      </div>
    )
  }
});

var BoardComponent = React.createClass({
  render: function () {
    return (
      <div>
        {
          this.props.board.grid.map(function(row, i){
            return <RowComponent tiles={ row } row={ i } updateGame={this.props.updateGame}/>
          }.bind(this))
        }
      </div>
    )
  }
});

var RowComponent = React.createClass({
  render : function () {
    return (
      <div>
        {
          this.props.tiles.map(function(tile, index){
              return <TileComponent
                tile={ tile }
                position={ [this.props.row, index] }
                updateGame={ this.props.updateGame }/>
          }.bind(this))
        }
      </div>
    )
  }
});

var TileComponent = React.createClass({
  handleClick: function(event){
    event.preventDefault();
    // this.props.tile.explore();
    this.props.updateGame(this.props.position, false)
  },

  render: function () {
    var tile = this.props.tile;
    if (tile.explored) {
      if (tile.bombed) {
        return <span onClick={this.handleClick} className="tile bombed"> B </span>
      } else {
        return <span onClick={this.handleClick} className="tile revealed"> { tile.adjacentBombCount() } </span>
      }
    } else if (tile.flagged) {
      return <span onClick={this.handleClick} className="tile flagged"> F </span>
    } else {
      return <span onClick={this.handleClick} className="tile"> ▀ </span>
    }
  }
});

React.render(
  <MineSweeperGameComponent />,
  document.getElementById('minesweeper')
);
