class Excursion {
  var costoBase
  const coordinadores = #{}

  method coordinadores() = coordinadores

  method cantidadCoordinadores() = self.coordinadores().size()

  method costoTotal() = costoBase + self.costoAdicional()

  method aumentarCostoBase(monto) {
    costoBase += monto
  }

  method estaElCoordinador(coordinador) = coordinadores.contains(coordinador)

  method costoAdicional()

  method esNocturna()
}

class Boliche inherits Excursion {
  const esNocheTematica

  override method costoAdicional() = if(esNocheTematica) 20 else 5

  override method esNocturna() = true
}

object excursionCerroCatedral inherits Excursion(costoBase=50) {
  const cantidadMinimaCoordinadores = 3
  const adicionalConPocosCoordinadores = 15
  const adicionalConVariosCoordinadores = 0

  override method coordinadores() = #{"el Rulo", "Maxi Boliche"}

  override method costoAdicional() = if(self.hayPocosCoordinadores()) adicionalConPocosCoordinadores else adicionalConVariosCoordinadores

  method hayPocosCoordinadores() = self.cantidadCoordinadores() < cantidadMinimaCoordinadores

  override method esNocturna() = false
}

class Circuito inherits Excursion {
  const excursiones = #{}

  method agregarExcursion(excursion) {
    excursiones.add(excursion)
  }

  override method costoAdicional() = excursiones.sum({excursion => excursion.costoAdicional()}) / self.cantidadExcursiones()

  method cantidadExcursiones() = excursiones.size()

  override method esNocturna() = excursiones.any({excursion => excursion.esNocturna()})
}

object ahorrador {
  method noPuedeRealizarExcursion(excursion, egresado) = excursion.costoTotal() > egresado.plataAhorrada() * 0.4

  method validarExcursion(excursion, egresado) {
    if(self.noPuedeRealizarExcursion(excursion, egresado)) throw new DomainException(message="El costo de la excursion no puede superar el 40% de los ahorros del egresado")
  }
}

object fiestero {
  method noPuedeRealizarExcursion(excursion, egresado) = not excursion.esNocturna()

  method validarExcursion(excursion, egresado) {
    if(self.noPuedeRealizarExcursion(excursion, egresado)) throw new DomainException(message="La excursion debe ser noctura para poder anotarse")
  }
}

class Indeciso {
  var aceptoUltimaExcursion = false

  method noPuedeRealizarExcursion(excursion, egresado) = aceptoUltimaExcursion

  method validarExcursion(excursion, egresado) {
    const rechazarExcursion = self.noPuedeRealizarExcursion(excursion, egresado)
    aceptoUltimaExcursion = not aceptoUltimaExcursion
    if(rechazarExcursion) throw new DomainException(message="La ultima excursion ya fue aceptada, por lo que la actual no puede serlo")
  }
}

class Combinacion {
  const criterios = #{}

  method agregarCriterio(criterio) {
    criterios.add(criterio)
  }

  method noPuedeRealizarExcursion(excursion, egresado) = criterios.any({criterio => criterio.noPuedeRealizarExcursion(excursion, egresado)})

  method validarExcursion(excursion, egresado) {
    if(self.noPuedeRealizarExcursion(excursion, egresado)) throw new DomainException(message="Todos los criterios deben cumplir para acceder a la excursion")
  }
}

object juli {
  method laPasaBien(egresado) = true
}

object santi {
  method laPasaBien(egresado) = egresado.tieneAlgunaExcursionNoctura()
}

object cami {
  method laPasaBien(egresado) = egresado.tieneMasDeLaMitadDeLaPlata()
}

object colo {
  method laPasaBien(egresado) = egresado.estaCoordinadorEnAlgunaExcursion("el Rulo")
}


class Egresado {
  const property excursiones = #{}
  const estaAutorizado
  const plataInicial
  var criterioDeEleccion
  var plataAhorrada
  var criterioSentimiento

  method cambiarCriterioDeSentimiento(criterio) {
    criterioSentimiento = criterio
  }

  method plataAhorrada() = plataAhorrada

  method cambiarCriterioDeEleccion(criterio) {
    criterioDeEleccion = criterio
  }

  method estaCoordinadorEnAlgunaExcursion(coordinador) = excursiones.any({excursion => excursion.estaElCoordinador(coordinador)})

  method tieneAlgunaExcursionNoctura() = excursiones.any({excursion => excursion.esNocturna()})

  method tieneMasDeLaMitadDeLaPlata() = plataAhorrada > plataInicial * 0.5

  method estaSeco() = plataAhorrada < self.montoDeExcursionMasBarata()

  method montoDeExcursionMasBarata() = (excursiones.map({excursion => excursion.costoTotal()})).min()

  method registrarLluvia() {
    excursiones.forEach({excursion => excursion.aumentarCostoBase(5)})
  }

  method descontarPlataAhorrada(monto) {
    plataAhorrada -= monto
  }

  method anotarse(excursion) {
    self.validarAutorizacion()
    criterioDeEleccion.validarExcursion(excursion, self)

    self.descontarPlataAhorrada(excursion.costoTotal())
    excursiones.add(excursion)
  }

  method laEstaPasandoBien() = self.estaEnAlMenosExcursiones(2) and criterioSentimiento.laPasaBien(self)

  method estaEnAlMenosExcursiones(cantidad) = self.cantidadExcursiones() >= cantidad

  method cantidadExcursiones() = excursiones.size()

  method validarAutorizacion() {
    if(not estaAutorizado) throw new DomainException(message="El egresado debe estar autorizado para realizar una excursion")
  }
}