Class SeaBattle.Game
{

Parameter BoardRange = 10;

Parameter Rounds = 5;

ClassMethod Run() As %Status
{
        //READ #!!,"Please enter",!,"your name: ",x
        #; WRITE !,x
    do ..SetupGame()
    Do ..PrintBoard($na(^Board))
    for i=1:1:..#Rounds {
        WRITE "Round ",i
        READ !,"Please enter x:",x
        READ !,"And y:",y
        if ..CheckShip(x,y) {
            WRITE !,"You sunk the ship!"
            QUIT 
        }
        READ !,"You missed. Try again",x
    }
}

ClassMethod CheckShip(x, y) As %Boolean
{
    if $D(^Ships(x,y)) return 1
    return 0
}

ClassMethod SetupGame() As %Status
{
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
    zw ^Ships
}

ClassMethod PrintBoard(Board) As %Status
{

    SET next=$QUERY(@Board@(""))
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
