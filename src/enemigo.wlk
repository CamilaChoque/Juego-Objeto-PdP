import juego.*
import elementos.*
import Personajes.personaje.*
class Enemigo{
    //const caminataAtras=["ene_caminaAtras1.png","ene_caminaAtras2.png"]
    var property esObstaculo=false
    var property danio=0
    var property capacidad = buscadorRutas  //te da todos los vecinos , mide dist euclideana
    var property position=game.center() //posicion inicial
    var property objetivo=personaje
    var property image = ""
    //var property image = "invi.png" //pra modificarlo
    var property distanciaControl=5
    var property vida=0
    var property velocidad=0
    var property referenciaDeCaminata=self.position()
    var indice=0 //luego chequear como hacerlo mejor
    var property estado=1
    method cantidadManada()=[1,2].anyOne() //cant que puede haber en un nivel, invoca un random
//    var property image = "ene_caminaDelante1.png" //pra modificarlo

  
    var posicionAnt=objetivo.position() //debe ser propio del personaje, cambiar despues
    
     

    method estaEnCelda(posX, posY) = self.position().x() == posX and self.position().y() == posY
     
    method perseguir(){ //evaluar camino
    //console.println("persiguiendo")
        
        //self.verificarAmenaza()
        
        //podemos contemplar un SET y no una lista para que no haya celdas repetidas asi aca llamo o inicio a closeSet con posicion del enemigo
        //console.println("ahora es velocidad: "+self.velocidad())
        const posicionObjetivo=objetivo.position()

        if(self.perseguible(posicionObjetivo)){
            if(posicionAnt==posicionObjetivo){ //esto para tomar en cuenta q no se haya movido, si lo hizo refrescamos todo y volvemos a analizar: evaluar si realmente funciona
                if(self.position()!=objetivo.position()){ 
                    //self.velocidad(50)
                    const posicionDelMenor=capacidad.tomarLaMejorCelda(self.position(),posicionObjetivo) //si esto funciona entonces BUSCADORRUTAS debe tener por dentro todos los vecinos no debe llamarlo enemigo
                    
                    self.cambiarDireccion(posicionDelMenor)
                }else{
                    //recorre
                    //console.println("llegate al objetivo")
                    posicionAnt=objetivo.position()
                    self.referenciaDeCaminata(self.position())
                    capacidad.reiniciarAnalisis()
                    self.atacar()
                    
                }
            }else{
                //console.println("se movio")
                posicionAnt=objetivo.position()
                capacidad.reiniciarAnalisis()
                
            }
            
            posicionAnt=objetivo.position()
        }else{
            
            self.caminar()
        }
        
            
        
        
    }
    
    method perseguible(posicionObjetivo)=capacidad.calcularDistanciaEuclidiana(posicionObjetivo, self.position())<=self.distanciaControl()
         //funcion propia del prota no del enemigo
    
