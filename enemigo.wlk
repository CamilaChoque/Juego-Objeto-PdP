import juego.*
import elementos.*


class enemigo{
    var property position=game.center() //peso-G: Total de pasos que hicimos para llegar al objetivo | 
    var property objetivo = caja
    var property recorridoATomar=[self.position()]
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

    
    method perseguir(){
        //recorre
        recorridoATomar.forEach({posicion=>{
            self.position(posicion)
        }})
        //var posicion=objetivo.position()
        //decidirCamino()
        
        /*if(objetivo.position().x()>position.x()){
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
        }*/
        //position=position.right(4)
    }

    

}

class HitboxEnemigo inherits enemigo{ //recorrera todos los caminos posibles y luego le pasara el recorrido eficiente a ENEMIGO, recien ahi liberamos todo
    //heredamos la posicion con el mismo valor pero podemos usarla a nuestra forma
    var property obstaculos = game.allVisuals() //de cada obstaculos nos interesa su posicion
    var property openSet = [] //celdas que no hemos revisado
    var property closeSet =[] //celdas que hemos revisado
    override method image()="hola.png" //no lleva la misma img que el otro por eso

    override method perseguir(){
        //openSet.add([self.position().x(), self.position().y()]) //antes e decir lo instaciamos con la posicion del enemigo , agregamos a esta lista porque la estamos analizando

        self.evaluarCamino()
        super()
        
    }


    method evaluarCamino(){
        if(!recorridoATomar.contains(objetivo.position())){
            const estadisticaVecinal=[]
            //primera instancia es crear los vecinos desde mi osicion inicial
            /*const vecina = new Vecino()
            vecina.position(self.position())
            vecina.costoTotalF(self.position(),objetivo.position())*/
            //const posicionAEvaluar //guardamos la posicion actual del enemigo
            self.todosLosvecinos(recorridoATomar.first()) //recorridoATomar significa los que analice seran de la ruta y siempre partire del 1er elemento para saber sus vecinos y saber que camino tomar
            //analisis
            //openSet tendra all vecinos es hora de que cada vecino tenga su posicion y "f"
            openSet.forEach({posicion=>{
                const vecino_=new Vecino()
                vecino_.position(game.at(posicion.first(), posicion.last()))
                vecino_.costoTotalF(self.position(), objetivo.position())
                estadisticaVecinal.add(vecino_)
            }})
            
            //analizamos el que tiene el f menor de todo
            var elMenor=estadisticaVecinal.first().f()
            var posicionDelMenor=game.at(0,0)
            estadisticaVecinal.forEach({vecino=>{
                if(vecino.f()<elMenor) {elMenor=vecino.f();posicionDelMenor=vecino.position()}
            }})
            //nos interesa la posicion con el f menor de todos
            recorridoATomar.add(posicionDelMenor)
        }
        
         

    }
    
    method obstaculoPresente(posicionVecinoX,posicionVecinoY){
     return obstaculos.any({obstaculo=>obstaculo.estaEnCelda(posicionVecinoX, posicionVecinoY)})
    }

    method agregarVecino(posVecinoX,posVecinoY){
        if(!closeSet.contains([posVecinoX, posVecinoX]) || !self.obstaculoPresente(posVecinoX,posVecinoY) || !juego.estaAlLimite(posVecinoX, posVecinoY)) openSet.add([posVecinoX, posVecinoX])

    }
    method todosLosvecinos(posicionActual){
        /*digamos tengo la posicon (4,6)
        quiero las posiciones (analizando que no hayan sido analizados ó que no esté ahi obstaculos)
        (3,5)(3,6)(3,7)
        (4,5)     (4,7)
        (5,5)(5,6)(5,7)*/
        /*
            (3,6)
        (4,5)     (4,7)
             (5,6)*/
        
         
        closeSet.add(posicionActual) //la posicion actual está siendo analizada por eso lo ponemos en closeSet - sirve esto xq si esta en closeSet significa que ya lo analice
        openSet.remove(posicionActual) //lo sacamos porque fue analizado
        const eneX = posicionActual.first()
        const eneY=posicionActual.last()

        
        self.agregarVecino(eneX-1, eneY)  //(3,6)
        self.agregarVecino(eneX, eneY-1) //(4,5)
        self.agregarVecino(eneX, eneY+1)  //(4,7)
        self.agregarVecino(eneX+1, eneY) //(5,6)
        
        
    
    }
    method armarRecorrido(){ //obtener "F" y registrarlo recorridoATomar
    //posiblemente eliminar
    }
   

    
}

class Vecino{ //xq tendre muchos vecinos desde mi posicion actual
    var property position = enemigo.position() //primer paso se analizara ahi))
    var property f =0 
    /*var property positionInicial = game.origin() 
    var property positionObjetivo = game.origin()*/
    //obtenemos "g" ó g (depende del parametro)
    method costoPor(posicion_)=(position.x()-posicion_.x()).abs()+(position.y()-posicion_.y())
    //obtenemos "h"
    
    method costoTotalF(posicionInicial,posicionObjetivo){
            self.f(self.costoPor(posicionObjetivo)+self.costoPor(posicionInicial))
        }
    

}