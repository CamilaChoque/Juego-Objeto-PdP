import juego.*
import elementos.*

class Enemigo{
    //const caminataAtras=["ene_caminaAtras1.png","ene_caminaAtras2.png"]
    var property esObstaculo=false
    var property capacidad = buscadorRutas  //te da todos los vecinos , mide dist euclideana
    var property position=game.center() //posicion inicial
    var property objetivo
    var property image = "invi.png" //pra modificarlo
    var property distanciaControl=4
    var property vida=0
    var property velocidad=0
    var property referenciaDeCaminata=self.position()
    var indice=0 //luego chequear como hacerlo mejor
    var property limiteCantidad=[] //lista usada en clase MAPAS pasa saber cuantos puedo instanciar segun tipo enemigo
//    var property image = "ene_caminaDelante1.png" //pra modificarlo

  
    var posicionAnt=objetivo.position() //debe ser propio del personaje, cambiar despues
    
     var property estado=1

     
    method perseguir(){ //evaluar camino
    console.println("persiguiendo")
        //podemos contemplar un SET y no una lista para que no haya celdas repetidas asi aca llamo o inicio a closeSet con posicion del enemigo
        //console.println("ahora es velocidad: "+self.velocidad())
        const posicionObjetivo=objetivo.position()

        if(self.perseguible(posicionObjetivo)){
            if(posicionAnt==posicionObjetivo){ //esto para tomar en cuenta q no se haya movido, si lo hizo refrescamos todo y volvemos a analizar: evaluar si realmente funciona
                if(self.position()!=objetivo.position()){ 
                    self.velocidad(50)
                    const posicionDelMenor=capacidad.tomarLaMejorCelda(self.position(),posicionObjetivo) //si esto funciona entonces BUSCADORRUTAS debe tener por dentro todos los vecinos no debe llamarlo enemigo
                    
                    self.cambiarDireccion(posicionDelMenor)
                }else{
                    //recorre
                    //console.println("llegate al objetivo")
                    posicionAnt=objetivo.position()
                    self.referenciaDeCaminata(self.position())
                    capacidad.reiniciarAnalisis()
                    
                }
            }else{
                //console.println("se movio")
                posicionAnt=objetivo.position()
                capacidad.reiniciarAnalisis()
                
            }
            
            posicionAnt=objetivo.position()
        }else{
            
            self.caminar()
            
            
            //console.println("no seguir xq no esta en el rango")
        }
        
            
        
        
    }
    
    method perseguible(posicionObjetivo)=capacidad.calcularDistanciaEuclidiana(posicionObjetivo, self.position())<=self.distanciaControl()
         //funcion propia del prota no del enemigo
    
    method caminar(){
        if(indice==30){ //40 porque 40*50=2000ms
            capacidad.openSet(self.position().x(), self.position().y())

            const elegido=capacidad.openSet().anyOne() //para que me traiga uno random
            const posicionPropuesta=game.at(elegido.first(),elegido.last())
            //console.println("posicion referencia: "+self.referenciaDeCaminata())
            if(capacidad.calcularDistanciaEuclidiana(self.referenciaDeCaminata(), posicionPropuesta)<=self.distanciaControl()){
                self.cambiarDireccion(posicionPropuesta)
                capacidad.reiniciarAnalisis()
                
            }else{
                //console.println("NO PODES PASAR MAS")
                
            }
            indice=0
        }
         indice+=1 

    }


    
    method cambiarDireccion(posicionNueva){ //aCTUALIZA POSICION y sprite
    
         /*digamos tengo la posicon (4,6)
        quiero las posiciones (analizando que no hayan sido analizados ó que no esté ahi obstaculos)*/
        /*
            (3,6)
        (4,5)  (4,6)   (4,7)
             (5,6)*/

        //self.cambiarSprite(posicionNueva) POR AHORA luego activarlo - NO BORRAR
        
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
    override method limiteCantidad()=[3,4,5]
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

    method atacar(){
        
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

    
}

/*
crear  en mapas

generarEnemigos
limkiteCantidad=[3..5]
tope=enemigo.limiteCantidad().anyOne

[1..tope].forEach({=>
    new EnemigoCorredor(vida=3,objetivo=caja)
        
})


*/