
import elementos.*
import enemigo.*

object juego{ //si es muy pequeño añadir acá los menus pasando a llamarse "configuración"
    const enemigo_ = new Enemigo()
    method iniciar(){
        game.addVisualCharacter(caja)
        game.addVisual(enemigo_)
        [9,10,11,12,13,14,15].forEach({ elemento=>
        //const obstaculoA_ = new Obstaculo()
        const obstaculoB_ = new Obstaculo()
        //obstaculoA_.position(game.at(elemento, 3))
        obstaculoB_.position(game.at(elemento, 9))

        //game.addVisual(obstaculoA_)
        game.addVisual(obstaculoB_)})
        
        [2,3,4,5].forEach({ elemento=>
        const obstaculov_ = new Obstaculo()
        obstaculov_.position(game.at(7, elemento))
        
        
        game.addVisual(obstaculov_)})
        
        
        game.onTick(90, "seguimiento", {enemigo_.perseguir()}) //esto actualizar recorrerATomar
        
        //game.schedule(100, {invisibleEnemigo.perseguir()}) //esto actualizar recorrerATomar

        //enemigo_.perseguir()
        //game.onTick(1000, "seguimiento", {enemigo_.perseguir()})
        
        //agregar ontick para el enemigo
        
        
        //game.onTick(1000, "seguimiento", {enemigo_.perseguir(caja)})
    }

    /*method evitar(){
        game.allVisuals().image()=="obstaculo1.png"
        //todos los visuales con esa img vamos a evitarlas ó nos interesará su posición
    }*/

    method estaAlLimite(posX,posY)=game.width()<posX || game.height()<posY || posX<0 || posY<0 //si se pasa del tablero tanto negativo o fuera del rango
}

object buscadorRutas{
    
    var property openSet = [] //celdas que no hemos revisado
    var property closeSet =[] //celdas que hemos revisado
    //var posicionAnt=objetivo.position() //debe ser propio del personaje, cambiar despues
     //const posiciones = [game.at(1, 2),game.at(1, 3),game.at(1, 4),game.at(1, 5),game.at(1, 6),game.at(2, 6)]
    method posicionDelMenor(personaje)=[personaje.position().x(),personaje.position().y()]
    method posicionAnt(objetivo)=objetivo.position()

    
    method calcularDistanciaEuclidiana(destino,llegada){ //si ambos vecinos tienene f igual, elegimos la distancia euclidiana mas convenitne, xq no usar euclidiana en todas xq puede calcularse con el enemigo cerca y en si en poco practica porque puede haber un opbstaculo ahi y es mejor la distancia manhattan
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
    
    method obtenerCeldaMenor(posicionEnemigo,posicionObjetivo){
        var elMenor=100 //por los valores dde la tabla nunca llegaremos a 100
        var posicionDelMenor=[posicionEnemigo.x(),posicionEnemigo.y()]
        openSet.forEach({posicion=>
                    var f=0    
                    
                    f=self.costoTotalF(posicionEnemigo, posicionObjetivo,posicion)
                    /*console.println("analizando: "+posicion)
                    console.println("f: "+f)*/
                    //console.println("Mensaje a mostrar en consola: "+vecino_.f())
                    //si son iguales elegir el menor de la distancia euclides
                    if(f<elMenor) {
                        elMenor=f/*;posicionDelMenor=vecino.position()*/
                        posicionDelMenor=posicion
                    }else if(f==elMenor){ //si son iguales elegimos el que tenga distancia menor euclideana
                        const dist_f=self.calcularDistanciaEuclidiana(posicion, [posicionObjetivo.x(),posicionObjetivo.y()])
                        const dist_elMenor=self.calcularDistanciaEuclidiana(posicionDelMenor, [posicionObjetivo.x(),posicionObjetivo.y()])
                        if(dist_f<dist_elMenor){
                            elMenor=f
                            posicionDelMenor=posicion
                        }
                        console.println("-ganador: "+posicionDelMenor)
                        console.println("-objetivo: "+posicionObjetivo)
                        console.println("-enemigo: "+ posicionEnemigo)
                    } 
                    
                })
                return posicionDelMenor           
    }
}