class_name ResourcePath

const RES = "res://"
const GRID_ELEMENTS = RES + "grid_elements/"
const CHARACTERS = GRID_ELEMENTS + "characters/"
const NON_PLAYER = CHARACTERS + "non_player/"
const ALLIES = NON_PLAYER + "allies/"
const ENEMIES = NON_PLAYER + "enemies/"
const NORMAL_ENEMIES = ENEMIES + "normal_enemies/"
const SPECTRES = ENEMIES + "spectres/"
const STATIC_ELEMENTS = GRID_ELEMENTS + "static_elements/"

# TAMBIÉN HAY POR AHÍ UNA ESCENA (EN MAZE)... ASÍ QUE PROBABLEMENTE HAYA QUE CAMBIAR EL NOMBRE DE RESOUCE_PATH, SALVO QUE LAS ESCENAS SEAN RECURSOS...
# MAIN EN SU PROPIA CARPETA
# CREAR items DENTRO DE status_bar
# UN ITEM EXTIENDE TextureRect Y TIENE LAS TEXTURAS COMO CONSTANTES
# POR EJEMPLO CORAZÓN SE CAMBIARÁ ASÍ. i.set_texture = Heart.FULL
# EN EL MAIN HABRÁ QUE COMBINAR UN ENUM JUNTO CON ESTE SISTEMA, CREO...
# case maze => status_bar.add(ArmaContundente.New())
# case hammer => cambiar el sprite del nodo anterior. Pero cómo obtener la referencia?
# supongo que habrá que tener el nodo ya creado en el main, y asociado a una variable?

