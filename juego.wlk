
import elementos.*
import enemigo.*

object juego{ //si es muy pequeño añadir acá los menus pasando a llamarse "configuración"
    const enemigo_ = new enemigo()
    method iniciar(){
        game.addVisualCharacter(caja)
        game.addVisual(enemigo_)
        game.addVisual(obstaculo)
        
        game.onTick(1000, "seguimiento", {enemigo_.perseguir(caja)})
    }
}