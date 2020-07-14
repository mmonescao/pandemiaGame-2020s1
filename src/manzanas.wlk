import personas.*
import simulacion.*
import wollok.game.*

class Manzana {
	const property personas = []
	var property position
	
	method image() {
        if(self.cantidadDeInfectados() == personas.size()){return "rojo.png"}
    else if(self.cantidadDeInfectados().between(7,personas.size())){return "naranjaOscuro.png"}
    else if(self.cantidadDeInfectados().between(4,7)){return "naranja.png"}
    else if(self.cantidadDeInfectados().between(1,3)){return "amarillo.png"}
        // reeemplazarlo por los distintos colores de acuerdo a la cantidad de infectados
        // también vale reemplazar estos dibujos horribles por otros más lindos
        else return "blanco.png"
    }

	method cuantaGenteVive(){return personas.size()}
	
	method cantidadDeInfectados(){return personas.count({p => p.estaInfectada()}) }
	
	method cantidadDeGenteConSintomas(){return personas.count({p => p.presentaSintomas()}) }
	
	method cantidadDeGenteAislada(){return personas.count({p => p.aislade()}) }
	
	method cantidadDeGenteQueRespetaCuarentena(){return personas.count({p => p.respetaCuarentena()}) }
	
	method poblar(){
		const nuevaPersona = new Persona()
		personas.add(nuevaPersona)
	}
	
	// este les va a servir para el movimiento
	method esManzanaVecina(manzana) {
		return manzana.position().distance(position) == 1
	}

	method pasarUnDia() {
		self.transladoDeUnHabitante()
		self.simulacionContagiosDiarios()
		self.curarAQuienesCumplieronElCiclo()
		// despues agregar la curacion
	}
	
	method personaSeMudaA(persona, manzanaDestino) {
		manzanaDestino.agregarViajero(persona)
		personas.remove(persona)
	}
	
	method cantidadContagiadores() {
		return personas.count({p => p.estaInfectada() and not p.estaAislada()})
	}
	
	method noInfectades() {
		return personas.filter({ pers => not pers.estaInfectada() })
	}
	
	method infectades(){
		return personas.filter({pers => pers.estaInfectada()})
	}
	
	method infectadesYConSintomas(){
		return self.infectades().filter({pers => pers.presentaSintomas()})
	} 	
	
	method infectadesQueCumplieronCiclo(){
		return self.infectades().filter({pers => pers.cumplioCiclo()})
	}

	method cantidadDeRecuperados(){
		return personas.count({pers => pers.seRecupero()})
	}
	
	method simulacionContagiosDiarios() { 
		const cantidadContagiadores = self.cantidadContagiadores()
		if (cantidadContagiadores > 0) {
			self.noInfectades().forEach({ persona => 
				(1..cantidadContagiadores).forEach({n => if (simulacion.debeInfectarsePersona(persona, cantidadContagiadores)) {
					persona.infectarse()
					if(simulacion.debePresentarSintomasPersona(persona)){
						persona.presentarSintomas()
						}
					}
				})
			})
		}
	}
	
	method transladoDeUnHabitante() {
		const quienesSePuedenMudar = personas.filter({ pers => not pers.estaAislada() })
		if (quienesSePuedenMudar.size() > 2) {
			const viajero = quienesSePuedenMudar.anyOne()
			const destino = simulacion.manzanas().filter({ manz => self.esManzanaVecina(manz) }).anyOne()
			self.personaSeMudaA(viajero, destino)			
		}
	}
	
	method curarAQuienesCumplieronElCiclo(){
		self.infectadesQueCumplieronCiclo().forEach({pers => pers.curar()})
	}
	
	method agregarViajero(unViajero){personas.add(unViajero)}
	
	
}


