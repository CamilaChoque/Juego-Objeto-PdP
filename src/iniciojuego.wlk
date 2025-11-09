import mapas.*
import personaje.*
import elementos.*
import enemigo.*

object juego{ //si es muy pequeño añadir acá los menus pasando a llamarse "configuración"
    method iniciar(){
      var activo = true 
      game.addVisual(inicio)
      keyboard.space().onPressDo{if(activo==true){mapa1.cargainicial() activo=false}} 
      }
   // method estaAlLimite(posX,posY)=game.width()<posX || game.height()<posY || posX<0 || posY<0 //si se pasa del tablero tanto negativo o fuera del rango
}