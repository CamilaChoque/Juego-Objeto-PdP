import juego.*
import elementos.*


class Enemigo{
    //const caminataAtras=["ene_caminaAtras1.png","ene_caminaAtras2.png"]
    var property position=game.center() //posicion inicial
    var property objetivo = caja
    //var property recorridoATomar=[self.position()] //posicion donde esta
    var property image = "ene_caminaDelante1.png" //pra modificarlo
    //method image()="enemigo1.png"
    var posicionDelMenor=[self.position().x(),self.position().y()]
    var property openSet = [] //celdas que no hemos revisado
    var property closeSet =[self.position().x(),self.position().y()] //celdas que hemos revisado
    var posicionAnt=objetivo.position() //debe ser propio del personaje, cambiar despues
     //const posiciones = [game.at(1, 2),game.at(1, 3),game.at(1, 4),game.at(1, 5),game.at(1, 6),game.at(2, 6)]
     var property estado=1

     var property vida=5
    
    method perseguir(){ //evaluar camino
        
        var elMenor=100 //por los valores dde la tabla nunca llegaremos a 100
        
        const posicionObjetivo=objetivo.position()

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
                        const dist_f=self.distanciaEuclidiana(posicion, [posicionObjetivo.x(),posicionObjetivo.y()])
                        const dist_elMenor=self.distanciaEuclidiana(posicionDelMenor, [posicionObjetivo.x(),posicionObjetivo.y()])
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
                
                self.cambiarDireccion(posicionDelMenor)
                

                
                
                //nos interesa la posicion con el f menor de todos
                closeSet.addAll(openSet)
                openSet.clear()

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
    
    method costoTotalF(posicionInicial,posicionObjetivo,posicionActual)=self.costoPor(posicionObjetivo,posicionActual)+self.costoPor(posicionInicial,posicionActual)
    
    method cambiarDireccion(posicionNueva){ //aCTUALIZA POSICION y sprite
    
        var  mueveArriba = false
        var  mueveAbajo = false
        var  mueveIzq = false
        var  mueveDer = false
         /*digamos tengo la posicon (4,6)
        quiero las posiciones (analizando que no hayan sido analizados ó que no esté ahi obstaculos)*/
        /*
            (3,6)
        (4,5)  (4,6)   (4,7)
             (5,6)*/

        if(posicionNueva.last()==self.position().y()){
            if(posicionNueva.first()>self.position().x()){
                mueveAbajo=true
                mueveArriba=false
                mueveIzq = false
                mueveDer = false
                //mover abajo
                
                self.cambiarSprite("ene_caminaDer1.png", "ene_caminaDer2.png")
            }
            if(self.position().x()>posicionNueva.first()){
                mueveArriba=true
                mueveAbajo = false
                mueveIzq = false
                mueveDer = false
                //movbver arriba
                self.cambiarSprite("ene_caminaIzq1.png", "ene_caminaIzq2.png")
                
            }
        }
        
        if(posicionNueva.first()==self.position().x()){
            if(posicionNueva.last()<self.position().y()){
                mueveIzq=true
                mueveArriba=false
                mueveAbajo = false
                mueveDer = false
                self.cambiarSprite("ene_caminaDelante1.png", "ene_caminaDelante1.png")
            }else{
                mueveDer=true
                mueveIzq=false
                mueveArriba=false
                mueveAbajo = false
                self.cambiarSprite("ene_caminaAtras1.png", "ene_caminaAtras2.png")
            }
        }
        /*if(mueveArriba) self.position(self.position().up(velocidad))
        if(mueveAbajo) self.position(self.position().down(velocidad))
        if(mueveIzq) self.position(self.position().left(velocidad))
        if(mueveDer) self.position(self.position().right(velocidad))*/
        self.position(game.at(posicionNueva.first(),posicionNueva.last())) //actualizamos su posicon para que se mueva
        //reinicio valores para que no afecte posteriores direcciones
        mueveArriba = false
        mueveAbajo = false
        mueveIzq = false
        mueveDer = false
    }

    method cambiarSprite(imagen1,imagen2){
        if (self.estado()==1) {
			self.image(imagen1) //cambiar img
            estado = 2
		} else{
			self.image(imagen2) //cambiar img
			estado = 1
		}	
        
    }

    method efectoBala(arma){

    }
    
}

/*object armaSimple{
    const property efecto=1
}*/