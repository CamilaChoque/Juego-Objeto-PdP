import juego.*
import elementos.*


class enemigo{
    var property position=game.center() //peso-G: Total de pasos que hicimos para llegar al objetivo | 
    var property objetivo = caja
    var property recorridoATomar=[self.position()]
    method image()="enemigo1.png"

     //const posiciones = [game.at(1, 2),game.at(1, 3),game.at(1, 4),game.at(1, 5),game.at(1, 6),game.at(2, 6)]
    var indice=0
    method perseguir(){
        //recorre
        
        /*self.position(recorridoATomar.get(indice))
            //self.position(posiciones[indice])
            indice=indice+1*()*/

        if (indice < recorridoATomar.size()) {
            self.position(recorridoATomar.get(indice))
            indice = indice + 1
        } 
    }

    

}

class HitboxEnemigo inherits enemigo{ //recorrera todos los caminos posibles y luego le pasara el recorrido eficiente a ENEMIGO, recien ahi liberamos todo
    //heredamos la posicion con el mismo valor pero podemos usarla a nuestra forma
    var property obstaculos = game.allVisuals().filter({visual=>visual.image()==="obstaculo1.png"}) //de cada obstaculos nos interesa su posicion
    var property openSet = [] //celdas que no hemos revisado
    var property closeSet =[] //celdas que hemos revisado
    override method image()="enemigo1.png" //no lleva la misma img que el otro por eso
    var posicionAnt=objetivo.position() //debe ser propio del personaje, cambiar despues
    

    override method perseguir(){ //evaluar camino
        var posicionObjetivo=objetivo.position()
        console.println("again")
       
        if(posicionAnt==posicionObjetivo){
            if(!recorridoATomar.contains(posicionObjetivo)){ //sacar ese indice xq marca loop
                
                const estadisticaVecinal=[]
                //primera instancia es crear los vecinos desde mi osicion inicial
            
                //const posicionAEvaluar //guardamos la posicion actual del enemigo
                self.todosLosvecinos(recorridoATomar.last()) //recorridoATomar significa los que analice seran de la ruta y siempre partire del 1er elemento para saber sus vecinos y saber que camino tomar
                //console.println("desde: "+recorridoATomar.last())
                //analisis
                //openSet tendra all vecinos es hora de que cada vecino tenga su posicion y "f"
                /*openSet.forEach({ posicion =>
                    console.println("va: "+posicion)
                })*/
                openSet.forEach({posicion=>
                    console.println("Procesando posicion: " + posicion)
                    const vecino_=new Vecino()
                    vecino_.position(game.at(posicion.first(), posicion.last()))
                    vecino_.costoTotalF(self.position(), posicionObjetivo)
                    //console.println("Mensaje a mostrar en consola: "+vecino_.f())
                    estadisticaVecinal.add(vecino_)
                })
                
                //analizamos el que tiene el f menor de todo
                var elMenor=estadisticaVecinal.first().f()
                //var posicionDelMenor=game.at(0,0)
                estadisticaVecinal.forEach({vecino=>
                    if(vecino.f()<=elMenor) {elMenor=vecino.f()/*;posicionDelMenor=vecino.position()*/}
                })

                
                //nos interesa la posicion con el f menor de todos
                recorridoATomar.add(estadisticaVecinal.find({vecino=>vecino.f()==elMenor}).position())
                /*console.println("Ganador: "+recorridoATomar.last())
                console.println("Objetivo: "+posicionObjetivo)*/
                closeSet.addAll(openSet)
                openSet.clear()
                estadisticaVecinal.clear()

            }else{
                super()
                 
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
    
    method obstaculoPresente(posicionVecinoX,posicionVecinoY){
     return obstaculos.any({obstaculo=>obstaculo.estaEnCelda(posicionVecinoX, posicionVecinoY)})
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
  
   

    
}

class Vecino{ //xq tendre muchos vecinos desde mi posicion actual
    var property position = enemigo.position() //primer paso se analizara ahi))
    var property f =0 
   
    //obtenemos "g" ó g (depende del parametro)
    method costoPor(posicion_)=(position.x()-posicion_.x()).abs()+(position.y()-posicion_.y()).abs()
    //obtenemos "h"
    
    method costoTotalF(posicionInicial,posicionObjetivo){
            self.f(self.costoPor(posicionObjetivo)+self.costoPor(posicionInicial))
        }
    

}