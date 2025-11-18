object caja{ //Usado de testeo, no pertenece al juego
    var property position = game.origin()
    method image() = "caja1.png"
}

class Obstaculo{
    var property position=game.at(6, 2)
    method image() = "obstaculo1.png"
    //var serie=
    method estaPresente(posVecinoX,posVecinoY){
        const obstaculos = game.allVisuals().filter({visual=>visual.image()=="obstaculo1.png"})
         return obstaculos.any({obstaculo=>obstaculo.position().x()==posVecinoX&&obstaculo.position().y()==posVecinoY})

    }
  
        
    
    
}