object caja{
    var property position = game.origin()
    var property image = "caja1.png"
}

class Obstaculo{
    var property position=game.at(6, 2)
    var property image = "obstaculo1.png"
    //var serie=
    method estaEnCelda(valorX,valorY)=game.at(valorX, valorY).image()===self.image()
    
}