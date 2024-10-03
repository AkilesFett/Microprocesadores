; Programa en ensamblador Z80 para generar, mostrar y ordenar números pseudo aleatorios

ORG 0000h           ; Dirección inicial del programa
START:
    LD SP, 4000h    ; Inicializar el puntero de la pila
    CALL INICIAR    ; Mostrar mensaje de inicio
    CALL GENERAR_NUMEROS   ; Generar 20 números aleatorios
    CALL MOSTRAR_NUMEROS   ; Mostrar números generados
    CALL PREGUNTAR_ORDEN   ; Preguntar cómo ordenar
    CALL ORDENAR_NUMEROS   ; Ordenar números
    CALL MOSTRAR_NUMEROS_ORDENADOS   ; Mostrar números ordenados
    CALL PREGUNTAR_REPETIR ; Preguntar si repetir o terminar
    JP START        ; Si repite, reinicia desde el inicio

INICIAR:
    ; Mostrar el mensaje de inicio
    LD HL, INICIO_MSG
    CALL MOSTRAR_TEXTO
    RET

GENERAR_NUMEROS:
    ; Generar 20 números pseudo aleatorios
    LD B, 20        ; Número de iteraciones
    LD HL, NUMEROS_GENERADOS ; Puntero al área donde se guardarán los números
GENERAR_LOOP:
    CALL RANDOM     ; Llamada a función para generar número pseudo aleatorio
    LD (HL), A      ; Guardar el número generado en memoria
    INC HL          ; Avanzar al siguiente espacio en memoria
    DJNZ GENERAR_LOOP   ; Repetir 20 veces
    RET

MOSTRAR_NUMEROS:
    ; Mostrar los números generados
    LD HL, NUMEROS_GENERADOS
    LD B, 20
MOSTRAR_LOOP:
    LD A, (HL)
    CALL IMPRIMIR_NUMERO_DECIMAL
    INC HL
    DJNZ MOSTRAR_LOOP
    RET

PREGUNTAR_ORDEN:
    ; Preguntar al usuario cómo ordenar los números
    LD HL, PREGUNTA_ORDEN_MSG
    CALL MOSTRAR_TEXTO
    CALL LEER_TECLADO
    CP 'A'          ; Si es 'A', ordenar ascendente
    JP Z, ORDEN_ASCENDENTE
    CP 'D'          ; Si es 'D', ordenar descendente
    JP Z, ORDEN_DESCENDENTE
    JP PREGUNTAR_ORDEN   ; Si no es válido, preguntar de nuevo

ORDEN_ASCENDENTE:
    ; Ordenar números de forma ascendente
    LD HL, NUMEROS_GENERADOS
    LD DE, NUMEROS_ORDENADOS
    CALL BURBUJA_ASC
    RET

ORDENAR_NUMEROS:
    ; Código de ordenamiento aquí
    RET

ORDEN_DESCENDENTE:
    ; Ordenar números de forma descendente
    LD HL, NUMEROS_GENERADOS
    LD DE, NUMEROS_ORDENADOS
    CALL BURBUJA_DESC
    RET

MOSTRAR_NUMEROS_ORDENADOS:
    ; Mostrar los números ya ordenados
    LD HL, NUMEROS_ORDENADOS
    LD B, 20
MOSTRAR_ORD_LOOP:
    LD A, (HL)
    CALL IMPRIMIR_NUMERO_DECIMAL
    INC HL
    DJNZ MOSTRAR_ORD_LOOP
    RET

PREGUNTAR_REPETIR:
    ; Preguntar si se desea repetir el programa
    LD HL, PREGUNTA_REPETIR_MSG
    CALL MOSTRAR_TEXTO
    CALL LEER_TECLADO
    CP 'S'          ; Si es 'S', repetir
    JP Z, START
    CP 'N'          ; Si es 'N', salir
    JP Z, TERMINAR
    JP PREGUNTAR_REPETIR ; Si no es válido, preguntar de nuevo

TERMINAR:
    ; Mostrar mensaje de salida y finalizar
    LD HL, SALIDA_MSG
    CALL MOSTRAR_TEXTO
    HALT           ; Detener la ejecución

; Funciones auxiliares
RANDOM:
    ; Algoritmo para generar un número pseudo aleatorio
    ; Esta es una implementación simple de un generador lineal congruente
    LD A, (RND_SEED)
    LD HL, 0A001h
    LD D, 75h
    ; Aquí deberás implementar la multiplicación manual, ya que no existe MUL
    ; Como sugerencia, podrías usar sumas repetidas o un algoritmo de bits.
    ; Por ahora, eliminamos MUL:
    ; MUL HL, A (reemplazado con algoritmo manual)
    ADD A, D
    LD (RND_SEED), A
    RET

BURBUJA_ASC:
    ; Implementación del algoritmo de ordenamiento de burbuja (ascendente)
    RET

BURBUJA_DESC:
    ; Implementación del algoritmo de ordenamiento de burbuja (descendente)
    RET

MOSTRAR_TEXTO:
    ; Función para mostrar una cadena de texto en la pantalla
    ; Código específico del simulador OshonSoft para enviar el texto
    RET

IMPRIMIR_NUMERO_DECIMAL:
    ; Función para imprimir el número en formato decimal
    RET

LEER_TECLADO:
    ; Función para leer la entrada del teclado
    RET

; Área de datos
NUMEROS_GENERADOS:   DEFB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
NUMEROS_ORDENADOS:   DEFB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
RND_SEED:            DEFB 0x01 ; Semilla inicial del generador aleatorio

; Mensajes de texto
INICIO_MSG:          DB 'Iniciando la generacion de numeros...', 0
PREGUNTA_ORDEN_MSG:  DB 'Como deseas ordenar los numeros? (A=Ascendente, D=Descendente)', 0
PREGUNTA_REPETIR_MSG: DB 'Deseas repetir el programa? (S=Si, N=No)', 0
SALIDA_MSG:          DB 'Saliendo del programa...', 0

END
