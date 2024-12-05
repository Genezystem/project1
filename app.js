const aumentarvolumen = document.querySelectorAll('.plus-vol');
const disminuirvolumen = document.querySelectorAll('.minus-vol');
const objeto = document.getElementById('objeto');

function ActualizarDimensiones() {
    const aumentar = Array.from(aumentarvolumen).filter(cb => cb.checked).length;
    const disminuir = Array.from(disminuirvolumen).filter(cb => cb.checked).length;

    const escala= 1 + (aumentar * 0.2) - (disminuir * 0.2);
    objeto.style.transform = `scale(${Math.max(0.5, Math.min(escala, 2))})`;
}

aumentarvolumen.forEach(cb => cb.addEventListener('change', ActualizarDimensiones));
disminuirvolumen.forEach(cb => cb.addEventListener('change', ActualizarDimensiones));