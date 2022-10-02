Class eshvarov.sample.SeaBattle.GamePython
{

Parameter BoardRange = 5;

Parameter Rounds = 5;

Parameter ShipsStorage = "^Ships";

Parameter BoardStorage = "^Board";

ClassMethod GetRounds() As %Integer
{
    return ..#Rounds
}

ClassMethod Run() As %Status [ Language = python ]
{
    import iris
    print("Welcome to 'SEA BATTLE' game!") 
    print("\nThere is a hidden ship. Try to find it in "+str(iris.cls('eshvarov.sample.SeaBattle.GamePython').GetRounds())+" rounds. Let's go!")
    iris.cls('eshvarov.sample.SeaBattle.GamePython').SetupGame()
    #self.SetupGame()
    win=0
    for i in range(iris.cls('eshvarov.sample.SeaBattle.GamePython').GetRounds()): 
        print("\nRound "+str(i)) 
        x=input('\nPlease enter x:')
        y=input('\nAnd y:')        
        iris.cls('eshvarov.sample.SeaBattle.GamePython').HitBoard(x,y)
        iris.cls('eshvarov.sample.SeaBattle.GamePython').PrintBoard()
        if iris.cls('eshvarov.sample.SeaBattle.GamePython').CheckShip(x,y): 
            print("\nYou've sunk the ship! You win! ")
            win=1
            break
        print("You missed. Try again")
    if win==0:
        print("GAME OVER")
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

}
