<<<<<<< HEAD
import elementos.*

class Enemigo{
    var property position=game.at(4,4)
    //var position = game.at(30,30)
    //var posicion = game.at(0,0)
    method image()="enemigo1.png"

    
    method perseguir(objetivo){
        //var posicion=objetivo.position()
        
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
        //if(objetivo.position() == position){self.perseguir(puerta)
        //}
    }
    

=======
import juego.*
import elementos.*

class Enemigo{
    //const caminataAtras=["ene_caminaAtras1.png","ene_caminaAtras2.png"]
    var property capacidad = buscadorRutas  //te da todos los vecinos , mide dist euclideana
    var property position=game.center() //posicion inicial
    var property objetivo
    var property image = "invi.png" //pra modificarlo
    var property distanciaControl=8
    var property vida=0
    var property velocidad=0
//    var property image = "ene_caminaDelante1.png" //pra modificarlo

  
    var posicionAnt=objetivo.position() //debe ser propio del personaje, cambiar despues
    
     var property estado=1

     
    method perseguir(){ //evaluar camino
        //podemos contemplar un SET y no una lista para que no haya celdas repetidas asi aca llamo o inicio a closeSet con posicion del enemigo
        
        const posicionObjetivo=objetivo.position()

        if(self.perseguible(posicionObjetivo)){
            if(posicionAnt==posicionObjetivo){ //esto para tomar en cuenta q no se haya movido, si lo hizo refrescamos todo y volvemos a analizar: evaluar si realmente funciona
                if(self.position()!=objetivo.position()){ 
                    const posicionDelMenor=capacidad.tomarLaMejorCelda(self.position(),posicionObjetivo) //si esto funciona entonces BUSCADORRUTAS debe tener por dentro todos los vecinos no debe llamarlo enemigo
                    
                    self.cambiarDireccion(posicionDelMenor)
                }else{
                    //recorre
                    console.println("llegate al objetivo")
                    posicionAnt=objetivo.position()

                    capacidad.reiniciarAnalisis(self.position())
                    
                }
            }else{
                console.println("se movio")
                posicionAnt=objetivo.position()
                capacidad.reiniciarAnalisis(self.position())
                
            }
            
            posicionAnt=objetivo.position()
        }else{
            console.println("no seguir xq no esta en el rango")
        }
        
            
        
        
    }
    
    method perseguible(posicionObjetivo)=capacidad.calcularDistanciaEuclidiana(posicionObjetivo, self.position())<=self.distanciaControl()
         //funcion propia del prota no del enemigo
        


    
    method cambiarDireccion(posicionNueva){ //aCTUALIZA POSICION y sprite
    
         /*digamos tengo la posicon (4,6)
        quiero las posiciones (analizando que no hayan sido analizados ó que no esté ahi obstaculos)*/
        /*
            (3,6)
        (4,5)  (4,6)   (4,7)
             (5,6)*/

        //self.cambiarSprite(posicionNueva) POR AHORA luego activarlo
        
        self.position(posicionNueva) //actualizamos su posicon para que se mueva
        
    }


    method animarMovimiento(imagen1,imagen2){
        if (self.estado()==1) {
			self.image(imagen1) //cambiar img
            estado = 2
		} else{
			self.image(imagen2) //cambiar img
			estado = 1
		}	
        
    }

    /*method efectoBala(arma){ //afecta la vida segun arma
        if(self.vida()>0){
            vida=self.vida()-arma.potencia()
        }else{
            self.desaparecer()
        }
    }*/

    method desaparecer(){
        game.removeVisual(self) //sacarlo del tablero
    }

    method cambiarSprite(posicionNueva) //metodo abstracto
    
}

class EnemigoCorredor inherits Enemigo{
    override method vida()=3
    override method velocidad()=50
    override method cambiarSprite(posicionNueva){
        if(posicionNueva.y()==self.position().y()){
            if(posicionNueva.x()>self.position().x()){
                //mover abajo
                
                self.animarMovimiento("ene_caminaDer1.png", "ene_caminaDer2.png")
            }
            if(self.position().x()>posicionNueva.x()){
                //movbver arriba
                self.animarMovimiento("ene_caminaIzq1.png", "ene_caminaIzq2.png")
                
            }
        }
        
        if(posicionNueva.x()==self.position().x()){
            if(posicionNueva.y()<self.position().y()){
                self.animarMovimiento("ene_caminaDelante1.png", "ene_caminaDelante1.png")
            }else{
                self.animarMovimiento("ene_caminaAtras1.png", "ene_caminaAtras2.png")
            }
        }
    }

    
}

class EnemigoZangano inherits Enemigo{
    override method vida()=7
    override method velocidad()=90
    //override method cambiarSprite(posicionNueva)
    //method disparar()
}

class EnemigoGuerrero inherits Enemigo{
    override method vida()=14 //se descuenta cuando les sacas sus capas
    override method velocidad()=120
    //override method cambiarSprite(posicionNueva)
    var property resistenciaCapas=[2,4,6] //vida de cada capa
    //method devolverAtaque() //cada cierto nro de ataques que recibe (random) devuelve el ataque SI ES QUE TIENE CAPAS, sino no
}

class EnemigoHibrido inherits EnemigoGuerrero{ //mescla de guerrero y pretoriano
    override method vida()=24
    
    //override method cambiarSprite(posicionNueva)
    method llamarManada() //"llama" detras de la logica genera zanganos
>>>>>>> origin/main
}