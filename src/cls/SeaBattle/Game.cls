Class SeaBattle.Game
{

Parameter BoardRange = 5;

Parameter Rounds = 5;

ClassMethod Run() As %Status
{
   do ..SetupGame() 
    for i=1:1:..#Rounds {
        WRITE !,"Round ",i
        READ !,"Please enter x:",x
        READ !,"And y:",y
        do ..HitBoard(x,y)
        do ..PrintBoard()
        if ..CheckShip(x,y) {
            WRITE !,"You sunk the ship!"
            QUIT 
        }
        
        READ !,"You missed. Try again",x
    }
}

ClassMethod HitBoard(x, y) As %Status
{
    set ^Board(x,y)="X"
}

ClassMethod CheckShip(x, y) As %Boolean
{
    if $D(^Ships(x,y)) return 1
    return 0
}

ClassMethod SetupGame() As %Status
{
    k ^Board
    for x=1:1:..#BoardRange {
        for y=1:1:..#BoardRange {
            set ^Board(x,y)="O"
        }
    }
    Do ..HideShip()
}

ClassMethod HideShip() As %Status
{
    kill ^Ships
    Set ^Ships($RANDOM(..#BoardRange)+1,$RANDOM(..#BoardRange)+1)=""
    #; zw ^Ships
}

ClassMethod PrintBoard() As %Status
{
    set Board=$Na(^Board)
    SET next=$QUERY(@Board@(""))
    W !
    FOR {
        SET i=$I(i)
        QUIT:next=""
        w:'(i#..#BoardRange=1) ","
        WRITE @next
        if '(i#..#BoardRange) w !
        SET next=$QUERY(@next)
    }
}

}
