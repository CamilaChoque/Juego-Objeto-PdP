
import juego.*


class enemigo{
    var property position=game.center() //peso-G: Total de pasos que hicimos para llegar al objetivo | 
    var property obstaculos = game.allVisuals() //de cada obstaculos nos interesa su posicion
    var property openSet = [] //celdas que no hemos revisado
    var property closeSet =[] //celdas que hemos revisado
    var property recorridoATomar=[]
    //heuristica=inicio
    //inicio: position().x() Y position().y() 
    //destino: objetivo.position().x() Y objetivo.position().y()
    //abs(position().x()-objetivo.position().x()) EKIS
    //abs(position().y()-objetivo.position().y()) YIES
    //h=EXIS+YIES - acercamiento (caso ideal)
    //f=g+h - COSTO TOTAL y la "f" mas pequeña será el camino elegido (menos pasos)
    
    //var position = game.at(30,30)
    //var posicion = game.at(0,0)
    method image()="enemigo1.png"

    
    method perseguir(objetivo){
        //var posicion=objetivo.position()
        
        openSet.add([self.position().x(), self.position().y()]) //agregamos la posicion actual del enemigo
         //agregamos a esta lista porque la estamos analizando
        self.todosLosvecinos(openSet.remove(openSet.last()))
        

        if(objetivo.position().x()>position.x()){
            position=position.right(1)
        }
        if(objetivo.position().x()<position.x()){
            position=position.left(1)
        }
        if(objetivo.position().x()==position.x() && objetivo.position().y()<position.y()){
            position=position.down(1)
        }
        if(objetivo.position().x()==position.x() && objetivo.position().y()>position.y()){
            position=position.up(1)
        }
        //position=position.right(4)
    }

    method costoDesdeInicial(){

    }
    method costoAlFinal(){

    }
    method armarRecorrido(){

    }

    method obstaculoPresente(posicionVecinoX,posicionVecinoY){
     return obstaculos.any({obstaculo=>obstaculo.estaEnCelda(posicionVecinoX, posicionVecinoY)})
    }

    method agregarVecino(posVecinoX,posVecinoY){
        if(!closeSet.contains([posVecinoX, posVecinoX]) || !self.obstaculoPresente(posVecinoX,posVecinoX) || !juego.estaAlLimite(posVecinoX, posVecinoY)) openSet.add([posVecinoX, posVecinoX])

    }
    method todosLosvecinos(posicionActual){
        /*digamos tengo la posicon (4,6)
        quiero las posiciones (analizando que no hayan sido analizados ó que no esté ahi obstaculos)
        (3,5)(3,6)(3,7)
        (4,5)     (4,7)
        (5,5)(5,6)(5,7)*/
         
        closeSet.add(posicionActual) //la posicion actual está siendo analizada por eso lo ponemos en closeSet
        openSet.remove(openSet.last()) //lo sacamos porque fue analizado
        const eneX = posicionActual.first()
        const eneY=posicionActual.last()

        self.agregarVecino(eneX-1, eneY-1) //(3,5) - xq si esta en closeSet significa que ya lo analice
        self.agregarVecino(eneX-1, eneY)  //(3,6)
        self.agregarVecino(eneX-1, eneY+1) //(3,7)

        self.agregarVecino(eneX, eneY-1) //(4,5)
        self.agregarVecino(eneX, eneY+1)  //(4,7)

        self.agregarVecino(eneX+1, eneY-1) //(5,5)
        self.agregarVecino(eneX+1, eneY) //(5,6)
        self.agregarVecino(eneX+1, eneY+1) //(5,7)
        
    
    }
    

}