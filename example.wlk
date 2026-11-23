class Pase {
  var costoBase
  const representantes = #{}
  const montoMaximoHipoteca = 10

  method representantes() = representantes

  method tieneAlRepresentante(representante) = self.representantes().contains(representante)

  method cantidadRepresentantes() = self.representantes().size()

  method costoTotal() = costoBase + self.costoExtra()

  method costoExtra()

  method teHipoteca() = self.costoTotal() > montoMaximoHipoteca

  method aumentarCostoBase(cantidad) {
    costoBase += cantidad
  }
}

class Juvenil inherits Pase {
  const tieneClausulaRecompra

  override method costoExtra() = if(tieneClausulaRecompra) 0.5 else 1
}

object joya inherits Pase(costoBase=8) {
  override method representantes() = #{"el Gordo Comisiones", "el Turco Mercadal"}
  
  override method costoExtra()= if(self.cantidadRepresentantes() <= 2) 2 else 0
}

class Paquete inherits Pase {
  const subPases = #{}

  method agregarSubPase(pase) {
    subPases.add(pase)
  }

  override method costoExtra() = subPases.sum({pase => pase.costoExtra()})
}

class Presidente {
  const representantesAmigos = #{}
  const palabrasClave = #{"estadio", "refuerzos", "cuota"}

  method agregarRepresentanteAmigo(representante) {
    representantesAmigos.add(representante)
  }

  method agregarPalabraClave(palabra) {
    palabrasClave.add(palabra)
  }

  method aceptaPropuesta(propuesta) = palabrasClave.any({palabra => propuesta.estaEnDescripcion(palabra)})

  method validarPase(pase, dirigente) {
    if(not representantesAmigos.any({representante => pase.tieneAlRepresentante(representante)})) throw new DomainException(message="El pase debe tener algun representante amigo")
  }
}

object tesorero {
  method validarPase(pase, dirigente) {
    if(not dirigente.plataEnCaja() > pase.costoTotal() * 0.7) throw new DomainException(message="El monto en caja debe ser mayor al 70% del costo total del pase.")
  }

  method aceptaPropuesta(propuesta) = propuesta.esCorta()
}

class Dirigente {
  const pasesFirmados = #{}
  const property plataEnCaja
  var cargo
  const promesas = #{}

  method evaluarPropuesta(propuesta) {
    if(not cargo.aceptaPropuesta(propuesta)) propuesta.extenderAnios(3)

    promesas.add(propuesta)
  }

  method cambiarCargo(nuevoCargo) {
    cargo = nuevoCargo
  }

  method firmarPase(pase) {
    self.validarFondos()
    cargo.validarPase(pase, self)

    pasesFirmados.add(pase)
  }

  method validarFondos() {
    if(not plataEnCaja > 0) throw new DomainException(message="No se puede firmar un pase con la caja vacia")
  }

  method pasesQueHipotecaron() = pasesFirmados.filter({pase => pase.teHipoteca()})

  method devaluar() {
    pasesFirmados.forEach({pase => pase.aumentarCostoBase(0.5)})
  }
}

class Propuesta {
  var fechaCumplimiento
  const fechaPresentacion
  const descripcion

  method extenderAnios(anios) {
    fechaCumplimiento = fechaCumplimiento.plusYears(anios)
  }

  method esCorta() = (fechaCumplimiento - fechaPresentacion) < 30 * 6

  method estaEnDescripcion(palabra) = descripcion.contains(palabra)
}