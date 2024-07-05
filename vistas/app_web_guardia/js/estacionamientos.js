document.addEventListener('DOMContentLoaded', function() {
    updateCounts(); // Actualizar contadores al cargar la página
});

function continuar() {
    alert('Continuar a la siguiente acción');
}

function updateCounts() {
    const spaces = document.querySelectorAll('.space');
    let reserved = 0;
    let available = 0;
    
    spaces.forEach(space => {
        if (space.classList.contains('reserved')) {
            reserved++;
        } else if (space.classList.contains('available')) {
            available++;
        }
    });

    document.getElementById('reserved-count').textContent = reserved;
    document.getElementById('available-count').textContent = available;
}