    method caminar(){

        if(indice==25){ //40 porque 30*50=1500ms
            capacidad.openSet(self.position().x(), self.position().y())

            const elegido=capacidad.openSet().anyOne() //para que me traiga uno random
            const posicionPropuesta=game.at(elegido.first(),elegido.last())
            //console.println("posicion referencia: "+self.referenciaDeCaminata())
            if(capacidad.calcularDistanciaEuclidiana(self.referenciaDeCaminata(), posicionPropuesta)<=self.distanciaControl()){
                self.cambiarDireccion(posicionPropuesta)
                capacidad.reiniciarAnalisis()
                
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

        self.cambiarSprite(posicionNueva) 
        
        self.position(posicionNueva) //actualizamos su posicon para que se mueva
        
    }


    method animarMovimiento(imagen1,imagen2,imagen3,imagen4){
        if (self.estado()==1) {
			
            self.image(imagen1) //cambiar img
            self.estado(2)
		} else if(self.estado()==2){
			self.image(imagen2) //cambiar img
			self.estado(3)
		}else if(self.estado()==3){
            self.image(imagen3) //cambiar img
			self.estado(4)
        }else{
            self.image(imagen4) //cambiar img
			self.estado(1)
        }	
        
    }

    /*method efectoBala(arma){ //afecta la vida segun arma
        if(self.vida()>0){
            vida=self.vida()-arma.potencia()
        }else{
            self.desaparecer()
        }
    }*/

    
    method recibirDanio(bala){
        self.vida()-1
            //self.vida()-bala.damage() implemaentar sabiendo danio bala
    }
    method desaparecer(){
        game.removeVisual(self) //sacarlo del tablero
    }

    method atacar(){
        console.println("danio al personaje")
        //objetivo.recibirDanio(self.danio())
    }
    method cambiarSprite(posicionNueva)
    
}

class EnemigoCorredor inherits Enemigo{
    override method danio()=1
    override method vida()=3
    override method velocidad()=50
    
    override method cambiarSprite(posicionNueva){
        if(posicionNueva.y()==self.position().y()){
            if(posicionNueva.x()>self.position().x()){
                //mover der
                
                self.animarMovimiento("ene1_Der1.png", "ene1_Der2.png","ene1_Der3.png","ene1_Der4.png")
            }
            if(self.position().x()>posicionNueva.x()){
                //movbverizq
                self.animarMovimiento("ene1_Izq1.png", "ene1_Izq2.png","ene1_Izq3.png","ene1_Izq4.png")
                
            }
        }
        
        if(posicionNueva.x()==self.position().x()){
            if(posicionNueva.y()<self.position().y()){
                //mover delante
                self.animarMovimiento("ene1_Atr1.png", "ene1_Atr2.png","ene1_Atr3.png","ene1_Atr4.png")
            }else{
                //mover atras
                self.animarMovimiento("ene1_Frent1.png", "ene1_Frent2.png","ene1_Frent3.png","ene1_Frent4.png")
            }
        }
    }

    
}

class EnemigoZangano inherits Enemigo{
    override method danio()=[1,2].anyOne()
    override method vida()=5
    override method velocidad()=70
    //method disparar()
    override method cambiarSprite(posicionNueva){
        if(posicionNueva.y()==self.position().y()){
            if(posicionNueva.x()>self.position().x()){
                //mover der
                
                self.animarMovimiento("ene2_der1.png", "ene2_der2.png","ene2_der3.png","ene2_der4.png")
            }
            if(self.position().x()>posicionNueva.x()){
                //movbverizq
                self.animarMovimiento("ene2_izq1.png", "ene2_izq2.png","ene2_izq3.png","ene2_izq4.png")
                
            }
        }
        
        if(posicionNueva.x()==self.position().x()){
            if(posicionNueva.y()<self.position().y()){
                //mover delante
                self.animarMovimiento("ene2_atr1.png", "ene2_atr2.png","ene2_atr3.png","ene2_atr4.png")
                
            }else{
                //mover atras
                self.animarMovimiento("ene2_frent1.png", "ene2_frent2.png","ene2_frent1.png","ene2_frent2.png")
            }
        }
    }

    override method recibirDanio(bala){
        if(bala.esComun()){
                self.devolverDisparo(bala)
        }else{
                self.recibirDanio(bala)
        }
    }
    method devolverDisparo(bala){
        objetivo.recibirDanio(bala)
    }
}


object enemigoHibrido inherits Enemigo{ //mescla de guerrero y pretoriano
    //override method danio()= [1,2,3].anyOne()
    var property manada=[] //ES TEMPORAL , como no se implemento en el nivel 1, hay que analizar su importante en ser LISTA
    //override method vida()=0
    //override method velocidad()=0
    //no tiene cantManada xq solo es 1

    //override method cantidadManada()=[]
    //override method cambiarSprite(posicionNueva)
    //game.at(1,2).isEmpty()
    
    method generarManadas(lugar){
        manada.clear()
        const enemigos=[1,2]
        //const tipoEnemigo = self.crearEnemigoTipo(id)
        self.generarTipoManada(enemigos.anyOne(),lugar) 
    }
    method generarTipoManada(id,lugar){ 
        const tope = self.cantidadManada()
        tope.times{
            
            //manada.add(self.crearEnemigoTipo(id))
            //self.position(lugar.generarPosicionLibreRandom()) //ESPERAR QUE BRUNO
            game.addVisual(self.crearEnemigoTipo(id))
        }
    } 
    method crearEnemigoTipo(tipoEnemigo){
        if(tipoEnemigo==1){
            return new EnemigoCorredor()
        }else{
            return new EnemigoZangano()
        }
    }
    override method cambiarSprite(posicionNueva){}
    
}

