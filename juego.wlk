import mapas.*
import personaje.*
import elementos.*
import enemigo.*

object juego{ //si es muy pequeño añadir acá los menus pasando a llamarse "configuración"
    method iniciar(){
      var activo = true 
      game.addVisual(inicio)
      keyboard.space().onPressDo{if(activo==true){mapainicial.carga1() activo=false}} 
      }
}