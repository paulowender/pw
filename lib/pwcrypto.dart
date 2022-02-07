import 'pwerrorlog.dart';

class PWCrypto {
  static bool isPar(num n) {
    return n % 2 == 0;
  }

  // Calcular a potencia de um numero
  static int potencia(int numero, int potencia) {
    if (numero == 0) return 0;
    if (potencia == 0) return 1;
    int resultado = 0;
    for (int i = 1; i < potencia; i++) {
      resultado += numero * numero;
    }
    return resultado;
  }

  // Converte uma string em binário
  /// Valores aceitos:
  /// Binary (base 2).
  static String stringToBinary(String string) =>
      stringToRadix(string, radix: 2);

  /// Octal (base 8).
  static String stringToOcto(String string) => stringToRadix(string, radix: 8);

  /// Hexadecimal (base 16).
  static String stringToHex(String string) => stringToRadix(string, radix: 16);

  /// Base 36.
  static String stringToBase36(String string) =>
      stringToRadix(string, radix: 36);

  /// Example:
  /// Binary
  /// print(12.toRadixString(2)); // 1100
  /// print(31.toRadixString(2)); // 11111
  /// Octal
  /// print(12.toRadixString(8)); // 14
  /// print(31.toRadixString(8)); // 37
  /// Hexadecimal
  /// print(12.toRadixString(16)); // c
  /// print(2021.toRadixString(16)); // 7e5
  /// Base 36
  /// print((35 * 36 + 1).toRadixString(36)); // z1
  static String stringToRadix(
    String string, // String a ser convertida
    {
    int radix = 2, // Base da conversão
    String separadorPalavras = " ", // Separador de palavras
    String separadorBits = ".", // Separador de bits
  }) {
    // Lista de palavras
    List palavras = string.trim().split(separadorPalavras);
    // Lista de palavras convertidas
    List palavrasBinario = [];
    // Percorre as palavras
    for (String palavra in palavras) {
      // Lista de bits
      List binLetras = [];
      // Percorre as letras
      for (int i = 0; i < palavra.length; i++) {
        // Converte a letra para binário
        String binLetra = palavra.codeUnitAt(i).toRadixString(radix);
        // Adiciona o bit à lista
        binLetras.add(binLetra);
      }
      // Junta os bits e adiciona a lista de palavras convertidas
      palavrasBinario.add(binLetras.join(separadorBits));
    }
    // Junta as palavras convertidas e retorna
    return palavrasBinario.join(separadorPalavras);
  }

  /// Binary (base 2).
  static String binaryToString(String string) =>
      radixToString(string, radix: 2);

  /// Octal (base 8).
  static String octoToString(String string) => radixToString(string, radix: 8);

  /// Hexadecimal (base 16).
  static String hexToString(String string) => radixToString(string, radix: 16);

  /// Base 36.
  static String base36ToString(String string) =>
      stringToRadix(string, radix: 36);
  // Converte um binário em string
  static String radixToString(
    String string, // String a ser convertida
    {
    int radix = 2, // Base da conversão
    String separadorPalavras = " ", // Separador de palavras
    String separadorBits = ".", // Separador de bits
  }) {
    // Lista de palavras em binário
    List binPalavras = string.trim().split(separadorPalavras);
    // Lista de palavras convertidas
    List palavras = [];
    // Percorre as palavras em binário
    for (String binPalavra in binPalavras) {
      // Lista de bits
      List letras = binPalavra.split(separadorBits);
      // Letra convertida
      String char = "";
      // Percorre os bits
      for (String letra in letras) {
        // Converte o bit para letra
        try {
          char += String.fromCharCode(int.parse(letra, radix: radix));
        } catch (e) {
          PWErrorLog.logError(
              "Erro ao converter o bit '$letra' para letra em radix $radix");
        }
      }
      // Adiciona a letra convertida à lista de palavras convertidas
      palavras.add(char);
    }
    // Junta as palavras convertidas e retorna
    return palavras.join(separadorPalavras);
  }

  // Verifica se é um numero
  static bool isNumero(String numero) {
    try {
      var isDouble = double.tryParse(numero);
      var isInt = int.tryParse(numero);
      return isDouble != null || isInt != null;
    } catch (e) {
      return false;
    }
  }
}
