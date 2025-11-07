import juego.*
import elementos.*


class Enemigo{
    var property position=game.center() //posicion inicial
    var property objetivo = caja
    //var property recorridoATomar=[self.position()] //posicion donde esta
    method image()="invi.png"
    //method image()="enemigo1.png"
    var posicionDelMenor=[self.position().x(),self.position().y()]
    var property openSet = [] //celdas que no hemos revisado
    var property closeSet =[self.position().x(),self.position().y()] //celdas que hemos revisado
    var posicionAnt=objetivo.position() //debe ser propio del personaje, cambiar despues
     //const posiciones = [game.at(1, 2),game.at(1, 3),game.at(1, 4),game.at(1, 5),game.at(1, 6),game.at(2, 6)]
    
    method perseguir(){ //evaluar camino
        //var posicionObjetivo=objetivo.position()
        //console.println("again")
        var elMenor=100 //por los valores dde la tabla nunca llegaremos a 100
        
        var posicionObjetivo=objetivo.position()

        if(posicionAnt==posicionObjetivo){ //esto para tomar en cuenta q no se haya movido, si lo hizo refrescamos todo y volvemos a analizar: evaluar si realmente funciona
            if(self.position().x()!=objetivo.position().x() || self.position().y()!=objetivo.position().y()){ 
                //en este if no comparamos con posicionMenor x seguridad y hacer la evaluacion exacta ya que posicion actual del enemigo y posicionMenor puede ser diferente 
                
                self.todosLosvecinos(posicionDelMenor.first(),posicionDelMenor.last()) //recorridoATomar significa los que analice seran de la ruta y siempre partire del 1er elemento para saber sus vecinos y saber que camino tomar
                

                openSet.forEach({posicion=>
                    var f=0    
                    
                    f=self.costoTotalF(self.position(), posicionObjetivo,posicion)
                    console.println("analizando: "+posicion)
                    console.println("f: "+f)
                    //console.println("Mensaje a mostrar en consola: "+vecino_.f())
                    //si son iguales elegir el menor de la distancia euclides
                    if(f<elMenor) {
                        elMenor=f/*;posicionDelMenor=vecino.position()*/
                        posicionDelMenor=posicion
                    }else if(f==elMenor){ //si son iguales elegimos el que tenga distancia menor euclideana
                        var dist_f=self.distanciaEuclidiana(posicion, [posicionObjetivo.x(),posicionObjetivo.y()])
                        var dist_elMenor=self.distanciaEuclidiana(posicionDelMenor, [posicionObjetivo.x(),posicionObjetivo.y()])
                        //var dist_f=self.distanciaEuclideana(posicion,[posicionObjetivo.x(),posicionObjetivo.y()])
                        //var dist_elMenor=self.distanciaEuclideana(posicionDelMenor,[posicionObjetivo.x(),posicionObjetivo.y()])
                        if(dist_f<dist_elMenor){
                            elMenor=f/*;posicionDelMenor=vecino.position()*/
                            posicionDelMenor=posicion
                        }
                        console.println("-ganador: "+posicionDelMenor)
                        console.println("-objetivo: "+posicionObjetivo)
                        console.println("-enemigo: "+ self.position())
                    } 
                    
                })
                
                self.position(game.at(posicionDelMenor.first(),posicionDelMenor.last())) //actualizamos su posicon para que se mueva

                
                //nos interesa la posicion con el f menor de todos
                //recorridoATomar.add(game.at(posicionDelMenor.first(),posicionDelMenor.last()))
                closeSet.addAll(openSet)
                openSet.clear()
                //estadisticaVecinal.clear()

            }else{
                //recorre
                

                console.println("llegate al objetivo")
                posicionAnt=objetivo.position()
                closeSet.clear()
                openSet.clear()
                posicionDelMenor=[self.position().x(),self.position().y()]
                closeSet =[self.position().x(),self.position().y()]
                
            }
        }else{
            console.println("se movio")
            posicionAnt=objetivo.position()
            closeSet.clear()
            openSet.clear()
            posicionDelMenor=[self.position().x(),self.position().y()]
            closeSet =[self.position().x(),self.position().y()]
            
        }
        
        
         

    }
    
    method distanciaEuclidiana(destino,llegada){ //si ambos vecinos tienene f igual, elegimos la distancia euclidiana mas convenitne, xq no usar euclidiana en todas xq puede calcularse con el enemigo cerca y en si en poco practica porque puede haber un opbstaculo ahi y es mejor la distancia manhattan
        //armado de los vectores ó hipotenunsas, cada uno es una coordenada
        const abscisa=destino.first()-llegada.first()
        const coordenada=destino.last()-llegada.last()
        //calculo del modulo de ambos vector
        console.println("De"+destino+" es : "+(abscisa**2+coordenada**2)**0.5)
        return (abscisa**2+coordenada**2)**0.5
        
    }
    method obstaculoPresente(valorX,valorY){
        const obstaculos = game.allVisuals().filter({visual=>visual.image()=="obstaculo1.png"})
         return obstaculos.any({obstaculo=>obstaculo.position().x()==valorX && obstaculo.position().y()==valorY})

    }

    method celdaLibre(posVecinoX,posVecinoY)=!closeSet.contains([posVecinoX, posVecinoY]) && !self.obstaculoPresente(posVecinoX,posVecinoY) && !juego.estaAlLimite(posVecinoX, posVecinoY) //celda libre significa que no fue revisado, que no esta al limite y que no tiene obstaculo
    
    method agregarVecino(posVecinoX,posVecinoY){
        
        if(self.celdaLibre(posVecinoX,posVecinoY)) {
            openSet.add([posVecinoX, posVecinoY])
        }else{
            console.println("No elegido: "+[posVecinoX, posVecinoY])
        }
        

    }
    method todosLosvecinos(eneX,eneY){
        /*digamos tengo la posicon (4,6)
        quiero las posiciones (analizando que no hayan sido analizados ó que no esté ahi obstaculos)*/
        /*
            (3,6)
        (4,5)     (4,7)
             (5,6)*/
       
    
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