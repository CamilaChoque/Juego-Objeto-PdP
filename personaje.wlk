import elementos.*
import mapas.mapa2
object personaje inherits Obstaculo {
   var property image = "personaje.png"
   	method configurarTeclas() { 

		
		//Left
		keyboard.a().onPressDo({
			position=position.left(1)})
			
		//right
		keyboard.d().onPressDo({			
			position=position.right(1)
		})
		//down
		keyboard.s().onPressDo({ 
			position=position.down(1)
		})
		//up
		keyboard.w().onPressDo({
			position=position.up(1)
		})
	}

	//method cambiarDeHabitacion() {
	//  mapa2.cargar()
	//}
}
   

