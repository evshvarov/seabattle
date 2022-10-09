Class eshvarov.sample.SeaBattle.Game
{

Parameter BoardRange = 5;

Parameter Rounds = 5;

Parameter ShipsStorage = "^Ships";

Parameter BoardStorage = "^Board";

ClassMethod Run() As %Status
{
   w #,"Welcome to 'SEA BATTLE' game!"
   w !,"There is a hidden ship. Try to find it in ",..#Rounds," rounds. Let's go!"
   do ..SetupGame() 
    for i=1:1:..#Rounds {
        write !,"Round ",i
        read !,"Please enter x:",x
        read !,"And y:",y
        do ..HitBoard(x,y)
        do ..PrintBoard()
        if ..CheckShip(x,y) {
            write !,"You've sunk the ship! You win!"
            quit 
        }
        w !,"You missed. Try again"
    }
    w !, "GAME OVER"
    return $$$OK
}

ClassMethod HitBoard(x, y) As %Status
{
    set @..#BoardStorage@(x,y)="X"
}

ClassMethod CheckShip(x, y) As %Boolean
{
    if $D(^Ships(x,y)) return 1
    return 0
}

ClassMethod SetupGame() As %Status
{
    s ad=..#BoardStorage
    k @..#BoardStorage
    for x=1:1:..#BoardRange {
        for y=1:1:..#BoardRange {
            set @..#BoardStorage@(x,y)="O"
        }
    }
    do ..HideShip()
}

ClassMethod HideShip() As %Status
{
    kill ^Ships
    set ^Ships($RANDOM(..#BoardRange)+1,$RANDOM(..#BoardRange)+1)=""
    #; zw ^Ships
}

ClassMethod PrintBoard() As %Status
{
    set Board=$Name(@..#BoardStorage)
    set next=$Query(@Board@(""))
    w !
    for {
        set i=$I(i)
        quit:next=""
        w:'(i#..#BoardRange=1) ","
        write @next
        if '(i#..#BoardRange) w !
        set next=$Query(@next)
    }
}

ClassMethod PrintGlobal(gname) As %Status
{

    
    set global=$Name(@gname)

    set next=$Query(@global@(""))

    for {
    quit:next=""
    
    write !,next,@next

    set next=$Query(@next)

}
}

}
