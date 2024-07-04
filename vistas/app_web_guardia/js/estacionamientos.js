// scripts.js
function continuar() {
    alert("Continuar a la próxima página");
}

document.querySelectorAll('.space').forEach(space => {
    space.onclick = () => {
        if (space.classList.contains('available')) {
            space.classList.remove('available');
            space.classList.add('reserved');
            // Actualizar contadores aquí
        } else {
            space.classList.remove('reserved');
            space.classList.add('available');
            // Actualizar contadores aquí
        }
    };
});
