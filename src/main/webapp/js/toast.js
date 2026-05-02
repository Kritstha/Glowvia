
function showToast(message, type = 'success') {
    const existingToast = document.querySelector('.toast-notification');
    if (existingToast) existingToast.remove();
    
    const toast = document.createElement('div');
    toast.className = `toast-notification toast-${type}`;
    toast.innerHTML = `
        <span class="toast-icon">${type === 'success' ? '✓' : '⚠'}</span>
        <span class="toast-message">${message}</span>
        <button class="toast-close">&times;</button>
    `;
    document.body.appendChild(toast);
    
    setTimeout(() => toast.classList.add('show'), 10);
    
    let timeout = setTimeout(() => hideToast(toast), 4000);
    
    const closeBtn = toast.querySelector('.toast-close');
    closeBtn.onclick = () => {
        clearTimeout(timeout);
        hideToast(toast);
    };
    
    toast.onmouseenter = () => clearTimeout(timeout);
    toast.onmouseleave = () => {
        timeout = setTimeout(() => hideToast(toast), 1000);
    };
}



function hideToast(toast) {
    toast.classList.remove('show');
    setTimeout(() => toast.remove(), 300);
}

