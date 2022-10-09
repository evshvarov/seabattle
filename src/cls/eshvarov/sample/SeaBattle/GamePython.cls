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

ClassMethod GetBoardStorage() As %String
{
    return ..#BoardStorage
}

ClassMethod Run() As %Status [ Language = python ]
{
    import iris
    print("Welcome to 'SEA BATTLE' game!") 
    print("\nThere is a hidden ship. Try to find it in "+str(iris.cls(__name__).GetRounds())+" rounds. Let's go!")
    iris.cls(__name__).SetupGame()
    #self.SetupGame()
    win=0
    for i in range(iris.cls(__name__)._GetParameter("Rounds")): 
        print("\nRound "+str(i+1)) 
        x=input('\nPlease enter x:')
        y=input('\nAnd y:')        
        iris.cls(__name__).HitBoard(x,y)
        iris.cls(__name__).PrintBoard()
        if iris.cls(__name__).CheckShip(x,y): 
            print("\nYou've sunk the ship! You win! ")
            win=1
            break
        print("You missed. Try again")
    if win==0:
        print("GAME OVER")
}

ClassMethod HitBoard(x, y) As %Status [ Language = python ]
{
    #set @..#BoardStorage@(x,y)="X"
    import iris
    bs=iris.gref(iris.cls(__name__).GetBoardStorage())
    bs.set([x,y],"X")
}

ClassMethod CheckShip(x, y) As %Boolean [ Language = python ]
{
    import iris
    bs=iris.gref(iris.cls(__name__)._GetParameter("ShipsStorage"))
    if bs.data([x,y])==1:
        result=1
    else:
        result=0
    print(result)
    return result
}

ClassMethod SetupGame() As %Status [ Language = python ]
{
    import iris
    bs=iris.gref(iris.cls(__name__)._GetParameter("BoardStorage"))
    bs.kill([])
    for x in range(iris.cls(__name__)._GetParameter("Rounds")):
        for y in range(iris.cls(__name__)._GetParameter("Rounds")):
            bs.set([x+1,y+1],"0")
    iris.cls(__name__).HideShip()
}

ClassMethod HideShip() As %Status [ Language = python ]
{
    import iris
    shipsgl=iris.gref(iris.cls(__name__)._GetParameter("ShipsStorage"))
    shipsgl.kill([])
    import random
    board=iris.cls(__name__)._GetParameter("BoardRange")
    x=random.randint(1,board)
    y=random.randint(1,board)
    #print(x,y)
    shipsgl.set([x,y],1)
}

ClassMethod PrintBoard() As %Status [ Language = python ]
{
    import iris
    bs=iris.gref(iris.cls(__name__)._GetParameter("BoardStorage"))
    st=""
    print(st)
    for (key,value) in bs.query([]):
        if len(key)>1:
            if int(key[1])<5:
                st=st+str(value)+","
            else:
                st=st+str(value)
                print(st)
                st=""
}

}
