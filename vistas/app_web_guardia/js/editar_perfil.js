document.addEventListener('DOMContentLoaded', function () {
    const timeSlots = document.querySelectorAll('.time-slot');
    timeSlots.forEach(btn => {
        btn.addEventListener('click', function () {
            timeSlots.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
        });
    });
});

function goBack() {
    window.history.back();
}

function openProfile() {
    alert('Abrir perfil de usuario');
}
