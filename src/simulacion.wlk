import personas.*
import manzanas.*

object simulacion {
	var property diaActual = 0
	const property manzanas = []
	
	// parametros del juego
	const property chanceDePresentarSintomas = 30
	const property chanceDeContagioSinCuarentena = 25
	const property chanceDeContagioConCuarentena = 2
	const property personasPorManzana = 10
	const property duracionInfeccion = 20

	/*
	 * este sirve para generar un azar
	 * p.ej. si quiero que algo pase con 30% de probabilidad pongo
	 * if (simulacion.tomarChance(30)) { ... } 
	 */ 	
	method avanzarDia() = { diaActual += 1 }
	 
	method informarDia(){return "Dia " + self.diaActual()}
	
    method tomarChance(porcentaje) = 0.randomUpTo(100) < porcentaje

	method agregarManzana(manzana) { manzanas.add(manzana) }
	
   	method debeInfectarsePersona(persona, cantidadContagiadores) {
		const chanceDeContagio = if (persona.respetaCuarentena()) 
			self.chanceDeContagioConCuarentena() 
			else 
			self.chanceDeContagioSinCuarentena()
		return (1..cantidadContagiadores).any({n => self.tomarChance(chanceDeContagio) })	
	 }
	
	
	method debePresentarSintomasPersona(persona){
		return self.tomarChance(chanceDePresentarSintomas)
	 }

	method crearManzana() {
		const nuevaManzana = new Manzana()
		(1..self.personasPorManzana()).forEach({n => nuevaManzana.poblar()})
		return nuevaManzana
		// agregar la cantidad de personas segun self.personasPorManzana()
	}
	
	method totalDePersonas(){
		return manzanas.sum({manzana => manzana.cuantaGenteVive()})
	}
	
	method reportarTotalDePersonas(){
		return "Personas " + self.totalDePersonas()
	}
	
	method totalDeInfectados(){
		return manzanas.sum({manzana => manzana.cantidadDeInfectados()})
	}
	
	method reportarTotalDeInfectados(){
		return "Infectades " + self.totalDeInfectados()
	}
	
	method totalDeGenteConSintomas(){
		return manzanas.sum({manzana => manzana.cantidadDeGenteConSintomas()})
	}
	
	method reportarTotalDeGenteConSitomas(){
		return "Con sintomas " + self.totalDeGenteConSintomas()
	}
	
	method totalDeGenteAislada(){
		return manzanas.sum({manzana => manzana.cantidadDeGenteAislada()})
	}
	
	method reportarTotalDeGenteAislada(){
		return "Aislades " + self.totalDeGenteAislada()
	}
	
	method totalDeGenteQueRespetaCuarentena(){
		return manzanas.sum({manzana => manzana.cantidadDeGenteQueRespetaCuarentena()})
	}
	
	method reportarTotalDeGenteQueRespetaCuarentena(){
		return "Respetan cuarentena " + self.totalDeGenteQueRespetaCuarentena()
	}
	
	method totalDeGenteRecuperada(){
		return manzanas.sum({manz => manz.cantidadDeRecuperados()})
	}
	
	method reportarTotalDeGenteRecuperada(){return "Recuperados " + self.totalDeGenteRecuperada()}
	
	method reporte(){
		return "Personas " + self.totalDePersonas() + " infectados " 
		+ self.totalDeInfectados() + " con sintomas " + self.totalDeGenteConSintomas() + " aislados " + self.totalDeGenteAislada() 
		+ " respetan cuarentena " + self.totalDeGenteQueRespetaCuarentena()
	}
	
	
	
	method agregarCasoImportadoAlAzar(){
		const runnerAnarquista = new Persona(contagiado = true, seInfectoDia = self.diaActual())
		manzanas.anyOne().agregarViajero(runnerAnarquista)
	}
	
	method simularUnDiaEnManzanas(){
		manzanas.forEach({manzana => manzana.pasarUnDia()})
	}
	
	method manzanaEnPosicion(unaPosicion){return manzanas.find({manzana => manzana.position() == unaPosicion})}
	
	
}


