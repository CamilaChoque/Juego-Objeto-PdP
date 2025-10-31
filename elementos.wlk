object caja{
    var property position = game.origin()
    method image() = "caja1.png"
}

class Obstaculo{
    var property position=game.at(6, 2)
    method image() = "obstaculo1.png"
    //var serie=
    
   
    method estaEnCelda(valorX,valorY){
        const obstaculos = game.allVisuals().filter({visual=>visual.image()==self.image()})
        //game.allVisuals().image()==self.image()
         

         return obstaculos.any({obstaculo=>obstaculo.position().x()==valorX && obstaculo.position().y()==valorY})
         
         /*
         try {
            game.at(valorX, valorY).image() == self.image()
        } 
        catch e : Exception {
            return false
        }*/
        /*console.println("IA: "+game.at(valorX, valorY).className())
        if(game.at(valorX, valorY).className()=="Obstaculo"){
            return game.at(valorX, valorY).image()===self.image()
        }
        return false*/
        /*if (game.at(valorX,valorY) != null && game.at(valorX,valorY).respondsTo("image")) {
            return game.at(valorX, valorY).image()===self.image()
        }*/
        /*try{
            return game.at(valorX, valorY).image()===self.image()
        } catch (e){
            // Ignorar si image() no está definido o cualquier otro error
            return false
        }*/

    }
        
    
    
}