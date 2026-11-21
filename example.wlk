class Show {
  var costoBase
  const tecnicos = #{}

  method obtenerTecnicos() = tecnicos

  method costoDeProduccionTotal() = costoBase + self.costoExtra()

  method costoExtra()

  method cantidadDeTecnicos() = self.obtenerTecnicos().size()

  method trabajaElTecnicoAca(tecnico) = self.obtenerTecnicos().contains(tecnico)

  method teFunde() = self.costoDeProduccionTotal() > 40

  method aumentarCostoBase(porcentaje) {
    costoBase *= (1 + porcentaje / 100)
  }
}

class Acustico inherits Show {
  const esAlAireLibre

  override method costoExtra() = if(esAlAireLibre) 3 else 1
}

object escenarioPrincipal inherits Show(costoBase=20) {
  const adicionalMaximo = 12
  
  override method obtenerTecnicos() = #{"el Colo del Sonido", "Pocho Ecualizador"}

  override method costoExtra() = (4 * self.cantidadDeTecnicos()).min(adicionalMaximo)
}

class LineUp inherits Show {
  const shows = #{}

  method agregarShow(show) {
    shows.add(show)
  }

  override method costoExtra() = self.obtenerMontoConDescuento(shows.sum({show => show.costoExtra()}))

  method obtenerMontoConDescuento(monto) = monto * 0.75
}

class Pedido {
  const property nombreBanda
  const fechaDeCarga
  var fechaSolicitada

  method correrFechaSolicitada(meses) {
    fechaSolicitada = fechaSolicitada.plusMonths(meses)
  }

  method seRealizoConDiasDeAnticipacion(dias) = (fechaSolicitada - fechaDeCarga) > dias
}

object independiente {
  method puedeContratarShow(show, productor) {
    if(show.costoDeProduccionTotal() > productor.presupuesto()) throw new DomainException(message="No se puede contratar un show cuyo costo supera el presupuesto del productor")
  }

  method puedeAceptarPedido(pedido) = pedido.seRealizoConDiasDeAnticipacion(60)
}

class Multinacionales {
  const tecnicosDeConfianza = #{}
  const bandas = #{}

  method agregarBanda(banda) {
    bandas.add(banda)
  }

  method agregarTecnicoDeConfianza(tecnico) {
    tecnicosDeConfianza.add(tecnico)
  }

  method puedeContratarShow(show, productor) {
    if(not tecnicosDeConfianza.any({tecnico => show.trabajaElTecnicoAca(tecnico)})) throw new DomainException(message="No se puede contratar un show en el que ningun tecnico de confianza que trabaje alli")
  }

  method puedeAceptarPedido(pedido) = bandas.contains(pedido.nombreBanda())
}

class PeriodoDePrueba {
  const puestoAspiracion

  method puedeContratarShow(show, productor) {
    if(not puestoAspiracion.puedeContratarShow(show, productor)) throw new DomainException(message="No se puede contratar el show debido a que el puesto aspiracional no cumple el criterio")

    if(productor.cantidadDeShowsContratados() > 3) throw new DomainException(message="No se puede contratar el show debido a que no puede tener mas de 3.")
  }

  method puedeAceptarPedido(pedido) = puestoAspiracion.puedeAceptarPedido(pedido)
}

class Productor {
  var puesto
  const property presupuesto
  const showsContratados = #{}
  const pedidosDeFecha = #{}

  method agregarFecha(pedido) {
    if(not puesto.puedeAceptarPedido(pedido)) pedido.correrFechaSolicitada(1)

    pedidosDeFecha.add(pedido)
  }

  method cambiarPuesto(nuevoPuesto) {
    puesto = nuevoPuesto
  }

  method cantidadDeShowsContratados() = showsContratados.size()

  method contratarShow(show) {
    self.validarPresupuesto()
    puesto.puedeContratarShow(show, self)

    showsContratados.add(show)
  }

  method validarPresupuesto() {
    if(not presupuesto > 0) throw new DomainException(message="No se puede contratar un show sin presupuesto")
  }

  method showsQueFunden() = showsContratados.filter({show => show.teFunde()})

  method saltoElDolar() {
    showsContratados.forEach({show => show.aumentarCostoBase(10)})
  }
}