document.addEventListener('DOMContentLoaded', function() {
    const loginForm = document.getElementById('loginForm');
    loginForm.addEventListener('submit', async function(event) {
        event.preventDefault();
        const correo = document.getElementById('email').value;
        const contrasena = document.getElementById('password').value;

        if (!correo || !contrasena) {
            Swal.fire('Por favor, completa todos los campos.');
            return;
        }

        const response = await fetch('/api/loginGuardia', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ correo, contrasena })
        });

        if (response.ok) {
            const data = await response.json();
            if (data.success) {
                console.log('Tipo de Usuario:', data.tipo_usuario);
                localStorage.setItem('userEmail', correo); // Almacenar el correo del usuario en localStorage
                window.location.href = 'sede.html'; // Redirige a la página adecuada
            } else {
                Swal.fire('Autenticación fallida. Por favor verifica tus credenciales.');
            }
        } else {
            console.error('Error en la autenticación');
            Swal.fire('Error interno del servidor. Por favor, intenta de nuevo más tarde.');
        }
    });
});
