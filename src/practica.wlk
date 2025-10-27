class Enemigo {
    var property puntosDeVida
    var property elementoEnemigo

    method recibirAtaque(ataque,potenciaAtaque) {
        puntosDeVida -= ataque.hacerDaño(potenciaAtaque,self)
    }
}

class Heroe {
    var property puntosDeMana   
    var property fuerza
    var property llaveEspada

    method atacarEnemigo(enemigo) {
        enemigo.recibirAtaque(AtaqueFiscoIncorporeo , fuerza + llaveEspada.poderFisico())
    } 

    method lanzarhechizo(hechizo, enemigo) {
        if (puntosDeMana > hechizo.poderBase()) {
            enemigo.recibirAtaque(AtaqueMagico, llaveEspada.poderMagico() + hechizo.poderBase())
            puntosDeMana -= hechizo.poderBase()        
        }
    }  

    method descansar() {
        puntosDeMana = [puntosDeMana,30]
    }

    method cambiarEspada(fisico,magico) {
        llaveEspada = new LlaveEspada(poderFisico = fisico, poderMagico = magico)
    }
}

class LlaveEspada {
    var property poderFisico
    var property poderMagico
}

class Hechizo {
    var property poderBase
    var property tipo
}

class AtaqueFiscoIncorporeo {
  var defensa
  method hacerDaño(potenciaAtaque,objetivo) = [(potenciaAtaque - defensa),1].max()
}

object ataqueFisicoSinCorazon {
  method hacerDaño(potenciaAtaque,objetivo) = [(potenciaAtaque * 0.90),1].max()
}

class AtaqueMagico {
  const elementoAtaque
  method hacerDaño(potencia,objetivo) {
    if ((objetivo.elementoEnemigo() == "fuego" && elementoAtaque == "hielo") || 
        (objetivo.elementoEnemigo() == "hielo" && elementoAtaque == "fuego") || 
        (objetivo.elementoEnemigo() == "luz" && elementoAtaque == "oscuridad") || 
        (objetivo.elementoEnemigo() == "oscuridad" && elementoAtaque == "luz")) {
        return potencia*2
    } 

    else if (objetivo.elementoEnemigo() == elementoAtaque) {
        return 0
    }
    
    else {
        return potencia
    }
  }
}

/*
Opción A (recomendada, mínima y clara): hacer que Heroe cree instancias de ataques antes de pasarlas:
cambiar atacarEnemigo a algo como:
enemigo.recibirAtaque(new AtaqueFiscoIncorporeo(defensa = 0), fuerza + llaveEspada.poderFisico())
cambiar lanzarhechizo a algo como:
enemigo.recibirAtaque(new AtaqueMagico(elementoAtaque = hechizo.tipo), llaveEspada.poderMagico() + hechizo.poderBase())
Esto garantiza que recibirAtaque reciba un objeto con hacerDaño
*/

