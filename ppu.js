import _ from 'lodash';
import _variables from './variables.json' assert { type: 'json' };
import _letterDvDb from './letterDvDB.json' assert { type: 'json' };

class Ppu {
  constructor (ppu) {
    this.ppu = ppu;
    this.format = this.verifyPpuType(ppu);
    this.numbers = this.transformInPreNumber(this);
    this.dv = this.calculateDv(this);
  }

  verifyPpuType (ppu) {
    if (ppu.length !== _variables.MAX_LENGTH) {
      throw new Error("La patente(ppu) ingresada es de largo inválido")
    }

    // New Moto Format
    if (this.constructor.isMotoNew(ppu)) {
      return _variables.motoNewFormat;
    }

    // Old Moto Format
    if (this.constructor.isMotoOld(ppu)) {
      return _variables.motoOldFormat;
    }

    // New Auto Format
    if (this.constructor.isAutoMovilNew(ppu)) {
      return _variables.autoNewFormat;
    }
    // Old Auto Format
    if (this.constructor.isAutoMovilOld(ppu)) {
      return _variables.autoOldFormat;
    }
    // Carro Arrastre Format
    if (this.constructor.isCarroArrastre(ppu)) {
      throw new Error("CARRO DE ARRASTRE no es un formato válido.")
    }
    throw new Error("Ppu no corresponde a ningun formato válido")
  }

  static isAutoMovilNew (ppu) {
    // Validate format XXXX11
    const regexAutomovil = new RegExp(/^[b-d,f-h,j-l,p,r-t,v-z]{2}[\-\. ]?[b-d,f-h,j-l,p,r-t,v-z]{2}[\.\- ]?[0-9]{2}$/, 'i');
    return regexAutomovil.test(ppu);
  }

  static isAutoMovilOld (ppu) {
    // Validate format XX1111
    const regexAutomovil = new RegExp(/^[a-z]{2}[\.\- ]?[0-9]{2}[\.\- ]?[0-9]{2}$/, 'i');
    return regexAutomovil.test(ppu);
  }

  static isMotoOld (ppu) {
    // Validate format XX0111 / XX111 / XXX011 / XXX11
    const regexMoto = new RegExp(/^[a-z]{2}0[0-9]{3}$|^[a-z]{2}[0-9]{3}$/, 'i');
    return regexMoto.test(ppu);
  }

  static isMotoNew (ppu) {
    // Validate format XX0111 / XX111 / XXX011 / XXX11
    const regexMoto = new RegExp(/^[b-d,f-h,j-l,p,r-t,v-z]{3}[0-9]{2}$|^[b-d,f-h,j-l,p,r-t,v-z]{3}0[0-9]{2}$/, 'i');
    return regexMoto.test(ppu);
  }

  static isCarroArrastre (ppu) {
    // Validate format XXX111
    const regexCarroArrastre = new RegExp(/^[a-zA-Z]{3}[1-9]{1}[0-9]{2}$/, 'i');
    return regexCarroArrastre.test(ppu);
  }

  transformInPreNumber (ppu) {
    // Reconocer Typo de transformación por tipo de ppu
    let type = ppu.format.type;
    // Convertir dependiendo el formato
    if ('LLL.NNN' === type || 'LLLL.NN' === type) {
      let ppuToArray = Array.from(ppu.ppu);
      _.each(ppuToArray, (letter, key) => {
        if (!Number.isInteger(parseInt(letter))) {
          ppuToArray[ key ] = parseInt(_letterDvDb[ letter.toUpperCase() ]);
        } else {
          ppuToArray[ key ] = parseInt(letter);
        }
      });
      return ppuToArray
    }
    if ('LL.NNNN' === type) {
      let ppuNumbersAsArray;
      let ppuLetters = ppu.ppu.substring(0, 2);
      let ppuNumbersASstring = ppu.ppu.substring(2, 6);
      let ppuLettersTransformedToNumbersASstring = this.lettersToNumbers(ppuLetters);
      let ppuNumbersAll = ppuLettersTransformedToNumbersASstring + ppuNumbersASstring;

      ppuNumbersAsArray = Array.from(ppuNumbersAll);

      return ppuNumbersAsArray
    }

  }

  lettersToNumbers (ppuLetters) {
    let transformedPpuLetters = _letterDvDb[ ppuLetters ]
    if (typeof transformedPpuLetters === 'string') {
      return transformedPpuLetters;
    } else {
      throw new Error("Letras de Ppu de Auto Antiguo inválidas");
    }
  }

  calculateDv (ppu) {
    // Identificar algoritmo por formato de ppu.
    let format = ppu.format.type;
    if (format === 'LL.NNNN') {
      let S =
        ppu.numbers[ 6 ] * 2 +
        ppu.numbers[ 5 ] * 3 +
        ppu.numbers[ 4 ] * 4 +
        ppu.numbers[ 3 ] * 5 +
        ppu.numbers[ 2 ] * 6 +
        ppu.numbers[ 1 ] * 7 +
        ppu.numbers[ 0 ] * 2;
      let Ri = S % 11;
      let Rf = 11 - Ri;
      if (Rf === 11) return "0";
      if (Rf === 10) return "K";
      if (Rf < 10) return Rf.toString();
    }
    if (format === 'LLL.NNN' || format === 'LLLL.NN') {
      let SP =
        ppu.numbers[ 5 ] * 2 +
        ppu.numbers[ 4 ] * 3 +
        ppu.numbers[ 3 ] * 4 +
        ppu.numbers[ 2 ] * 5 +
        ppu.numbers[ 1 ] * 6 +
        ppu.numbers[ 0 ] * 7;
      let R = SP % 11;
      if (R === 0) return "0";
      let RV = 11 - R;
      if (RV === 10) return "K";
      return RV.toString();
    }
  }
}

export { Ppu };