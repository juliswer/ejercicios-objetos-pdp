class Causa {
  const property caratula
  const juecesPropios = #{}
  var montoBase 

  method agregarJuez(nuevoJuez) {
    juecesPropios.add(nuevoJuez)
  }

  method jueces() = juecesPropios

  method perjuicioEconomicoTotal() = montoBase + self.montoExtra()

  method cantidadJueces() = self.jueces().size()

  method montoExtra()

  method incrementarMontoBase(cantidad) {
    montoBase += cantidad
  }

  method esTrambolika() = self.perjuicioEconomicoTotal() > 5
}

object kometa {
}

object nacausa {
}

object garantis {
}

object juecesDeObraPublica {
  const property jueces = #{kometa, garantis}
}

class CausaSoborno inherits Causa {
  var property hayArrepentidos = false

  override method montoExtra() = if(hayArrepentidos) 1 else 2
}

class CausaObraPublica inherits Causa(montoBase=3) {
  override method jueces() = juecesDeObraPublica.jueces()
  override method montoExtra() = if(self.tienePocosJueces()) 2 else 0

  method tienePocosJueces() = self.cantidadJueces() <= 2
}

class CausaCompleja inherits Causa {
  const subCausas = []

  method agregarSubCausa(subCausa) {
    subCausas.add(subCausa)
  }

  override method montoExtra() = subCausas.sum({subCausa => subCausa.montoExtra()})
}

class Propuesta {
  const property descripcion
  const fechaPresentacion
  const fechaCumplimiento

  method esCorta() = fechaCumplimiento < fechaPresentacion.plusYears(1)

  method propuestaPateada() = new Propuesta(descripcion=descripcion, fechaPresentacion=fechaPresentacion, fechaCumplimiento=fechaCumplimiento.plusYears(4))

  method mencionaAlgunaDe(palabras) = palabras.any({ palabra => descripcion.contains(palabra) })
}

class Puesto {
  method puedeComerseUnaCausa(causaProbable, funcionario)
  method puedeAceptarPropuesta(propuesta)
}

object poderEjecutivo inherits Puesto {
  const palabrasClave = #{"aumento", "impuestos", "inflación"}

  method agregarPalabraClave(palabra) {
    palabrasClave.add(palabra)
  }

  override method puedeComerseUnaCausa(causaProbable, funcionario) = causaProbable.jueces().any({ juez => funcionario.esAmigoDe(juez) })

  override method puedeAceptarPropuesta(propuesta) = propuesta.mencionaAlgunaDe(palabrasClave)
}

object ministro inherits Puesto {
  override method puedeComerseUnaCausa(causaProbable, funcionario) = funcionario.patrimonioActual() > (causaProbable.perjuicioEconomicoTotal() / 2)

  override method puedeAceptarPropuesta(propuesta) = propuesta.esCorta()
}

class FuncionarioPublico {
  const causas = #{}
  const juecesAmigos = #{}
  const property patrimonioActual
  var property puesto
  const promesas = #{}

  method escucharPropuesta(propuesta) {
    const promesa = if(puesto.puedeAceptarPropuesta(propuesta)) propuesta else propuesta.propuestaPateada()

    promesas.add(promesa)
  }

  method esAmigoDe(juez) = juecesAmigos.contains(juez)

  method comerseUnaCausa(causaProbable) {
    if(not self.tienePlata()) {
      throw new DomainException(message="No puede comerse una causa alguien sin un mango")
    }

    if(not puesto.puedeComerseUnaCausa(causaProbable, self)) {
      throw new DomainException(message="No puede comerse esta causa")
    }
    
    causas.add(causaProbable)
  }

  method causasQueLoDejanPegado() = causas.filter({causa => causa.esTrambolika()})

  method salirEnMedios() {
    causas.forEach({causa => causa.incrementarMontoBase(0.1)})
  }

  method tienePlata() = patrimonioActual > 0
}