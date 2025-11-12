import juego.*
import elementos.*

class Enemigo{
    //const caminataAtras=["ene_caminaAtras1.png","ene_caminaAtras2.png"]
    var property capacidad = buscadorRutas  //te da todos los vecinos , mide dist euclideana
    var property position=game.center() //posicion inicial
    var property objetivo = caja
    //var property recorridoATomar=[self.position()] //posicion donde esta
    var property image = "ene_caminaDelante1.png" //pra modificarlo
    //method image()="enemigo1.png"
    
    
    //var property openSet = [] //celdas que no hemos revisado
    //var property closeSet =[self.position().x(),self.position().y()] //celdas que hemos revisado
    var posicionAnt=objetivo.position() //debe ser propio del personaje, cambiar despues
     //const posiciones = [game.at(1, 2),game.at(1, 3),game.at(1, 4),game.at(1, 5),game.at(1, 6),game.at(2, 6)]
    
     var property estado=1

     var property vida=5
    
    method perseguir(){ //evaluar camino
        //podemos contemplar un SET y no una lista para que no haya celdas repetidas asi aca llamo o inicio a closeSet con posicion del enemigo
        const posicionObjetivo=objetivo.position()

        if(posicionAnt==posicionObjetivo){ //esto para tomar en cuenta q no se haya movido, si lo hizo refrescamos todo y volvemos a analizar: evaluar si realmente funciona
            if(self.position().x()!=objetivo.position().x() || self.position().y()!=objetivo.position().y()){ 
                //en este if no comparamos con posicionMenor x seguridad y hacer la evaluacion exacta ya que posicion actual del enemigo y posicionMenor puede ser diferente 
                
                capacidad.todosLosVecinos(posicionDelMenor.first(),posicionDelMenor.last()) //recorridoATomar significa los que analice seran de la ruta y siempre partire del 1er elemento para saber sus vecinos y saber que camino tomar)

                //linea de arriba no funciona xq debop pasarle ubicacion del enemigo antes

                const posicionDelMenor=capacidad.obtenerCeldaMenor(self.position(),posicionObjetivo) //si esto funciona entonces BUSCADORRUTAS debe tener por dentro todos los vecinos no debe llamarlo enemigo
                
                self.cambiarDireccion(posicionDelMenor)
                
                //nos interesa la posicion con el f menor de todos
                capacidad.closeSet().addAll(capacidad.openSet())
                capacidad.openSet().clear()

            }else{
                //recorre
                console.println("llegate al objetivo")
                posicionAnt=objetivo.position()

                //esto en funcion buscadorRutas llamado LIMPIARregistros
                capacidad.closeSet().clear()
                capacidad.openSet().clear()
                //posicionDelMenor=[self.position().x(),self.position().y()]
                capacidad.closeSet([self.position().x(),self.position().y()])
                
            }
        }else{
            console.println("se movio")
            posicionAnt=objetivo.position()
            capacidad.closeSet().clear()
            capacidad.openSet().clear()
            //posicionDelMenor=[self.position().x(),self.position().y()]
            capacidad.closeSet([self.position().x(),self.position().y()])
            
        }
        
        posicionAnt=objetivo.position()
         

    }
    
    method cambiarDireccion(posicionNueva){ //aCTUALIZA POSICION y sprite
    
         /*digamos tengo la posicon (4,6)
        quiero las posiciones (analizando que no hayan sido analizados ó que no esté ahi obstaculos)*/
        /*
            (3,6)
        (4,5)  (4,6)   (4,7)
             (5,6)*/

        if(posicionNueva.last()==self.position().y()){
            if(posicionNueva.first()>self.position().x()){
                //mover abajo
                
                self.cambiarSprite("ene_caminaDer1.png", "ene_caminaDer2.png")
            }
            if(self.position().x()>posicionNueva.first()){
                //movbver arriba
                self.cambiarSprite("ene_caminaIzq1.png", "ene_caminaIzq2.png")
                
            }
        }
        
        if(posicionNueva.first()==self.position().x()){
            if(posicionNueva.last()<self.position().y()){
                self.cambiarSprite("ene_caminaDelante1.png", "ene_caminaDelante1.png")
            }else{
                self.cambiarSprite("ene_caminaAtras1.png", "ene_caminaAtras2.png")
            }
        }
        
        self.position(game.at(posicionNueva.first(),posicionNueva.last())) //actualizamos su posicon para que se mueva
        
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
