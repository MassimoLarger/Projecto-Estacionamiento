document.getElementById('loginForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Previene la recarga de la página por defecto del formulario

    var rut = document.getElementById('rut').value;
    var password = document.getElementById('password').value;
    if (!rut || !password) {
        alert('Por favor, completa todos los campos.');
    } else {
        // Aquí podrías implementar validación adicional o consulta a una API
        window.location.href = '../html/sede.html'; // Redirige a la página de sede
    }
});
