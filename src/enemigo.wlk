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
    var property image = "invi.png" //pra modificarlo
    var property distanciaControl=4
    var property vida=0
    var property velocidad=0
    var property referenciaDeCaminata=self.position()
    var indice=0 //luego chequear como hacerlo mejor
    method cantidadManada()=[3,4].anyOne() //cant que puede haber en un nivel, invoca un random
//    var property image = "ene_caminaDelante1.png" //pra modificarlo

  
    var posicionAnt=objetivo.position() //debe ser propio del personaje, cambiar despues
    
     var property estado=1

     
    method perseguir(){ //evaluar camino
    //console.println("persiguiendo")
        
        self.verificarAmenaza()
        
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
            
            
            //console.println("no seguir xq no esta en el rango")
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

    method verificarAmenaza(){
        game.onCollideDo(self, {objeto=>{
            if(objeto.className()=="Arma"){
                self.recibirDanio(objeto)
            } //adaptarlo al nombre que le ponga bruno
        }})

        game.onCollideDo(self, {objeto=>{
            if(objeto.className()=="Arma"){
                self.recibirDanio(objeto)
            } //adaptarlo al nombre que le ponga bruno
        }})
    }
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
    method cambiarSprite(posicionNueva) //metodo abstracto
    
}

class EnemigoCorredor inherits Enemigo{

    override method danio()=1
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
    override method danio()=[1,2].anyOne()
    override method vida()=5
    override method velocidad()=70
    override method cambiarSprite(posicionNueva){
        console.println("2")
    }
    //override method cambiarSprite(posicionNueva)
    //method disparar()
}

class EnemigoGuerrero inherits Enemigo{
    override method danio()= [1,2,3].anyOne()
    override method vida()=8 //se descuenta cuando les sacas sus capas
    override method velocidad()=90
    //override method cambiarSprite(posicionNueva) //existe pero hay que implementar img
    override method cambiarSprite(posicionNueva){
        console.println("3")
    }
    var property resistenciaCapas=[2,4] //vida de cada capa
    override method cantidadManada()=[2,3].anyOne()
    
    //lo de abajo funcionará cuando existe ESCOMUN() en bala , es un atributo BOOL que dice de cada arma es comun o no ->el arma estandar es comun
    /*override method recibirDanio(bala){
        if(resistenciaCapas.size()==0){
            super(bala)
        }else{
            if(bala.esComun()){
                self.devolverDisparo(bala)
            }else{
                self.danioCapas(bala)
            }
        }
    }*/

    method danioCapas(bala){
        //descuencta vida capas hata que sea []
        resistenciaCapas.last()-1
        //self.resistenciaCapas[index]=self.resistenciaCapas[index]-bala.damage()  implementarlo cuando tenga estructura bala
        if(resistenciaCapas.last()==0){
            resistenciaCapas.remove(resistenciaCapas.last())
        }
    }
    method devolverDisparo(bala){
        objetivo.recibirDanio(bala)
    }
}

object enemigoHibrido inherits EnemigoGuerrero{ //mescla de guerrero y pretoriano
    var property manada=[] //ES TEMPORAL , como no se implemento en el nivel 1, hay que analizar su importante en ser LISTA
    override method vida()=12
    //no tiene cantManada xq solo es 1

    override method cantidadManada()=[]
    //override method cambiarSprite(posicionNueva)
    
    method generarManadas(){
        const enemigos=[1,2,3]
        const id=enemigos.anyOne()
        const tipoEnemigo = self.crearEnemigoTipo(id)
        self.generarTipoManada(tipoEnemigo,id) //segun el tipo genera-lo que tiene que recibir por parametro esta funcion es segun el NIVEL, si el nivel es 1 solo admite corredores-zanganos | nivel 2 : zanganos e hibridos - nivel 3 cualquiera

        /*
        - el propio nivel debe tener su enemigosPermitidos -> const enemigos=[1,2,3] será reemplazado x ese atributo
        nivel1: [1,2]
        nivel2:[2.3]
        nivel3:[1,2,3]

        - dentro del nivel DEBE TENER UNA FUNCION DONDE RECORRAR CADA HABITACION y llame a generarManada pasando el nivel que corresponde x parametro, generarMANADA te devuelve mandasGeneradas random para esa habitacion
        - el nivel debe tener un atributo duenio que sera enemigoHibrido para que asi el nivcel acceda a estos atributos
        */
    }
    //lo comentado parecer que es lo mismo crear generarMandas que lo de abajo
    /*method generarCorredores(){
        const enemigo = self.crearEnemigoTipo(1)
        self.generarManada(enemigo, 1)
    }
    method generarZanganos(){
        const enemigo = self.crearEnemigoTipo(2)
        self.generarManada(enemigo, 2)
    }
    method generarGuerreros(){
        const enemigo = self.crearEnemigoTipo(3)
        self.generarManada(enemigo, 3)
    }*/

    method generarTipoManada(tipoEnemigo,id){ //"llama" detras de la logica genera zanganos
        const tope = tipoEnemigo.cantidadManada()
        tope.times{
            manada.add(self.crearEnemigoTipo(id))
        }
    } 
    method crearEnemigoTipo(tipoEnemigo){
        if(tipoEnemigo==1){
            return new EnemigoCorredor()
        }else if(tipoEnemigo==2){
            return new EnemigoZangano()
        }else{
            return new EnemigoGuerrero()
        }
    }

    
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