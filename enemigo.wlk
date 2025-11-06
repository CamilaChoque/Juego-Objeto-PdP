import juego.*
import elementos.*


class enemigo{
    var property position=game.center() //peso-G: Total de pasos que hicimos para llegar al objetivo | 
    var property objetivo = caja
    var property recorridoATomar=[self.position()]
    method image()="invi.png"
    //method image()="enemigo1.png"

    var property openSet = [] //celdas que no hemos revisado
    var property closeSet =[] //celdas que hemos revisado
    var posicionAnt=objetivo.position() //debe ser propio del personaje, cambiar despues
     //const posiciones = [game.at(1, 2),game.at(1, 3),game.at(1, 4),game.at(1, 5),game.at(1, 6),game.at(2, 6)]
    var indice=0
    
    method perseguir(){ //evaluar camino
        var posicionObjetivo=objetivo.position()
        //console.println("again")
       
        if(posicionAnt==posicionObjetivo){
            if(!recorridoATomar.contains(posicionObjetivo)){ //sacar ese indice xq marca loop
                var posicionObjetivo=objetivo.position()
                //const estadisticaVecinal=[]}
                //primera instancia es crear los vecinos desde mi osicion inicial
            
                //const posicionAEvaluar //guardamos la posicion actual del enemigo
                self.todosLosvecinos(recorridoATomar.last()) //recorridoATomar significa los que analice seran de la ruta y siempre partire del 1er elemento para saber sus vecinos y saber que camino tomar
                //console.println("desde: "+recorridoATomar.last())
                //analisis
                //openSet tendra all vecinos es hora de que cada vecino tenga su posicion y "f"
                /*openSet.forEach({ posicion =>
                    console.println("va: "+posicion)
                })*/
                var elMenor=100
                var posicionDelMenor=game.at(0,0)
                
                openSet.forEach({posicion=>
                    var f=0    
                    
                    //vecino_.position(game.at(posicion.first(), posicion.last()))
                    
                    f=self.costoTotalF(self.position(), posicionObjetivo,posicion)
                    console.println("analizando: "+posicion)
                    console.println("f: "+f)
                    //console.println("Mensaje a mostrar en consola: "+vecino_.f())
                    if(f<elMenor) {
                        elMenor=f/*;posicionDelMenor=vecino.position()*/
                        posicionDelMenor=posicion
                    }else{
                        console.println("-ganador: "+posicionDelMenor)
                        console.println("-objetivo: "+posicionObjetivo)
                    }
                    
                })
                
                self.position(game.at(posicionDelMenor.first(),posicionDelMenor.last()))

                
                //nos interesa la posicion con el f menor de todos
                recorridoATomar.add(game.at(posicionDelMenor.first(),posicionDelMenor.last()))
                closeSet.addAll(openSet)
                openSet.clear()
                //estadisticaVecinal.clear()

            }else{
                //recorre
                /*self.position(recorridoATomar.get(indice))
                    //self.position(posiciones[indice])
                    indice=indice+1*()*/

                console.println("llegate al objetivo")
                /*if (indice < recorridoATomar.size()) {
                    self.position(recorridoATomar.get(indice))
                    indice = indice + 1
                } */
                 
            }
        }else{
            posicionAnt=objetivo.position()
            closeSet.clear()
            openSet.clear()
            recorridoATomar.clear()
            recorridoATomar=[self.position()]
            indice=0
        }
        
        
         

    }
    
    /*method obstaculoPresente(posicionVecinoX,posicionVecinoY){
     return obstaculos.any({obstaculo=>obstaculo.estaEnCelda(posicionVecinoX, posicionVecinoY)})
    }*/

     
    method obstaculoPresente(valorX,valorY){
        const obstaculos = game.allVisuals().filter({visual=>visual.image()=="obstaculo1.png"})
        //game.allVisuals().image()==self.image()
         

         return obstaculos.any({obstaculo=>obstaculo.position().x()==valorX && obstaculo.position().y()==valorY})

    }

    method agregarVecino(posVecinoX,posVecinoY){
        
        if(!closeSet.contains([posVecinoX, posVecinoY]) && !self.obstaculoPresente(posVecinoX,posVecinoY) && !juego.estaAlLimite(posVecinoX, posVecinoY)) {
            openSet.add([posVecinoX, posVecinoY])
        }
        

    }
    method todosLosvecinos(posicionActual){
        /*digamos tengo la posicon (4,6)
        quiero las posiciones (analizando que no hayan sido analizados ó que no esté ahi obstaculos)*/
        /*
            (3,6)
        (4,5)     (4,7)
             (5,6)*/
       
        
        const eneX = posicionActual.x()
        const eneY=posicionActual.y()
        closeSet.add([eneX,eneY]) //la posicion actual está siendo analizada por eso lo ponemos en closeSet - sirve esto xq si esta en closeSet significa que ya lo analice
        

        // 9,5
        self.agregarVecino(eneX-1, eneY)  //(3,6)

        self.agregarVecino(eneX, eneY-1) //(4,5)
        
        self.agregarVecino(eneX, eneY+1)  //(4,7)
        
        self.agregarVecino(eneX+1, eneY) //(5,6)
        
    }

    method costoPor(posicion_,posActual)=(posActual.first()-posicion_.x()).abs()+(posActual.last()-posicion_.y()).abs()
    //obtenemos "h"
    
    method costoTotalF(posicionInicial,posicionObjetivo,posicionActual){
            return (self.costoPor(posicionObjetivo,posicionActual)+self.costoPor(posicionInicial,posicionActual))
        }
    

}


/*class Vecino{ //xq tendre muchos vecinos desde mi posicion actual
    var property position = enemigo.position() //primer paso se analizara ahi))
    var property f =0 
   
    //obtenemos "g" ó g (depende del parametro)
    method costoPor(posicion_)=(position.x()-posicion_.x()).abs()+(position.y()-posicion_.y()).abs()
    //obtenemos "h"
    
    method costoTotalF(posicionInicial,posicionObjetivo){
            self.f(self.costoPor(posicionObjetivo)+self.costoPor(posicionInicial))
        }
    

}*/