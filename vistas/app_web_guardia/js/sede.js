document.addEventListener('DOMContentLoaded', function() {
    var userIcon = document.getElementById('userIcon');
    if (!userIcon) {
      console.error("Ícono de usuario no encontrado.");
    } else {
      userIcon.addEventListener('click', function(event) {
          event.stopPropagation();
          console.log("Ícono de usuario clickeado.");
          Swal.fire({
              title: 'Opciones de Usuario',
              showConfirmButton: false,
              html: `
                <button onclick="editarPerfil()">Editar Perfil</button>
                <button onclick="cerrarSesion()">Cerrar Sesión</button>
              `
          });
      });
    }
});

function editarPerfil() {
    console.log('Función editarPerfil llamada');
    alert('Editar Perfil');
}

function cerrarSesion() {
    console.log('Función cerrarSesion llamada');
    alert('Cerrar Sesión');
}
